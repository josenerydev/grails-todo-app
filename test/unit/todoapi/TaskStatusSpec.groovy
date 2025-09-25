package todoapi

import spock.lang.Specification
import spock.lang.Unroll

/**
 * Testes unitários para o enum TaskStatus
 * Testa valores, displayName e métodos toString
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

    @Unroll
    def "displayName_ComStatus_DeveRetornarDisplayNameCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "status #{status}"

        // ACT - Obter displayName
        when: "chamando displayName"
        def result = status.displayName

        // ASSERT - Verificar resultado
        then: "deve retornar o displayName correto"
        result == expectedDisplayName

        where:
        status              || expectedDisplayName
        TaskStatus.PENDING  || "Pendente"
        TaskStatus.COMPLETED || "Concluída"
    }

    @Unroll
    def "toString_ComStatus_DeveRetornarDisplayName"() {
        // ARRANGE - Preparar dados de teste
        given: "status #{status}"

        // ACT - Chamar toString
        when: "chamando toString()"
        def result = status.toString()

        // ASSERT - Verificar resultado
        then: "deve retornar o displayName"
        result == expectedDisplayName

        where:
        status              || expectedDisplayName
        TaskStatus.PENDING  || "Pendente"
        TaskStatus.COMPLETED || "Concluída"
    }

    def "valueOf_ComStringValida_DeveRetornarStatusCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "string válida de status"

        // ACT - Converter string para enum
        when: "chamando valueOf"
        def pendingStatus = TaskStatus.valueOf("PENDING")
        def completedStatus = TaskStatus.valueOf("COMPLETED")

        // ASSERT - Verificar resultado
        then: "deve retornar o status correto"
        pendingStatus == TaskStatus.PENDING
        completedStatus == TaskStatus.COMPLETED
    }

    def "valueOf_ComStringInvalida_DeveLancarExcecao"() {
        // ARRANGE - Preparar dados de teste
        given: "string inválida de status"

        // ACT & ASSERT - Verificar exceção
        when: "chamando valueOf com string inválida"
        TaskStatus.valueOf("INVALID")

        then: "deve lançar IllegalArgumentException"
        thrown(IllegalArgumentException)
    }

    def "ordinal_ComStatus_DeveRetornarOrdinalCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "status do enum"

        // ACT - Obter ordinal
        when: "chamando ordinal()"
        def pendingOrdinal = TaskStatus.PENDING.ordinal()
        def completedOrdinal = TaskStatus.COMPLETED.ordinal()

        // ASSERT - Verificar resultado
        then: "deve retornar o ordinal correto"
        pendingOrdinal == 0
        completedOrdinal == 1
    }

    def "name_ComStatus_DeveRetornarNomeCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "status do enum"

        // ACT - Obter name
        when: "chamando name()"
        def pendingName = TaskStatus.PENDING.name()
        def completedName = TaskStatus.COMPLETED.name()

        // ASSERT - Verificar resultado
        then: "deve retornar o name correto"
        pendingName == "PENDING"
        completedName == "COMPLETED"
    }

    def "compareTo_ComStatuses_DeveRetornarOrdemCorreta"() {
        // ARRANGE - Preparar dados de teste
        given: "dois status diferentes"

        // ACT - Comparar status
        when: "chamando compareTo()"
        def pendingToCompleted = TaskStatus.PENDING.compareTo(TaskStatus.COMPLETED)
        def completedToPending = TaskStatus.COMPLETED.compareTo(TaskStatus.PENDING)
        def pendingToPending = TaskStatus.PENDING.compareTo(TaskStatus.PENDING)

        // ASSERT - Verificar resultado
        then: "deve retornar a ordem correta"
        pendingToCompleted < 0  // PENDING vem antes de COMPLETED
        completedToPending > 0  // COMPLETED vem depois de PENDING
        pendingToPending == 0   // PENDING é igual a PENDING
    }

    def "equals_ComMesmoStatus_DeveRetornarTrue"() {
        // ARRANGE - Preparar dados de teste
        given: "dois status iguais"

        // ACT - Comparar status
        when: "chamando equals()"
        def result = TaskStatus.PENDING.equals(TaskStatus.PENDING)

        // ASSERT - Verificar resultado
        then: "devem ser iguais"
        result == true
    }

    def "equals_ComStatusDiferentes_DeveRetornarFalse"() {
        // ARRANGE - Preparar dados de teste
        given: "dois status diferentes"

        // ACT - Comparar status
        when: "chamando equals()"
        def result = TaskStatus.PENDING.equals(TaskStatus.COMPLETED)

        // ASSERT - Verificar resultado
        then: "devem ser diferentes"
        result == false
    }

    def "hashCode_ComMesmoStatus_DeveRetornarMesmoHash"() {
        // ARRANGE - Preparar dados de teste
        given: "dois status iguais"

        // ACT - Calcular hash codes
        when: "chamando hashCode()"
        def hash1 = TaskStatus.PENDING.hashCode()
        def hash2 = TaskStatus.PENDING.hashCode()

        // ASSERT - Verificar resultado
        then: "hash codes devem ser iguais"
        hash1 == hash2
    }

    def "hashCode_ComStatusDiferentes_DeveRetornarHashDiferente"() {
        // ARRANGE - Preparar dados de teste
        given: "dois status diferentes"

        // ACT - Calcular hash codes
        when: "chamando hashCode()"
        def hash1 = TaskStatus.PENDING.hashCode()
        def hash2 = TaskStatus.COMPLETED.hashCode()

        // ASSERT - Verificar resultado
        then: "hash codes devem ser diferentes"
        hash1 != hash2
    }
}
