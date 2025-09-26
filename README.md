# TODO API - PoC de Sistema de Gerenciamento de Tarefas

Sistema de gerenciamento de tarefas desenvolvido com Grails 2.5.6, incluindo API REST e interface web.

## Funcionalidades

- **CRUD de tarefas** - Criação, leitura, atualização e exclusão de tarefas
- **API REST** - Endpoints RESTful para integração com outros sistemas
- **Interface web** - Interface gráfica para gerenciamento de tarefas
- **Status e prioridades** - Controle de status (PENDING, COMPLETED) e prioridades (LOW, MEDIUM, HIGH)
- **Ações em lote** - Atualização de status de múltiplas tarefas simultaneamente
- **Validação de dados** - Validação automática de campos obrigatórios e formatos
- **Testes automatizados** - Cobertura completa com testes unitários e de integração

## Tecnologias

- **Grails 2.5.6** - Framework web para Groovy
- **Groovy 2.4** - Linguagem de programação
- **MySQL 8.0** - Banco de dados (via Docker)
- **Bootstrap 3** - Framework CSS para interface
- **Spock Framework** - Framework de testes
- **TestContainers** - Testes de integração com containers
- **Docker** - Containerização e ambiente de desenvolvimento

## Pré-requisitos

- Java 8+
- Grails 2.5.6
- Docker

## Setup via SDKMAN

### Instalação do SDKMAN

```bash
# Instalar SDKMAN
curl -s "https://get.sdkman.io" | bash

# Recarregar o terminal ou executar
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

### Instalação do Java e Grails

```bash
# Instalar Java 8 (versão compatível com Grails 2.5.6)
sdk install java 8.0.442-tem

# Instalar Grails 2.5.6
sdk install grails 2.5.6

# Verificar instalações
java -version
grails -version
```

### Configuração do Ambiente

```bash
# Definir versões padrão (opcional)
sdk default java 8.0.442-tem
sdk default grails 2.5.6

# Listar versões instaladas
sdk list java
sdk list grails
```

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
│   ├── controllers/todoapi/     # Controllers (TaskController, TaskRestController)
│   ├── domain/todoapi/          # Domínio (Task)
│   ├── services/todoapi/        # Serviços (TaskService)
│   └── views/                   # Views
├── src/groovy/todoapi/          # Enums (TaskStatus, TaskPriority)
├── test/
│   ├── unit/todoapi/            # Testes unitários
│   └── integration/todoapi/     # Testes de integração
└── specs/                       # Especificações e documentação
```

## Serviços Implementados

### TaskService
Serviço principal para gerenciamento de operações de negócio relacionadas às tarefas:

- `listAllTasks()` - Lista todas as tarefas
- `getTaskById(Long id)` - Busca tarefa por ID
- `createTask(Map params)` - Cria nova tarefa
- `updateTask(Long id, Map params)` - Atualiza tarefa existente
- `deleteTask(Long id)` - Exclui tarefa

## Modelo de Dados

**Task (Tarefa)**
- id: Long (PK)
- title: String (obrigatório, máx. 255)
- description: String (opcional, máx. 1000)
- status: TaskStatus (PENDING, COMPLETED)
- priority: TaskPriority (LOW, MEDIUM, HIGH)
- dateCreated: Date
- lastUpdated: Date
