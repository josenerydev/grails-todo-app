package todoapi

import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification

/**
 * Testes unitários para o TaskController
 * Testa ação básica de listagem
 */
@TestFor(TaskController)
@Mock([Task, TaskService])
class TaskControllerSpec extends Specification {

    def setup() {
        // Configurar mock do TaskService manualmente
        controller.taskService = Mock(TaskService)
    }

    def "index_QuandoExistemTarefas_DeveExibirTarefasNoModelo"() {
        // ARRANGE - Preparar dados de teste
        given: "algumas tarefas existem"
        def tasks = [
            new Task(title: "Tarefa 1", status: TaskStatus.PENDING, priority: TaskPriority.HIGH),
            new Task(title: "Tarefa 2", status: TaskStatus.COMPLETED, priority: TaskPriority.MEDIUM)
        ]
        1 * controller.taskService.listAllTasks() >> tasks

        // ACT - Executar ação sendo testada
        when: "acessando ação index"
        def result = controller.index()

        // ASSERT - Verificar resultado
        then: "tarefas devem estar disponíveis no modelo"
        result.taskList == tasks
        result.taskList.size() == 2
    }
}
