# Pesquisa: Testes com Spock Framework para Grails 2.5.6

## Configuração do Spock Framework 1.3-groovy-2.4

### Decisão: Usar Spock Framework 1.3-groovy-2.4 com Grails 2.5.6
**Justificativa**: 
- Spock 1.3-groovy-2.4 é a versão mais recente compatível com Groovy 2.4
- Grails 2.5.6 requer Groovy 2.4, limitando opções de versão do Spock
- Spock 1.3 fornece estrutura Given-When-Then completa e capacidades de mocking
- Compatível com infraestrutura de testes do Grails

**Alternativas consideradas**:
- Spock 2.x: Não compatível com Groovy 2.4
- JUnit 4: Falta estrutura Given-When-Then e integração Groovy
- Spock 1.2: Versão mais antiga com menos recursos

### Requisitos de Configuração
```groovy
dependencies {
    testCompile 'org.spockframework:spock-core:1.3-groovy-2.4'
    testCompile 'org.spockframework:spock-spring:1.3-groovy-2.4'
}
```

## Integração TestContainers com Grails 2.5.6

### Decisão: Usar TestContainers com MySQL 8.0 para testes de integração
**Justificativa**:
- Fornece instâncias de banco de dados isoladas para cada teste
- Compatível com Grails 2.5.6 através de integração Spring
- Garante reprodutibilidade e isolamento de testes
- Combina com banco de dados de produção (MySQL 8.0)

**Alternativas consideradas**:
- H2 in-memory: Mais rápido mas diferente da produção
- Docker Compose: Configuração mais complexa, problemas de estado compartilhado
- Mock de banco: Não testa interações reais de banco de dados

### Padrão de Integração
```groovy
@Shared
MySQLContainer mysql = new MySQLContainer("mysql:8.0")
    .withDatabaseName("testdb")
    .withUsername("test")
    .withPassword("test")

def setupSpec() {
    mysql.start()
    // Configurar DataSource do Grails para teste
}
```

## Melhores Práticas de Estrutura Given-When-Then

### Decisão: Implementar blocos Given-When-Then estruturados com separação clara
**Justificativa**:
- Melhora legibilidade e manutenibilidade dos testes
- Torna a intenção do teste explícita
- Segue convenções do Spock Framework
- Alinha com princípios BDD

**Padrão de Nomenclatura e Estrutura AAA**:
```groovy
def "createTask_WithValidData_ShouldReturnCreatedTask"() {
    // ARRANGE - Preparar dados de teste
    given: "dados válidos de tarefa"
        def taskData = [
            title: "Test Task",
            description: "Test Description",
            priority: TaskPriority.HIGH
        ]
    
    // ACT - Executar ação sendo testada
    when: "criando uma nova tarefa"
        def result = taskService.createTask(taskData)
    
    // ASSERT - Verificar resultados
    then: "tarefa deve ser criada com sucesso"
        result != null
        result.title == "Test Task"
        result.priority == TaskPriority.HIGH
}
```

### Padrões de Nomenclatura Recomendados:
- **Formato**: `nomeMetodo_Condicao_ResultadoEsperado`
- **Exemplos**:
  - `createTask_WithValidData_ShouldReturnCreatedTask`
  - `createTask_WithEmptyTitle_ShouldThrowValidationException`
  - `updateTask_WithExistingId_ShouldUpdateSuccessfully`
  - `deleteTask_WithNonExistentId_ShouldThrowNotFoundException`
  - `listTasks_WhenNoTasksExist_ShouldReturnEmptyList`

## Geração de Dados Aleatórios para Isolamento de Testes

### Decisão: Usar RandomStringUtils do Groovy e factories customizadas para dados de teste
**Justificativa**:
- Garante independência dos testes e previne conflitos de dados
- Reduz sobrecarga de manutenção de dados de teste estáticos
- Melhora confiabilidade dos testes em diferentes ambientes
- Permite teste de casos extremos com dados variados

**Alternativas consideradas**:
- Fixtures estáticas: Propensas a conflitos e problemas de manutenção
- Seeding de banco: Configuração complexa, problemas de estado compartilhado
- Arquivos de dados externos: Complexidade adicional, problemas de controle de versão

### Padrão de Implementação
```groovy
class TaskTestFactory {
    static Task createValidTask(Map overrides = [:]) {
        new Task(
            title: overrides.title ?: "Task ${RandomStringUtils.randomAlphanumeric(10)}",
            description: overrides.description ?: "Description ${RandomStringUtils.randomAlphanumeric(20)}",
            priority: overrides.priority ?: TaskPriority.values().toList().random(),
            status: overrides.status ?: TaskStatus.PENDING
        )
    }
}
```

## Infraestrutura de Testes do Grails 2.5.6

### Decisão: Aproveitar suporte de testes integrado do Grails com Spock
**Justificativa**:
- Grails 2.5.6 tem suporte integrado para testes Spock
- Integra com contexto de aplicação e serviços do Grails
- Fornece gerenciamento de transação para testes de integração
- Suporta categorias de teste unitário e integração

### Configuração
```groovy
// BuildConfig.groovy
grails.project.dependency.resolution = {
    dependencies {
        testCompile 'org.spockframework:spock-core:1.3-groovy-2.4'
        testCompile 'org.spockframework:spock-spring:1.3-groovy-2.4'
        testCompile 'org.testcontainers:testcontainers:1.17.6'
        testCompile 'org.testcontainers:mysql:1.17.6'
    }
}
```

## Considerações de Performance

### Decisão: Otimizar execução de testes com execução paralela e limpeza
**Justificativa**:
- Testes de integração com TestContainers podem ser lentos
- Execução paralela reduz tempo total de teste
- Limpeza adequada previne vazamentos de recursos
- Atende objetivos de performance (< 30s para testes de integração)

### Estratégias
- Usar `@Shared` para configuração cara (containers de banco)
- Implementar limpeza adequada em `cleanupSpec()`
- Executar testes unitários em paralelo com `grails test-app --parallel`
- Usar schemas de banco específicos para testes para isolamento
