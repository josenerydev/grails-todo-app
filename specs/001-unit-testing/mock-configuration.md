# Configuração de Mocking para Testes de Unidade

**Feature**: 001-unit-testing

## Estratégia de Mocking

### 1. H2 In-Memory Database para Testes de Domínio
```groovy
// BuildConfig.groovy
dependencies {
    testCompile 'com.h2database:h2:1.4.200'
    testCompile 'org.spockframework:spock-core:1.3-groovy-2.4'
    testCompile 'org.spockframework:spock-spring:1.3-groovy-2.4'
}

// DataSource.groovy (test environment)
test {
    dataSource {
        dbCreate = "create-drop"
        url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        driverClassName = "org.h2.Driver"
        username = "sa"
        password = ""
    }
}
```

### 2. GORM Mocking para Testes de Serviço
```groovy
// TaskServiceSpec.groovy
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(TaskService)
class TaskServiceSpec extends Specification {
    
    def setup() {
        // Mock GORM methods
        Task.metaClass.static.list = { Map params -> [] }
        Task.metaClass.static.get = { Long id -> new Task(id: id) }
        Task.metaClass.static.save = { Task task -> task }
        Task.metaClass.static.delete = { Task task -> true }
    }
    
    def "should list all tasks"() {
        given: "no tasks exist"
        Task.metaClass.static.list = { Map params -> [] }
        
        when: "listing all tasks"
        def result = service.listTasks()
        
        then: "empty list is returned"
        result.isEmpty()
    }
}
```

### 3. Service Mocking para Testes de Controller
```groovy
// TaskControllerSpec.groovy
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(TaskController)
class TaskControllerSpec extends Specification {
    
    def taskService = Mock(TaskService)
    
    def setup() {
        controller.taskService = taskService
    }
    
    def "should list tasks"() {
        given: "some tasks exist"
        def tasks = [new Task(title: "Test Task")]
        taskService.listTasks() >> tasks
        
        when: "accessing index action"
        controller.index()
        
        then: "tasks are available in model"
        model.tasks == tasks
    }
}
```

### 4. TaskTestFactory para Dados Aleatórios
```groovy
// TaskTestFactory.groovy
class TaskTestFactory {
    
    static Task createTask(Map overrides = [:]) {
        def task = new Task(
            title: overrides.title ?: "Task ${System.currentTimeMillis()}",
            description: overrides.description ?: "Description ${System.currentTimeMillis()}",
            status: overrides.status ?: TaskStatus.PENDING,
            priority: overrides.priority ?: TaskPriority.MEDIUM
        )
        
        // Apply any overrides
        overrides.each { key, value ->
            if (task.hasProperty(key)) {
                task."${key}" = value
            }
        }
        
        return task
    }
    
    static List<Task> createTasks(int count, Map overrides = [:]) {
        (1..count).collect { createTask(overrides) }
    }
}
```

## Benefícios da Estratégia

1. **H2 In-Memory**: Testes de domínio rápidos e isolados
2. **GORM Mocking**: Testes de serviço sem dependência de banco
3. **Service Mocking**: Testes de controller isolados
4. **Dados Aleatórios**: Evita dependências entre testes
5. **Execução Rápida**: < 5 segundos para suite completa

## Configuração de Dependências

### BuildConfig.groovy
```groovy
dependencies {
    // Spock Framework
    testCompile 'org.spockframework:spock-core:1.3-groovy-2.4'
    testCompile 'org.spockframework:spock-spring:1.3-groovy-2.4'
    
    // H2 Database
    testCompile 'com.h2database:h2:1.4.200'
    
    // GORM Testing
    testCompile 'org.grails:grails-datastore-test-support:1.0.2-grails-2.4'
}
```

### DataSource.groovy
```groovy
environments {
    test {
        dataSource {
            dbCreate = "create-drop"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
            driverClassName = "org.h2.Driver"
            username = "sa"
            password = ""
        }
    }
}
```

## Execução dos Testes

```bash
# Executar todos os testes de unidade
grails test-app unit:

# Executar testes específicos
grails test-app unit:TaskSpec
grails test-app unit:TaskServiceSpec
grails test-app unit:TaskControllerSpec

# Executar com cobertura
grails test-app unit: -coverage
```
