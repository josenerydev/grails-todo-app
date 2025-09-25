# TODO API - Testes Automatizados com Spock Framework

## Visão Geral

Implementação de testes automatizados para a aplicação TODO API usando Spock Framework, focando em testes de unidade e integração para validar a funcionalidade completa do sistema de gerenciamento de tarefas.

## Clarifications

### Session 2025-01-24
- Q: Escopo dos testes de integração → A: Testes completos de API REST (endpoints + banco)
- Q: Cobertura de cenários de erro → A: Erros básicos + validação de dados de entrada
- Q: Estratégia de dados de teste → A: TestContainers com dados aleatórios
- Q: Configuração do Spock Framework → A: Spock + plugins de integração (TestContainers, etc.)
- Q: Estrutura de organização dos testes → A: Estrutura simples (unit/ e integration/)

## Functional Requirements

### Core Testing Goals
- Implementar testes de unidade para todas as classes de domínio, serviços e controladores
- Implementar testes de integração completos para API REST com TestContainers
- Garantir cobertura mínima de 80% para lógica de negócio
- Validar todos os endpoints REST existentes (GET, POST, PUT, DELETE, PATCH)

### API Testing Scope
- **Endpoints REST**: `/api/tasks` (CRUD completo)
- **Operações Especiais**: `/api/tasks/:id/status` (PATCH), `/tasks/batchUpdateStatus` (POST)
- **Validação de Dados**: Títulos obrigatórios, descrições opcionais, status e prioridades válidos
- **Cenários de Erro**: 404 (não encontrado), 400 (dados inválidos), 500 (erro interno)

### Data Model Testing
- **Task Domain**: Validação de constraints, mapeamento de tabela, relacionamentos
- **Enums**: TaskStatus (PENDING, COMPLETED) e TaskPriority (LOW, MEDIUM, HIGH)
- **Transações**: Rollback em caso de erro, persistência correta

## Non-Functional Requirements

### Performance & Scalability
- Testes de integração devem executar em menos de 30 segundos
- TestContainers deve inicializar banco em menos de 10 segundos
- Suporte a execução paralela de testes

### Reliability & Quality
- Cobertura mínima de 80% para lógica de negócio
- Todos os testes devem ser determinísticos e reproduzíveis
- Isolamento completo entre testes (dados limpos por teste)

### Technology Stack
- **Spock Framework**: 1.3-groovy-2.4 (compatível com Groovy 2.4)
- **TestContainers**: Para testes de integração com MySQL
- **Grails 2.5.6**: Framework base da aplicação
- **MySQL 8.0**: Banco de dados via Docker

## Test Organization

### Directory Structure
```
test/
├── unit/
│   └── todoapi/
│       ├── TaskSpec.groovy
│       ├── TaskServiceSpec.groovy
│       ├── TaskControllerSpec.groovy
│       ├── TaskRestControllerSpec.groovy
│       ├── TaskStatusSpec.groovy
│       └── TaskPrioritySpec.groovy
└── integration/
    └── todoapi/
        ├── TaskIntegrationSpec.groovy
        ├── TaskRestApiSpec.groovy
        └── resources/
            └── test-data.sql
```

### Test Categories
- **Unit Tests**: Lógica isolada com mocking de dependências
- **Integration Tests**: Validação de contratos entre camadas com banco real
- **API Tests**: Testes completos de endpoints REST
- **Data Tests**: Validação de persistência e transações

## Edge Cases & Error Handling

### Validation Scenarios
- Título vazio ou nulo (deve falhar)
- Título com mais de 255 caracteres (deve falhar)
- Descrição com mais de 1000 caracteres (deve falhar)
- Status inválido (deve falhar)
- Prioridade inválida (deve falhar)

### API Error Scenarios
- Tarefa não encontrada (404)
- Dados de entrada inválidos (400)
- Erro interno do servidor (500)
- Método não permitido (405)

### Database Scenarios
- Transações com rollback
- Concorrência em operações de lote
- Dados duplicados (se aplicável)

## Constraints & Tradeoffs

### Technical Constraints
- **Grails 2.5.6**: Versão fixa, não atualizar
- **Groovy 2.4**: Compatibilidade obrigatória
- **Java 8**: Requisito mínimo
- **MySQL 8.0**: Banco de dados via Docker Compose

### Testing Constraints
- TestContainers para isolamento de banco
- Dados aleatórios para evitar dependências
- Estrutura simples de diretórios
- Configuração mínima mas funcional

## Completion Signals

### Definition of Done
- [ ] Todos os testes de unidade implementados e passando
- [ ] Todos os testes de integração implementados e passando
- [ ] Cobertura de código >= 80%
- [ ] TestContainers configurado e funcionando
- [ ] Dados de teste aleatórios implementados
- [ ] Documentação de execução dos testes atualizada

### Acceptance Criteria
- Testes executam via `grails test-app`
- Testes de integração usam TestContainers
- Cobertura de testes reportada
- Todos os endpoints REST testados
- Cenários de erro validados
