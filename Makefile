# Makefile para Todo API - Grails 2.5.6
# Comandos disponíveis: make help

.PHONY: help test-up test-down test-wait test-integration test-clean dev-up dev-down clean all-tests

# Variáveis
DOCKER_COMPOSE_TEST = docker-compose -f docker-compose.test.yml
DOCKER_COMPOSE_DEV = docker-compose -f docker-compose.yml
MYSQL_CONTAINER = todo-mysql-test
MAX_ATTEMPTS = 30

# Cores para output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

# Comando padrão
.DEFAULT_GOAL := help

help: ## Mostra esta ajuda
	@echo "$(BLUE)=== TODO API - COMANDOS DISPONÍVEIS ===$(NC)"
	@echo ""
	@echo "$(GREEN)Desenvolvimento:$(NC)"
	@echo "  make dev-up     - Inicia ambiente de desenvolvimento"
	@echo "  make dev-down   - Para ambiente de desenvolvimento"
	@echo ""
	@echo "$(GREEN)Testes:$(NC)"
	@echo "  make test      - Executa todos os testes (unitários + integração)"
	@echo "  make test-unit - Executa apenas testes unitários"
	@echo ""
	@echo "$(GREEN)Utilitários:$(NC)"
	@echo "  make clean      - Limpa todos os containers e volumes"
	@echo "  make logs       - Mostra logs do container de teste"
	@echo ""

# ===========================================
# AMBIENTE DE DESENVOLVIMENTO
# ===========================================

dev-up: ## Inicia ambiente de desenvolvimento
	@echo "$(BLUE)=== INICIANDO AMBIENTE DE DESENVOLVIMENTO ===$(NC)"
	@if [ -f docker-compose.yml ]; then \
		$(DOCKER_COMPOSE_DEV) up -d; \
		echo "$(GREEN)Ambiente de desenvolvimento iniciado!$(NC)"; \
	else \
		echo "$(YELLOW)Arquivo docker-compose.yml não encontrado. Iniciando apenas Grails...$(NC)"; \
		grails run-app; \
	fi

dev-down: ## Para ambiente de desenvolvimento
	@echo "$(BLUE)=== PARANDO AMBIENTE DE DESENVOLVIMENTO ===$(NC)"
	@if [ -f docker-compose.yml ]; then \
		$(DOCKER_COMPOSE_DEV) down; \
		echo "$(GREEN)Ambiente de desenvolvimento parado!$(NC)"; \
	else \
		echo "$(YELLOW)Arquivo docker-compose.yml não encontrado.$(NC)"; \
	fi

# ===========================================
# CONTAINER DE TESTE
# ===========================================

test-up: ## Inicia container de teste MySQL
	@echo "$(BLUE)=== INICIANDO CONTAINER DE TESTE ===$(NC)"
	@$(DOCKER_COMPOSE_TEST) up -d
	@if [ $$? -eq 0 ]; then \
		echo "$(GREEN)Container de teste iniciado!$(NC)"; \
		$(MAKE) test-wait; \
	else \
		echo "$(RED)ERRO: Falha ao iniciar container de teste$(NC)"; \
		exit 1; \
	fi

test-down: ## Para e remove container de teste
	@echo "$(BLUE)=== PARANDO CONTAINER DE TESTE ===$(NC)"
	@$(DOCKER_COMPOSE_TEST) down
	@echo "$(GREEN)Container de teste parado e removido!$(NC)"

test-wait: ## Aguarda MySQL estar pronto (usado internamente)
	@echo "$(YELLOW)Aguardando MySQL estar pronto...$(NC)"
	@sleep 20
	@echo "$(YELLOW)Verificando se MySQL está rodando...$(NC)"
	@ATTEMPT=1; \
	while [ $$ATTEMPT -le $(MAX_ATTEMPTS) ]; do \
		echo "Tentativa $$ATTEMPT/$(MAX_ATTEMPTS)..."; \
		if docker exec $(MYSQL_CONTAINER) mysqladmin ping -h localhost -u root -ppassword > /dev/null 2>&1; then \
			echo "$(GREEN)MySQL está rodando!$(NC)"; \
			break; \
		fi; \
		if [ $$ATTEMPT -eq $(MAX_ATTEMPTS) ]; then \
			echo "$(RED)ERRO: MySQL não está respondendo após $(MAX_ATTEMPTS) tentativas$(NC)"; \
			exit 1; \
		fi; \
		sleep 2; \
		ATTEMPT=$$((ATTEMPT + 1)); \
	done

# ===========================================
# TESTES
# ===========================================

test: test-up ## Executa todos os testes (unitários + integração)
	@echo "$(BLUE)=== EXECUTANDO TODOS OS TESTES ===$(NC)"
	@grails clean
	@grails test-app -coverage
	@TEST_RESULT=$$?; \
	if [ $$TEST_RESULT -eq 0 ]; then \
		echo "$(GREEN)Todos os testes executados com sucesso!$(NC)"; \
		echo "$(BLUE)Relatório de cobertura: target/test-reports/cobertura/index.html$(NC)"; \
	else \
		echo "$(RED)Testes falharam com código: $$TEST_RESULT$(NC)"; \
	fi; \
	$(MAKE) test-down; \
	exit $$TEST_RESULT

test-unit: ## Executa apenas testes unitários
	@echo "$(BLUE)=== EXECUTANDO TESTES UNITÁRIOS ===$(NC)"
	@echo "$(YELLOW)Executando grails clean...$(NC)"
	@grails clean
	@echo "$(YELLOW)Executando testes unitários com cobertura...$(NC)"
	@grails test-app unit: -coverage
	@TEST_RESULT=$$?; \
	if [ $$TEST_RESULT -eq 0 ]; then \
		echo "$(GREEN)Testes unitários executados com sucesso!$(NC)"; \
		echo "$(BLUE)Relatório de cobertura: target/test-reports/cobertura/index.html$(NC)"; \
	else \
		echo "$(RED)Testes unitários falharam com código: $$TEST_RESULT$(NC)"; \
	fi; \
	exit $$TEST_RESULT


# ===========================================
# UTILITÁRIOS
# ===========================================

logs: ## Mostra logs do container de teste
	@echo "$(BLUE)=== LOGS DO CONTAINER DE TESTE ===$(NC)"
	@$(DOCKER_COMPOSE_TEST) logs -f

clean: test-down ## Limpa todos os containers e volumes
	@echo "$(BLUE)=== LIMPANDO TUDO ===$(NC)"
	@docker system prune -f
	@echo "$(GREEN)Limpeza concluída!$(NC)"

# ===========================================
# COMANDOS COMPOSTOS
# ===========================================

# ===========================================
# TRAP PARA LIMPEZA EM CASO DE ERRO
# ===========================================

# Nota: O trap do bash não funciona diretamente no Makefile
# A limpeza é feita manualmente nos targets que precisam
