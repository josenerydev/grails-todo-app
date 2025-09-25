package todoapi

import grails.test.mixin.integration.Integration
import spock.lang.Specification
import todoapi.Task

@Integration
class TaskCreateIntegrationSpec extends Specification {

    def setupSpec() {
        println "=== TESTE DE INTEGRAÇÃO INICIADO ==="
        
        def url = System.getProperty("grails.datasource.url") ?: "jdbc:h2:mem:testDb"
        def username = System.getProperty("grails.datasource.username") ?: "sa"
        def driver = System.getProperty("grails.datasource.driverClassName") ?: "org.h2.Driver"
        
        println "DataSource URL: ${url}"
        println "DataSource Username: ${username}"
        println "DataSource Driver: ${driver}"
        
        if (url.contains("mysql")) {
            println "Usando MySQL via Docker Compose"
        } else {
            println "Usando H2 in-memory"
        }
    }

    def "verificarDataSource_DeveEstarConfigurado"() {
        expect: "o DataSource deve estar configurado e funcionando"
        // Verificar se o banco está funcionando criando uma tarefa
        def task = new Task(title: "Teste", description: "Teste", priority: "MEDIUM")
        task.save(flush: true)
        task.id != null
    }

    def "criarTarefa_ComDadosValidos_DeveRetornarTarefaCriada"() {
        given: "dados válidos para uma nova tarefa"
        def taskData = [
            title: "Tarefa de Teste ${System.currentTimeMillis()}",
            description: "Descrição da tarefa de teste",
            priority: "MEDIUM"
        ]
        
        when: "criando uma nova tarefa"
        def task = new Task(taskData)
        task.save(flush: true)
        
        then: "a tarefa deve ser criada com sucesso"
        task != null
        task.id != null
        task.title == taskData.title
        task.description == taskData.description
        task.priority == TaskPriority.MEDIUM // Verificar enum
        task.status == TaskStatus.PENDING // Status padrão
        task.dateCreated != null
        task.lastUpdated != null
        
        and: "a tarefa deve estar persistida no banco de dados"
        Task.findById(task.id) != null
        Task.count() > 0
    }
}