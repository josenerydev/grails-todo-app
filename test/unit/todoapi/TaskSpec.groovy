package todoapi

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * Testes unitários para o domínio Task
 * Testa validações, constraints e métodos de negócio
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

    def "validar_ComTituloVazio_DeveFalharNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com título vazio"
        def task = TaskTestFactory.createInvalidTask('emptyTitle')

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve falhar"
        isValid == false
        task.errors.hasFieldErrors('title')
        task.errors.getFieldError('title').code == 'blank'
    }

    def "validar_ComTituloMuitoLongo_DeveFalharNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com título muito longo"
        def task = TaskTestFactory.createInvalidTask('longTitle')

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve falhar"
        isValid == false
        task.errors.hasFieldErrors('title')
        task.errors.getFieldError('title').code == 'maxSize.exceeded'
    }

    def "validar_ComDescricaoMuitoLonga_DeveFalharNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com descrição muito longa"
        def task = TaskTestFactory.createInvalidTask('longDescription')

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve falhar"
        isValid == false
        task.errors.hasFieldErrors('description')
        task.errors.getFieldError('description').code == 'maxSize.exceeded'
    }

    @Unroll
    def "validar_ComTamanhoDeTituloValido_DevePassarNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com título de tamanho válido"
        def task = TaskTestFactory.createTask(title: title)

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve passar"
        isValid == true
        task.errors.errorCount == 0

        where:
        title << [
            "A",                    // 1 caractere
            "A" * 255,             // 255 caracteres (máximo)
            "Tarefa Normal",       // Título normal
            "Tarefa com Números 123" // Título com números
        ]
    }

    @Unroll
    def "validar_ComTamanhoDeDescricaoValido_DevePassarNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com descrição de tamanho válido"
        def task = TaskTestFactory.createTask(description: description)

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve passar"
        isValid == true
        task.errors.errorCount == 0

        where:
        description << [
            null,                   // Descrição nula (opcional)
            "",                     // Descrição vazia (opcional)
            "Descrição normal",     // Descrição normal
            "A" * 1000             // 1000 caracteres (máximo)
        ]
    }

    def "validar_ComStatusNulo_DeveFalharNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com status nulo"
        def task = TaskTestFactory.createTask(status: null)

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve falhar"
        isValid == false
        task.errors.hasFieldErrors('status')
        task.errors.getFieldError('status').code == 'nullable'
    }

    def "validar_ComPrioridadeNula_DeveFalharNaValidacao"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa com prioridade nula"
        def task = TaskTestFactory.createTask(priority: null)

        // ACT - Executar validação
        when: "validando a tarefa"
        def isValid = task.validate()

        // ASSERT - Verificar resultado
        then: "validação deve falhar"
        isValid == false
        task.errors.hasFieldErrors('priority')
        task.errors.getFieldError('priority').code == 'nullable'
    }

    def "toString_ComTarefaValida_DeveRetornarTitulo"() {
        // ARRANGE - Preparar dados de teste
        given: "tarefa válida"
        def task = TaskTestFactory.createTask(title: "Tarefa de Teste")

        // ACT - Executar toString
        when: "chamando toString"
        def result = task.toString()

        // ASSERT - Verificar resultado
        then: "deve retornar o título"
        result == "Tarefa de Teste"
    }

    def "equals_ComMesmoId_DeveRetornarTrue"() {
        // ARRANGE - Preparar dados de teste
        given: "duas tarefas com mesmo ID"
        def task1 = TaskTestFactory.createTask()
        def task2 = TaskTestFactory.createTask()
        task1.id = 1L
        task2.id = 1L

        // ACT - Comparar tarefas
        when: "comparando as tarefas"
        def result = task1.equals(task2)

        // ASSERT - Verificar resultado
        then: "devem ser iguais"
        result == true
        task1 == task2
    }

    def "equals_ComIdsDiferentes_DeveRetornarFalse"() {
        // ARRANGE - Preparar dados de teste
        given: "duas tarefas com IDs diferentes"
        def task1 = TaskTestFactory.createTask()
        def task2 = TaskTestFactory.createTask()
        task1.id = 1L
        task2.id = 2L

        // ACT - Comparar tarefas
        when: "comparando as tarefas"
        def result = task1.equals(task2)

        // ASSERT - Verificar resultado
        then: "devem ser diferentes"
        result == false
    }

    def "hashCode_ComMesmoId_DeveRetornarMesmoHash"() {
        // ARRANGE - Preparar dados de teste
        given: "duas tarefas com mesmo ID"
        def task1 = TaskTestFactory.createTask()
        def task2 = TaskTestFactory.createTask()
        task1.id = 1L
        task2.id = 1L

        // ACT - Calcular hash codes
        when: "calculando hash codes"
        def hash1 = task1.hashCode()
        def hash2 = task2.hashCode()

        // ASSERT - Verificar resultado
        then: "hash codes devem ser iguais"
        hash1 == hash2
        task1.hashCode() == task2.hashCode()
    }
}
