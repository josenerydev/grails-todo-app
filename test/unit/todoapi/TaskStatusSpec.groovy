package todoapi

import spock.lang.Specification

/**
 * Testes unitários para o enum TaskStatus
 * Testa valores básicos do enum
 */
class TaskStatusSpec extends Specification {

    def "valores_DeveRetornarTodosOsValoresDeStatus"() {
        // ARRANGE - Preparar dados de teste
        given: "enum TaskStatus"

        // ACT - Obter valores do enum
        when: "chamando values()"
        def values = TaskStatus.values()

        // ASSERT - Verificar resultado
        then: "deve retornar todos os valores"
        values.length == 2
        values.contains(TaskStatus.PENDING)
        values.contains(TaskStatus.COMPLETED)
    }
}
