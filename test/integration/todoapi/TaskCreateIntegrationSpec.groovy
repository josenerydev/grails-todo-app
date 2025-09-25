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
        task.priority == TaskPriority.MEDIUM
        task.status == TaskStatus.PENDING
        task.dateCreated != null
        task.lastUpdated != null
        
        and: "a tarefa deve estar persistida no banco de dados e os dados persistidos devem ser conferidos"
        def taskFromDb = Task.findById(task.id)
        println groovy.json.JsonOutput.prettyPrint(groovy.json.JsonOutput.toJson(taskFromDb?.properties))
        taskFromDb != null
        Task.count() > 0

        taskFromDb.title == taskData.title
        taskFromDb.description == taskData.description
        taskFromDb.priority == TaskPriority.MEDIUM
        taskFromDb.status == TaskStatus.PENDING
        taskFromDb.dateCreated != null
        taskFromDb.lastUpdated != null
    }
}