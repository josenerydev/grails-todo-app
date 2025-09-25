package todoapi

import spock.lang.Specification
import spock.lang.Unroll

/**
 * Testes unitários para o enum TaskPriority
 * Testa valores, displayName e métodos toString
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

    @Unroll
    def "displayName_ComPrioridade_DeveRetornarDisplayNameCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "prioridade #{priority}"

        // ACT - Obter displayName
        when: "chamando displayName"
        def result = priority.displayName

        // ASSERT - Verificar resultado
        then: "deve retornar o displayName correto"
        result == expectedDisplayName

        where:
        priority              || expectedDisplayName
        TaskPriority.LOW      || "Baixa"
        TaskPriority.MEDIUM   || "Média"
        TaskPriority.HIGH     || "Alta"
    }

    @Unroll
    def "toString_ComPrioridade_DeveRetornarDisplayName"() {
        // ARRANGE - Preparar dados de teste
        given: "prioridade #{priority}"

        // ACT - Chamar toString
        when: "chamando toString()"
        def result = priority.toString()

        // ASSERT - Verificar resultado
        then: "deve retornar o displayName"
        result == expectedDisplayName

        where:
        priority              || expectedDisplayName
        TaskPriority.LOW      || "Baixa"
        TaskPriority.MEDIUM   || "Média"
        TaskPriority.HIGH     || "Alta"
    }

    def "valueOf_ComStringValida_DeveRetornarPrioridadeCorreta"() {
        // ARRANGE - Preparar dados de teste
        given: "string válida de prioridade"

        // ACT - Converter string para enum
        when: "chamando valueOf"
        def lowPriority = TaskPriority.valueOf("LOW")
        def mediumPriority = TaskPriority.valueOf("MEDIUM")
        def highPriority = TaskPriority.valueOf("HIGH")

        // ASSERT - Verificar resultado
        then: "deve retornar a prioridade correta"
        lowPriority == TaskPriority.LOW
        mediumPriority == TaskPriority.MEDIUM
        highPriority == TaskPriority.HIGH
    }

    def "valueOf_ComStringInvalida_DeveLancarExcecao"() {
        // ARRANGE - Preparar dados de teste
        given: "string inválida de prioridade"

        // ACT & ASSERT - Verificar exceção
        when: "chamando valueOf com string inválida"
        TaskPriority.valueOf("INVALID")

        then: "deve lançar IllegalArgumentException"
        thrown(IllegalArgumentException)
    }

    def "ordinal_ComPrioridade_DeveRetornarOrdinalCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "prioridade do enum"

        // ACT - Obter ordinal
        when: "chamando ordinal()"
        def lowOrdinal = TaskPriority.LOW.ordinal()
        def mediumOrdinal = TaskPriority.MEDIUM.ordinal()
        def highOrdinal = TaskPriority.HIGH.ordinal()

        // ASSERT - Verificar resultado
        then: "deve retornar o ordinal correto"
        lowOrdinal == 0
        mediumOrdinal == 1
        highOrdinal == 2
    }

    def "name_ComPrioridade_DeveRetornarNomeCorreto"() {
        // ARRANGE - Preparar dados de teste
        given: "prioridade do enum"

        // ACT - Obter name
        when: "chamando name()"
        def lowName = TaskPriority.LOW.name()
        def mediumName = TaskPriority.MEDIUM.name()
        def highName = TaskPriority.HIGH.name()

        // ASSERT - Verificar resultado
        then: "deve retornar o name correto"
        lowName == "LOW"
        mediumName == "MEDIUM"
        highName == "HIGH"
    }

    def "compareTo_ComPrioridades_DeveRetornarOrdemCorreta"() {
        // ARRANGE - Preparar dados de teste
        given: "duas prioridades diferentes"

        // ACT - Comparar prioridades
        when: "chamando compareTo()"
        def lowToMedium = TaskPriority.LOW.compareTo(TaskPriority.MEDIUM)
        def mediumToHigh = TaskPriority.MEDIUM.compareTo(TaskPriority.HIGH)
        def lowToHigh = TaskPriority.LOW.compareTo(TaskPriority.HIGH)
        def lowToLow = TaskPriority.LOW.compareTo(TaskPriority.LOW)

        // ASSERT - Verificar resultado
        then: "deve retornar a ordem correta"
        lowToMedium < 0    // LOW vem antes de MEDIUM
        mediumToHigh < 0   // MEDIUM vem antes de HIGH
        lowToHigh < 0      // LOW vem antes de HIGH
        lowToLow == 0      // LOW é igual a LOW
    }

    def "equals_ComMesmaPrioridade_DeveRetornarTrue"() {
        // ARRANGE - Preparar dados de teste
        given: "duas prioridades iguais"

        // ACT - Comparar prioridades
        when: "chamando equals()"
        def result = TaskPriority.MEDIUM.equals(TaskPriority.MEDIUM)

        // ASSERT - Verificar resultado
        then: "devem ser iguais"
        result == true
    }

    def "equals_ComPrioridadesDiferentes_DeveRetornarFalse"() {
        // ARRANGE - Preparar dados de teste
        given: "duas prioridades diferentes"

        // ACT - Comparar prioridades
        when: "chamando equals()"
        def result = TaskPriority.LOW.equals(TaskPriority.HIGH)

        // ASSERT - Verificar resultado
        then: "devem ser diferentes"
        result == false
    }

    def "hashCode_ComMesmaPrioridade_DeveRetornarMesmoHash"() {
        // ARRANGE - Preparar dados de teste
        given: "duas prioridades iguais"

        // ACT - Calcular hash codes
        when: "chamando hashCode()"
        def hash1 = TaskPriority.HIGH.hashCode()
        def hash2 = TaskPriority.HIGH.hashCode()

        // ASSERT - Verificar resultado
        then: "hash codes devem ser iguais"
        hash1 == hash2
    }

    def "hashCode_ComPrioridadesDiferentes_DeveRetornarHashDiferente"() {
        // ARRANGE - Preparar dados de teste
        given: "duas prioridades diferentes"

        // ACT - Calcular hash codes
        when: "chamando hashCode()"
        def hash1 = TaskPriority.LOW.hashCode()
        def hash2 = TaskPriority.MEDIUM.hashCode()

        // ASSERT - Verificar resultado
        then: "hash codes devem ser diferentes"
        hash1 != hash2
    }

    def "getDeclaringClass_ComPrioridade_DeveRetornarClasseTaskPriority"() {
        // ARRANGE - Preparar dados de teste
        given: "prioridade do enum"

        // ACT - Obter classe declarante
        when: "chamando getDeclaringClass()"
        def declaringClass = TaskPriority.LOW.getDeclaringClass()

        // ASSERT - Verificar resultado
        then: "deve retornar a classe TaskPriority"
        declaringClass == TaskPriority
    }

    def "getClass_ComPrioridade_DeveRetornarClasseTaskPriority"() {
        // ARRANGE - Preparar dados de teste
        given: "prioridade do enum"

        // ACT - Obter classe
        when: "chamando getClass()"
        def clazz = TaskPriority.MEDIUM.getClass()

        // ASSERT - Verificar resultado
        then: "deve retornar a classe TaskPriority"
        clazz == TaskPriority
    }
}
