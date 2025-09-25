# TODO API - POC Grails 2.5.6 Constitution

<!-- Sync Impact Report:
Version change: 0.0.0 → 1.0.0
Modified principles: N/A (initial creation)
Added sections: Legacy System Constraints, Spock Testing Framework, Docker Integration
Removed sections: N/A
Templates requiring updates: ✅ constitution.md / ⚠ pending (plan-template.md, spec-template.md, tasks-template.md)
Follow-up TODOs: N/A
-->

## Core Principles

### I. Test-First Development (NON-NEGOTIABLE)
TDD obrigatório para toda funcionalidade: Escrever testes → Aprovação do usuário → Testes falham → Implementar → Refatorar. Ciclo Red-Green-Refactor estritamente aplicado. Todos os testes devem ser escritos usando Spock Framework antes da implementação.

### II. Spock Framework Testing Standards
Todos os testes de unidade DEVEM usar Spock Framework. Testes de unidade para lógica de negócio isolada com mocking de dependências. Estrutura Given-When-Then obrigatória para legibilidade e manutenibilidade.

### III. Legacy System Preservation
Esta é uma POC de sistema legado Grails 2.5.6. Manter compatibilidade com versões antigas é prioritário. Mudanças breaking devem ser justificadas e documentadas. Preservar funcionalidades existentes durante refatorações.

### IV. Docker-First Infrastructure
Banco de dados MySQL via Docker Compose é obrigatório para desenvolvimento. Ambiente de desenvolvimento deve ser reproduzível via `docker-compose up -d db` e `grails run-app`. Testes de unidade não requerem banco de dados.

### V. API Contract Stability
Endpoints REST existentes devem manter compatibilidade. Novos endpoints seguem padrões RESTful. Versionamento de API quando necessário. Documentação de contratos obrigatória.

## Legacy System Constraints

### Technology Stack Requirements
- **Grails 2.5.6** (versão fixa, não atualizar)
- **Groovy 2.4** (compatibilidade com Grails 2.5.6)
- **Java 8** (requisito mínimo para Grails 2.5.6)
- **MySQL 8.0** (via Docker Compose)
- **Spock Framework 1.3-groovy-2.4** (compatível com Groovy 2.4)

### Database Migration Strategy
Mudanças no banco devem usar Grails Database Migration Plugin. Scripts de migração obrigatórios para todas as alterações de schema. Rollback deve ser sempre possível.

## Spock Testing Framework

### Unit Testing Requirements
- Testes de unidade para Services, Controllers e Domain classes
- Mocking de dependências externas obrigatório
- Cobertura mínima de 80% para lógica de negócio
- Estrutura Given-When-Then em todos os testes

### Unit Testing Requirements
- Testes de unidade para validação de lógica de negócio
- Mocking de dependências para isolamento
- Testes de validação de constraints e regras
- Validação de métodos de serviços e controladores

### Test Organization
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

## Development Workflow

### Code Quality Gates
- Todos os testes DEVEM passar antes do commit
- Cobertura de testes mínima de 80%
- Linting com Grails CodeNarc (se configurado)
- Code review obrigatório para mudanças em Services e Controllers

### Testing Workflow
1. Escrever teste Spock unitário (Given-When-Then)
2. Executar teste (deve falhar)
3. Verificar funcionalidade existente
4. Refatorar mantendo testes passando
5. Executar suite completa de testes unitários

### Docker Development Environment
- Banco sempre via `docker-compose up -d db`
- Aplicação via `grails run-app`
- Testes de unidade sem dependência de banco
- Logs centralizados via Docker Compose

## Governance

Esta constituição supera todas as outras práticas do projeto. Emendas requerem documentação, aprovação e plano de migração. Todos os PRs/reviews devem verificar conformidade. Complexidade deve ser justificada. Use README.md para orientação de desenvolvimento em tempo de execução.

**Version**: 1.0.0 | **Ratified**: 2025-01-24 | **Last Amended**: 2025-01-24