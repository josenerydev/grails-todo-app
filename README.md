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

# Todos os testes
grails test-app
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
└── test/unit/todoapi/           # Testes unitários
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
