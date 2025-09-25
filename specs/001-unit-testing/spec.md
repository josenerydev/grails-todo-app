# TODO API - Testes de Unidade com Spock Framework

## Visão Geral

Implementação de testes de unidade para a aplicação TODO API usando Spock Framework, focando em validação da lógica de negócio e funcionalidades das classes de domínio, serviços e controladores.

## Clarifications

### Session 2025-01-24
- Q: Escopo dos testes → A: Apenas testes de unidade (simplificado)
- Q: Cobertura de cenários de erro → A: Erros básicos + validação de dados de entrada
- Q: Estratégia de dados de teste → A: Dados aleatórios com factories
- Q: Configuração do Spock Framework → A: Spock core apenas
- Q: Estrutura de organização dos testes → A: Apenas test/unit/

## Functional Requirements

### Core Testing Goals
- Implementar testes de unidade para todas as classes de domínio, serviços e controladores
- Garantir cobertura mínima de 80% para lógica de negócio
- Validar funcionalidades das classes existentes com mocking
- Testar validações e regras de negócio isoladamente

### Unit Testing Scope
- **Task Domain**: Validação de constraints, métodos de negócio
- **TaskService**: Lógica de CRUD, validações, operações em lote
- **TaskController**: Ações web, conversão de parâmetros, redirecionamentos
- **TaskRestController**: Endpoints REST, serialização JSON, tratamento de erros
- **Enums**: TaskStatus e TaskPriority com displayName e toString()

### Data Model Testing
- **Task Domain**: Validação de constraints, métodos de negócio
- **Enums**: TaskStatus (PENDING, COMPLETED) e TaskPriority (LOW, MEDIUM, HIGH)
- **Validações**: Títulos obrigatórios, tamanhos máximos, valores válidos

## Non-Functional Requirements

### Performance & Scalability
- Testes de unidade devem executar em menos de 5 segundos
- Suporte a execução paralela de testes
- Execução rápida para feedback imediato

### Reliability & Quality
- Cobertura mínima de 80% para lógica de negócio
- Todos os testes devem ser determinísticos e reproduzíveis
- Isolamento completo entre testes (mocking de dependências)

### Technology Stack
- **Spock Framework**: 1.3-groovy-2.4 (compatível com Groovy 2.4)
- **Grails 2.5.6**: Framework base da aplicação
- **Mocking**: Spock mocking + Geb para isolamento de dependências
- **Database Mocking**: H2 in-memory + GORM mocking para testes de unidade

## Test Organization

### Directory Structure
```
test/
└── unit/
    └── todoapi/
        ├── TaskSpec.groovy
        ├── TaskServiceSpec.groovy
        ├── TaskControllerSpec.groovy
        ├── TaskRestControllerSpec.groovy
        ├── TaskStatusSpec.groovy
        ├── TaskPrioritySpec.groovy
        └── TaskTestFactory.groovy
```

### Test Categories
- **Unit Tests**: Lógica isolada com mocking de dependências
- **Domain Tests**: Validação de constraints e métodos de negócio com H2 in-memory
- **Service Tests**: Lógica de CRUD e operações de negócio com GORM mocking
- **Controller Tests**: Ações web e REST com mocking de serviços

## Edge Cases & Error Handling

### Validation Scenarios
- Título vazio ou nulo (deve falhar)
- Título com mais de 255 caracteres (deve falhar)
- Descrição com mais de 1000 caracteres (deve falhar)
- Status inválido (deve falhar)
- Prioridade inválida (deve falhar)

### Controller Error Scenarios
- Parâmetros inválidos (400)
- Tarefa não encontrada (404)
- Erro interno do servidor (500)
- Validação de dados de entrada

### Service Error Scenarios
- Validação de constraints
- Operações em lote com falhas parciais
- Tratamento de exceções

## Constraints & Tradeoffs

### Technical Constraints
- **Grails 2.5.6**: Versão fixa, não atualizar
- **Groovy 2.4**: Compatibilidade obrigatória
- **Java 8**: Requisito mínimo
- **MySQL 8.0**: Banco de dados via Docker Compose

### Testing Constraints
- Mocking de dependências para isolamento
- H2 in-memory para testes de domínio
- GORM mocking para testes de serviço
- Dados aleatórios para evitar dependências
- Estrutura simples de diretórios
- Configuração mínima mas funcional

## Completion Signals

### Definition of Done
- [ ] Todos os testes de unidade implementados e passando
- [ ] Dados de teste aleatórios implementados
- [ ] Mocking de dependências configurado (Spock + Geb)
- [ ] H2 in-memory configurado para testes de domínio
- [ ] GORM mocking configurado para testes de serviço
- [ ] Foco no essencial - sem tarefas de polish

### Acceptance Criteria
- Testes executam via `grails test-app unit:`
- Todas as classes testadas com mocking
- H2 in-memory para testes de domínio
- GORM mocking para testes de serviço
- Cenários de erro validados
- Execução rápida (< 5 segundos)
- Escopo simplificado - foco no essencial
