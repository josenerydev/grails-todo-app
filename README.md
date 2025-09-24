# TODO API - Sistema de Gerenciamento de Tarefas

Sistema completo de gerenciamento de tarefas desenvolvido com **Grails 2.5.6**, incluindo API REST e interface web responsiva.

## 🚀 Funcionalidades

- **CRUD Completo**: Criar, visualizar, editar e excluir tarefas
- **API REST**: Endpoints para integração com outras aplicações
- **Interface Web**: Interface amigável com Bootstrap 3
- **Status e Prioridades**: Controle de status (Pendente/Concluída) e níveis de prioridade (Baixa/Média/Alta)
- **Ações em Lote**: Atualizar múltiplas tarefas simultaneamente
- **API REST Completa**: Endpoints para integração com outras aplicações

## 🛠️ Tecnologias Utilizadas

- **Grails 2.5.6**
- **Groovy 2.4**
- **MySQL 8.0** (via Docker Compose)
- **Bootstrap 3.4.1** (interface web)
- **jQuery 3.6.0**
- **Bootstrap 3.4.1** (interface responsiva)

## 📋 Pré-requisitos

- Java 8 ou superior
- Grails 2.5.6
- Docker e Docker Compose
- Git

## 🚀 Instalação e Configuração

### 1. Clone o repositório
```bash
git clone <url-do-repositorio>
cd todo-api
```

### 2. Inicie o banco de dados MySQL
```bash
docker-compose up -d db
```

### 3. Verifique se o container está rodando
```bash
docker ps
```

### 4. Execute a aplicação
```bash
grails run-app
```

### 5. Acesse a aplicação
- **Interface Web**: http://localhost:8080/todo-api
- **API REST**: http://localhost:8080/todo-api/api/tasks

## 🗄️ Banco de Dados

O sistema utiliza **MySQL 8.0** via Docker Compose com as seguintes configurações:

- **Host**: localhost
- **Porta**: 3306
- **Banco de Desenvolvimento**: todo_dev
- **Usuário**: todo_user
- **Senha**: password

### Comandos Docker Compose

```bash
# Iniciar o banco de dados
docker-compose up -d db

# Parar o banco de dados
docker-compose down

# Ver logs do container
docker-compose logs db

# Acessar o banco via MySQL client
docker exec -it todo-api-mysql mysql -u todo_user -p todo_dev
```

## 🔌 API REST Endpoints

### Operações Básicas

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/tasks` | Listar todas as tarefas |
| GET | `/api/tasks/:id` | Buscar tarefa por ID |
| POST | `/api/tasks` | Criar nova tarefa |
| PUT | `/api/tasks/:id` | Atualizar tarefa |
| DELETE | `/api/tasks/:id` | Excluir tarefa |

### Operações Especiais

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| PATCH | `/api/tasks/:id/status` | Atualizar apenas o status |
| POST | `/tasks/batchUpdateStatus` | Atualizar múltiplas tarefas |

### Exemplos de Uso da API

#### Criar uma nova tarefa
```bash
curl -X POST http://localhost:8080/todo-api/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Nova Tarefa",
    "description": "Descrição da tarefa",
    "priority": "HIGH"
  }'
```

#### Listar todas as tarefas
```bash
curl http://localhost:8080/todo-api/api/tasks
```

#### Atualizar status de uma tarefa
```bash
curl -X PATCH http://localhost:8080/todo-api/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -d '{"status": "COMPLETED"}'
```

## 🚀 Executando a Aplicação

### Modo Desenvolvimento
```bash
grails run-app
```

### Modo Produção
```bash
grails war
```

## 📁 Estrutura do Projeto

```
todo-api/
├── docker-compose.yml              # Configuração do MySQL
├── docker-entrypoint-initdb.d/     # Scripts de inicialização do banco
├── grails-app/
│   ├── conf/
│   │   ├── BuildConfig.groovy      # Dependências e plugins
│   │   ├── DataSource.groovy       # Configuração do banco
│   │   └── UrlMappings.groovy      # Rotas da aplicação
│   ├── controllers/
│   │   └── todoapi/
│   │       ├── TaskController.groovy      # Controller web
│   │       └── TaskRestController.groovy  # Controller REST
│   ├── domain/
│   │   └── todoapi/
│   │       └── Task.groovy         # Classe de domínio
│   ├── services/
│   │   └── todoapi/
│   │       └── TaskService.groovy  # Lógica de negócio
│   ├── views/
│   │   ├── layouts/
│   │   │   └── main.gsp           # Layout principal
│   │   ├── task/                  # Views das tarefas
│   │   └── index.gsp              # Dashboard
└── src/groovy/todoapi/
    ├── TaskStatus.groovy          # Enum de status
    └── TaskPriority.groovy        # Enum de prioridade
```

## 🎯 Modelo de Dados

### Task (Tarefa)
- **id**: Identificador único (Long)
- **title**: Título da tarefa (String, obrigatório, máx. 255 caracteres)
- **description**: Descrição da tarefa (String, opcional, máx. 1000 caracteres)
- **status**: Status da tarefa (TaskStatus: PENDING, COMPLETED)
- **priority**: Prioridade da tarefa (TaskPriority: LOW, MEDIUM, HIGH)
- **dateCreated**: Data de criação (Date, automático)
- **lastUpdated**: Data da última atualização (Date, automático)

## 🔧 Configuração de Desenvolvimento

### Variáveis de Ambiente

O sistema utiliza as seguintes configurações de banco de dados:

- **Desenvolvimento**: MySQL via Docker Compose
- **Teste**: MySQL via TestContainers
- **Produção**: Configurável via variáveis de ambiente

### Dependências Principais

```groovy
dependencies {
    runtime 'mysql:mysql-connector-java:8.0.33'
}
```

## 🐛 Solução de Problemas

### Erro de Conexão com MySQL
1. Verifique se o Docker está rodando
2. Execute `docker-compose up -d db`
3. Verifique se a porta 3306 está disponível

### Erro de Dependências
1. Execute `grails clean`
2. Execute `grails refresh-dependencies`
3. Execute `grails run-app`

### Problemas de Performance
1. Verifique se o banco de dados está otimizado
2. Execute `grails clean` para limpar cache
3. Verifique se as dependências estão atualizadas

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📞 Suporte

Para suporte ou dúvidas, abra uma issue no repositório do projeto.
