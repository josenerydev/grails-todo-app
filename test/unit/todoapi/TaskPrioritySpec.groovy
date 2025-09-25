package todoapi

import spock.lang.Specification

/**
 * Testes unitários para o enum TaskPriority
 * Testa valores básicos do enum
 */
class TaskPrioritySpec extends Specification {

    def "valores_DeveRetornarTodosOsValoresDePrioridade"() {
        // ARRANGE - Preparar dados de teste
        given: "enum TaskPriority"

        // ACT - Obter valores do enum
        when: "chamando values()"
        def values = TaskPriority.values()

        // ASSERT - Verificar resultado
        then: "deve retornar todos os valores"
        values.length == 3
        values.contains(TaskPriority.LOW)
        values.contains(TaskPriority.MEDIUM)
        values.contains(TaskPriority.HIGH)
    }
}
