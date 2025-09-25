# TODO API - Testes de Unidade com Spock Framework

## Visão Geral

Implementação de testes de unidade para a aplicação TODO API usando Spock Framework, focando na validação da lógica de negócio e funcionalidades das classes de domínio, serviços e controladores.

## Esclarecimentos

### Sessão 2025-01-24
- Q: Escopo dos testes → R: Apenas testes de unidade (simplificado)
- Q: Cobertura de cenários de erro → R: Erros básicos + validação de dados de entrada
- Q: Estratégia de dados de teste → R: Dados aleatórios com factories
- Q: Configuração do Spock Framework → R: Spock core apenas
- Q: Estrutura de organização dos testes → R: Apenas test/unit/

## Requisitos Funcionais

### Objetivos Principais dos Testes
- Implementar testes de unidade para todas as classes de domínio, serviços e controladores
- Garantir cobertura mínima de 80% para lógica de negócio
- Validar funcionalidades das classes existentes com mocking
- Testar validações e regras de negócio isoladamente

### Escopo dos Testes de Unidade
- **Domínio Task**: Validação de constraints, métodos de negócio
- **TaskService**: Lógica de CRUD, validações, operações em lote
- **TaskController**: Ações web, conversão de parâmetros, redirecionamentos
- **TaskRestController**: Endpoints REST, serialização JSON, tratamento de erros
- **Enums**: TaskStatus e TaskPriority com displayName e toString()

### Testes do Modelo de Dados
- **Domínio Task**: Validação de constraints, métodos de negócio
- **Enums**: TaskStatus (PENDING, COMPLETED) e TaskPriority (LOW, MEDIUM, HIGH)
- **Validações**: Títulos obrigatórios, tamanhos máximos, valores válidos

## Requisitos Não Funcionais

### Performance e Escalabilidade
- Testes de unidade devem executar em menos de 5 segundos
- Suporte a execução paralela de testes
- Execução rápida para feedback imediato

### Confiabilidade e Qualidade
- Cobertura mínima de 80% para lógica de negócio
- Todos os testes devem ser determinísticos e reproduzíveis
- Isolamento completo entre testes (mocking de dependências)

### Stack Tecnológico
- **Spock Framework**: 1.3-groovy-2.4 (compatível com Groovy 2.4)
- **Grails 2.5.6**: Framework base da aplicação
- **Mocking**: Spock mocking + Geb para isolamento de dependências
- **Mocking de Banco**: H2 in-memory + GORM mocking para testes de unidade

## Organização dos Testes

### Estrutura de Diretórios
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

### Categorias de Testes
- **Testes de Unidade**: Lógica isolada com mocking de dependências
- **Testes de Domínio**: Validação de constraints e métodos de negócio com H2 in-memory
- **Testes de Serviço**: Lógica de CRUD e operações de negócio com GORM mocking
- **Testes de Controlador**: Ações web e REST com mocking de serviços

### Padrões de Nomenclatura
- **Formato**: `nomeMetodo_Condicao_ResultadoEsperado`
- **Estrutura AAA**: Comentários ARRANGE-ACT-ASSERT obrigatórios
- **Exemplos**: `createTask_WithValidData_ShouldReturnCreatedTask`

## Casos Extremos e Tratamento de Erros

### Cenários de Validação
- Título vazio ou nulo (deve falhar)
- Título com mais de 255 caracteres (deve falhar)
- Descrição com mais de 1000 caracteres (deve falhar)
- Status inválido (deve falhar)
- Prioridade inválida (deve falhar)

### Cenários de Erro de Controlador
- Parâmetros inválidos (400)
- Tarefa não encontrada (404)
- Erro interno do servidor (500)
- Validação de dados de entrada

### Cenários de Erro de Serviço
- Validação de constraints
- Operações em lote com falhas parciais
- Tratamento de exceções

## Restrições e Compromissos

### Restrições Técnicas
- **Grails 2.5.6**: Versão fixa, não atualizar
- **Groovy 2.4**: Compatibilidade obrigatória
- **Java 8**: Requisito mínimo
- **MySQL 8.0**: Banco de dados via Docker Compose

### Restrições de Teste
- Mocking de dependências para isolamento
- H2 in-memory para testes de domínio
- GORM mocking para testes de serviço
- Dados aleatórios para evitar dependências
- Estrutura simples de diretórios
- Configuração mínima mas funcional

## Sinais de Conclusão

### Definição de Pronto
- [ ] Todos os testes de unidade implementados e passando
- [ ] Dados de teste aleatórios implementados
- [ ] Mocking de dependências configurado (Spock + Geb)
- [ ] H2 in-memory configurado para testes de domínio
- [ ] GORM mocking configurado para testes de serviço
- [ ] Foco no essencial - sem tarefas de polimento

### Critérios de Aceitação
- Testes executam via `grails test-app unit:`
- Todas as classes testadas com mocking
- H2 in-memory para testes de domínio
- GORM mocking para testes de serviço
- Cenários de erro validados
- Execução rápida (< 5 segundos)
- Escopo simplificado - foco no essencial
