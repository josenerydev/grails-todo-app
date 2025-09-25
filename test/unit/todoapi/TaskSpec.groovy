package todoapi

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * Testes unitários para o domínio Task
 * Testa validação básica do domínio
 */
@TestFor(Task)
class TaskSpec extends Specification {

    def setup() {
        // Configurar H2 in-memory para testes de domínio
        mockForConstraintsTests(Task)
    }

    def "validar_ComDadosValidos_DevePassarNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "dados válidos de tarefa"
        def task = TaskTestFactory.createTask([
            title: "Tarefa de Teste",
            description: "Descrição da tarefa",
            status: TaskStatus.PENDING,
            priority: TaskPriority.HIGH
        ])

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve passar"
        isValid == true
        task.errors.errorCount == 0
    }
}
