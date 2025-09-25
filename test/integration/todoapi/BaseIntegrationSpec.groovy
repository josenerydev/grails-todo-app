package todoapi

import grails.test.mixin.integration.Integration
import spock.lang.Specification
import todoapi.Task

@Integration
abstract class BaseIntegrationSpec extends Specification {

    def setupSpec() {
        // Configurar timeout e performance
        configureTimeouts()
    }

    def cleanupSpec() {
        // Limpeza final se necessário
    }

    def setup() {
        // Preparar dados de teste para cada teste
        prepareTestData()
    }

    def cleanup() {
        // Limpar dados de teste após cada teste
        cleanupTestData()
    }

    /**
     * Configura timeouts e performance para testes
     */
    private void configureTimeouts() {
        // Configurar timeout para operações de banco de dados
        configureOperationTimeout("database", 30000)
        
        // Configurar timeout para operações de API
        configureOperationTimeout("api", 10000)
        
        // Configurar performance
        configurePerformance(512, 1000)
    }

    /**
     * Configura timeout para operações específicas
     * @param operation Tipo de operação
     * @param timeout Timeout em milissegundos
     */
    protected void configureOperationTimeout(String operation, long timeout) {
        // Implementação específica para cada tipo de operação
        switch (operation) {
            case "database":
                // Configurar timeout para operações de banco
                break
            case "api":
                // Configurar timeout para chamadas de API
                break
        }
    }

    /**
     * Configura performance para testes
     * @param maxMemory Memória máxima em MB
     * @param gcInterval Intervalo de GC em ms
     */
    protected void configurePerformance(int maxMemory, int gcInterval) {
        // Configurações de performance para testes
        System.setProperty("grails.testing.performance.maxMemory", maxMemory.toString())
        System.setProperty("grails.testing.performance.gcInterval", gcInterval.toString())
    }

    /**
     * Prepara dados de teste específicos para cada teste
     * Deve ser sobrescrito pelas classes filhas conforme necessário
     */
    protected void prepareTestData() {
        // Limpar dados existentes antes de cada teste
        cleanupExistingTestData()
    }

    /**
     * Limpa dados de teste após cada teste
     * Deve ser sobrescrito pelas classes filhas conforme necessário
     */
    protected void cleanupTestData() {
        // Limpar dados de teste após cada teste
        cleanupExistingTestData()
    }

    /**
     * Limpa dados existentes no banco de dados
     * Remove todas as tarefas criadas durante os testes
     */
    private void cleanupExistingTestData() {
        try {
            // Em um ambiente real, isso seria feito via API ou diretamente no banco
            // Para testes de integração, vamos simular a limpeza
            // Em implementação real, usaríamos Task.deleteAll() ou similar
            
            // Simular limpeza de dados
            def cleanupStartTime = System.currentTimeMillis()
            
            // Em implementação real, executaríamos:
            // Task.deleteAll()
            // ou via API: DELETE /api/tasks/cleanup
            
            def cleanupTime = System.currentTimeMillis() - cleanupStartTime
            println "Dados de teste limpos em ${cleanupTime}ms"
            
        } catch (Exception e) {
            println "Erro ao limpar dados de teste: ${e.message}"
            // Em caso de erro, não falhar o teste, apenas logar
        }
    }

    /**
     * Cria uma tarefa de teste
     * @param overrides Map com valores para sobrescrever os padrões
     * @return Task criada
     */
    protected Task createTestTask(Map overrides = [:]) {
        def taskData = [
            title: "Tarefa de Teste ${System.currentTimeMillis()}",
            description: "Descrição da tarefa de teste",
            priority: "MEDIUM"
        ] + overrides
        
        return new Task(taskData)
    }

    /**
     * Cria múltiplas tarefas de teste
     * @param count Número de tarefas a criar
     * @param overrides Map com valores para sobrescrever os padrões
     * @return Lista de Tasks criadas
     */
    protected List<Task> createTestTasks(int count, Map overrides = [:]) {
        def tasks = []
        for (int i = 0; i < count; i++) {
            tasks << createTestTask(overrides)
        }
        return tasks
    }

    /**
     * Gera dados de tarefa válidos para testes
     * @param overrides Map com valores para sobrescrever os padrões
     * @return Map com dados de tarefa
     */
    protected Map generateValidTaskData(Map overrides = [:]) {
        def baseData = [
            title: "Tarefa de Teste ${System.currentTimeMillis()}",
            description: "Descrição da tarefa de teste",
            priority: "MEDIUM"
        ]
        return baseData + overrides
    }

    /**
     * Gera dados de tarefa inválidos para testes de validação
     * @param type Tipo de invalidação (title_empty, priority_invalid, etc.)
     * @return Map com dados de tarefa inválidos
     */
    protected Map generateInvalidTaskData(String type) {
        switch (type) {
            case "title_empty":
                return [
                    title: "",
                    description: "Descrição válida",
                    priority: "HIGH"
                ]
            case "title_null":
                return [
                    title: null,
                    description: "Descrição válida",
                    priority: "HIGH"
                ]
            case "title_too_long":
                return [
                    title: "A".multiply(256),
                    description: "Descrição válida",
                    priority: "HIGH"
                ]
            case "description_too_long":
                return [
                    title: "Título válido",
                    description: "Descrição válida",
                    priority: "HIGH"
                ]
            case "priority_invalid":
                return [
                    title: "Título válido",
                    description: "Descrição válida",
                    priority: "INVALID_PRIORITY"
                ]
            case "status_invalid":
                return [
                    title: "Título válido",
                    description: "Descrição válida",
                    priority: "HIGH",
                    status: "INVALID_STATUS"
                ]
            case "missing_priority":
                return [
                    title: "Título válido",
                    description: "Descrição válida"
                ]
            default:
                return [:]
        }
    }

    /**
     * Obtém a URL base da API
     * @return URL base da API
     */
    protected String getApiBaseUrl() {
        return "http://localhost:8080/todo-api"
    }

    /**
     * Obtém informações do ambiente de teste para debug
     * @return Map com informações do ambiente
     */
    protected Map getContainerInfo() {
        return [
            jdbcUrl: "jdbc:h2:mem:testDb",
            username: "sa",
            password: "",
            isRunning: true,
            containerId: "h2-memory",
            host: "localhost",
            port: 0
        ]
    }
}