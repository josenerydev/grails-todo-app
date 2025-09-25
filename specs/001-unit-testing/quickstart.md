# Quickstart: TODO API Testing

## Pré-requisitos

- Java 8 ou superior
- Grails 2.5.6
- Docker e Docker Compose
- Git

## Configuração do Ambiente

### 1. Iniciar o Banco de Dados
```bash
# Iniciar MySQL via Docker Compose
docker-compose up -d db

# Verificar se o container está rodando
docker ps
```

### 2. Executar a Aplicação
```bash
# Executar a aplicação Grails
grails run-app
```

### 3. Verificar se a Aplicação está Funcionando
- **Interface Web**: http://localhost:8080/todo-api
- **API REST**: http://localhost:8080/todo-api/api/tasks

## Executando os Testes

### 1. Executar Todos os Testes
```bash
# Executar todos os testes (unit + integration)
grails test-app

# Executar apenas testes de unidade
grails test-app unit:

# Executar apenas testes de integração
grails test-app integration:
```

### 2. Executar Testes Específicos
```bash
# Executar teste específico
grails test-app -Dtest.single=TaskServiceSpec

# Executar testes de uma classe específica
grails test-app -Dtest.single=TaskRestControllerSpec
```

### 3. Executar com Cobertura
```bash
# Executar testes com relatório de cobertura
grails test-app -coverage
```

## Validação dos Testes

### 1. Testes de Unidade
Os testes de unidade validam:
- ✅ Criação de tarefas com dados válidos
- ✅ Validação de constraints (título obrigatório, tamanhos máximos)
- ✅ Operações CRUD básicas
- ✅ Enums TaskStatus e TaskPriority
- ✅ Mocking de dependências

### 2. Testes de Integração
Os testes de integração validam:
- ✅ Conexão com banco de dados via TestContainers
- ✅ Persistência e recuperação de dados
- ✅ Transações e rollback
- ✅ Operações em lote

### 3. Testes de API REST
Os testes de API validam:
- ✅ GET /api/tasks - Listar todas as tarefas
- ✅ GET /api/tasks/:id - Buscar tarefa por ID
- ✅ POST /api/tasks - Criar nova tarefa
- ✅ PUT /api/tasks/:id - Atualizar tarefa
- ✅ DELETE /api/tasks/:id - Excluir tarefa
- ✅ PATCH /api/tasks/:id/status - Atualizar status
- ✅ POST /tasks/batchUpdateStatus - Atualizar múltiplas tarefas

## Cenários de Teste

### 1. Cenários de Sucesso
```bash
# Criar tarefa válida
curl -X POST http://localhost:8080/todo-api/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Tarefa de Teste", "priority": "HIGH"}'

# Listar todas as tarefas
curl http://localhost:8080/todo-api/api/tasks

# Atualizar status
curl -X PATCH http://localhost:8080/todo-api/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -d '{"status": "COMPLETED"}'
```

### 2. Cenários de Erro
```bash
# Tarefa não encontrada (404)
curl http://localhost:8080/todo-api/api/tasks/999

# Dados inválidos (400)
curl -X POST http://localhost:8080/todo-api/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": ""}'

# Status inválido (400)
curl -X PATCH http://localhost:8080/todo-api/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -d '{"status": "INVALID"}'
```

## Estrutura dos Testes

### Testes de Unidade
```
test/unit/todoapi/
├── TaskSpec.groovy              # Testes do domain Task
├── TaskServiceSpec.groovy       # Testes do TaskService
├── TaskControllerSpec.groovy    # Testes do TaskController
├── TaskRestControllerSpec.groovy # Testes do TaskRestController
├── TaskStatusSpec.groovy        # Testes do enum TaskStatus
└── TaskPrioritySpec.groovy      # Testes do enum TaskPriority
```

### Testes de Integração
```
test/integration/todoapi/
├── TaskIntegrationSpec.groovy   # Testes de integração com banco
├── TaskRestApiSpec.groovy       # Testes completos da API REST
└── resources/
    └── test-data.sql            # Dados de teste (se necessário)
```

## Verificação de Qualidade

### 1. Cobertura de Código
- **Meta**: Mínimo 80% de cobertura
- **Verificação**: `grails test-app -coverage`
- **Relatório**: `target/test-reports/cobertura/index.html`

### 2. Performance dos Testes
- **Testes de Unidade**: < 5 segundos
- **Testes de Integração**: < 30 segundos
- **TestContainers**: < 10 segundos para inicializar

### 3. Isolamento dos Testes
- Cada teste é independente
- Dados são limpos entre testes
- TestContainers garante isolamento de banco

## Solução de Problemas

### 1. Erro de Conexão com MySQL
```bash
# Verificar se o Docker está rodando
docker ps

# Reiniciar o container
docker-compose restart db

# Verificar logs
docker-compose logs db
```

### 2. Testes Falhando
```bash
# Limpar e recompilar
grails clean
grails compile

# Executar testes com debug
grails test-app --debug
```

### 3. Problemas com TestContainers
```bash
# Verificar se o Docker está acessível
docker run hello-world

# Limpar containers de teste
docker system prune -f
```

## Próximos Passos

1. **Executar todos os testes** para verificar funcionamento
2. **Verificar cobertura** para garantir qualidade
3. **Executar cenários de API** para validar endpoints
4. **Implementar novos testes** conforme necessário
5. **Integrar com CI/CD** para automação
