package todoapi

import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification

/**
 * Testes unitários para o TaskService
 * Testa operação básica de listagem
 */
@TestFor(TaskService)
@Mock(Task)
class TaskServiceSpec extends Specification {

    def setup() {
        // Configurar mocking para isolamento
        // service é injetado automaticamente pelo @TestFor
    }

    def "listarTodasTarefas_QuandoExistemTarefas_DeveRetornarListaDeTarefas"() {
        // ARRANGE - Preparar dados de teste
        given: "algumas tarefas existem"
        def task1 = new Task(title: "Tarefa 1", status: TaskStatus.PENDING, priority: TaskPriority.HIGH).save()
        def task2 = new Task(title: "Tarefa 2", status: TaskStatus.COMPLETED, priority: TaskPriority.MEDIUM).save()

        // ACT - Executar ação sendo testada
        when: "listando todas as tarefas"
        def result = service.listAllTasks()

        // ASSERT - Verificar resultado
        then: "lista de tarefas deve ser retornada"
        result != null
        result.size() == 2
        result.contains(task1)
        result.contains(task2)
    }
}
