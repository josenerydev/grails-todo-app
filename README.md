# TODO API - PoC de Sistema de Gerenciamento de Tarefas

Sistema de gerenciamento de tarefas desenvolvido com Grails 2.5.6, incluindo API REST e interface web.

## Funcionalidades

- CRUD de tarefas
- API REST
- Interface web
- Status e prioridades
- Ações em lote

## Tecnologias

- Grails 2.5.6
- Groovy 2.4
- MySQL 8.0 (Docker)
- Bootstrap 3

## Pré-requisitos

- Java 8+
- Grails 2.5.6
- Docker

## Instalação

```bash
# Clone o repositório
git clone <url-do-repositorio>
cd todo-api

# Inicie o banco de dados
docker-compose up -d db

# Execute a aplicação
grails run-app
```

## Comandos Makefile

O projeto inclui um Makefile com comandos úteis para desenvolvimento e testes:

```bash
# Ver todos os comandos disponíveis
make help

# Desenvolvimento
make dev-up     # Inicia ambiente de desenvolvimento
make dev-down   # Para ambiente de desenvolvimento

# Testes
make test      # Executa todos os testes (unitários + integração)
make test-unit # Executa apenas testes unitários

# Utilitários
make clean      # Limpa containers e volumes
make logs       # Mostra logs do container de teste
```

## Acesso

- Interface Web: http://localhost:8080/todo-api
- API REST: http://localhost:8080/todo-api/api/tasks

## Banco de Dados

MySQL 8.0 via Docker:
- Host: localhost:3306
- Banco: todo_dev
- Usuário: todo_user
- Senha: password

## API REST

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/tasks` | Listar tarefas |
| GET | `/api/tasks/:id` | Buscar tarefa |
| POST | `/api/tasks` | Criar tarefa |
| PUT | `/api/tasks/:id` | Atualizar tarefa |
| DELETE | `/api/tasks/:id` | Excluir tarefa |
| PATCH | `/api/tasks/:id/status` | Atualizar status |
| POST | `/tasks/batchUpdateStatus` | Atualizar múltiplas tarefas |

### Exemplo de Uso

```bash
# Criar tarefa
curl -X POST http://localhost:8080/todo-api/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Nova Tarefa", "priority": "HIGH"}'

# Listar tarefas
curl http://localhost:8080/todo-api/api/tasks
```

## Executando

```bash
# Desenvolvimento
grails run-app

# Produção
grails war
```

## Testes

```bash
# Testes unitários com cobertura
grails test-app unit: -coverage

# Testes de integração com TestContainers
grails test-app integration: -coverage

# Todos os testes (unitários + integração)
grails test-app -coverage

# Executar apenas testes de integração específicos
grails test-app integration:todoapi.TaskCrudIntegrationSpec
grails test-app integration:todoapi.TaskValidationIntegrationSpec
grails test-app integration:todoapi.TaskBatchIntegrationSpec
grails test-app integration:todoapi.TaskApiIntegrationSpec
```

## Testes de Integração

Os testes de integração utilizam TestContainers para criar um ambiente isolado com MySQL 8.0, garantindo que os testes sejam executados contra um banco de dados real.

### Características dos Testes de Integração

- **TestContainers**: MySQL 8.0 via Docker
- **Spock Framework**: Estrutura Given-When-Then
- **Isolamento**: Cada classe de teste tem seu próprio container
- **Performance**: Execução em <30 segundos
- **Cobertura**: Testa todos os endpoints da API REST

### Tipos de Testes

1. **CRUD Integration Tests** (`TaskCrudIntegrationSpec`)
   - Listar tarefas
   - Criar tarefa
   - Buscar tarefa
   - Atualizar tarefa
   - Excluir tarefa

2. **Validation Integration Tests** (`TaskValidationIntegrationSpec`)
   - Validação de dados de entrada
   - Validação de status e prioridade
   - Tratamento de erros HTTP

3. **Batch Operations Tests** (`TaskBatchIntegrationSpec`)
   - Atualização de status em lote
   - Validação de operações em lote

4. **Contract Tests** (`TaskApiIntegrationSpec`)
   - Conformidade com contrato OpenAPI
   - Estrutura de respostas JSON
   - Códigos de status HTTP

### Executando Testes de Integração

```bash
# Todos os testes de integração
grails test-app integration: -coverage

# Teste específico
grails test-app integration:todoapi.TaskCrudIntegrationSpec

# Com logs detalhados
grails test-app integration: -coverage -verbose

# Apenas testes que falharam
grails test-app integration: -coverage -rerun
```

## Estrutura do Projeto

```
todo-api/
├── docker-compose.yml
├── grails-app/
│   ├── conf/                    # Configurações
│   ├── controllers/todoapi/     # Controllers
│   ├── domain/todoapi/          # Domínio
│   ├── services/todoapi/        # Serviços
│   └── views/                   # Views
├── src/groovy/todoapi/          # Enums
├── test/
│   ├── unit/todoapi/            # Testes unitários
│   └── integration/todoapi/     # Testes de integração
└── specs/                       # Especificações e documentação
```

## Modelo de Dados

**Task (Tarefa)**
- id: Long (PK)
- title: String (obrigatório, máx. 255)
- description: String (opcional, máx. 1000)
- status: TaskStatus (PENDING, COMPLETED)
- priority: TaskPriority (LOW, MEDIUM, HIGH)
- dateCreated: Date
- lastUpdated: Date
