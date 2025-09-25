package todoapi

import todoapi.Task
import todoapi.TaskStatus
import todoapi.TaskPriority

/**
 * Factory para criação de dados de teste aleatórios
 * Garante isolamento entre testes e evita dependências
 */
class TaskTestFactory {
    
    /**
     * Cria uma tarefa válida com dados aleatórios
     * @param overrides Map com valores para sobrescrever os padrões
     * @return Task com dados válidos
     */
    static Task createTask(Map overrides = [:]) {
        def task = new Task(
            title: overrides.title ?: "Task ${System.currentTimeMillis()}",
            description: overrides.description ?: "Description ${System.currentTimeMillis()}",
            status: overrides.status ?: TaskStatus.PENDING,
            priority: overrides.priority ?: TaskPriority.MEDIUM
        )
        
        // Aplicar quaisquer sobrescritas
        overrides.each { key, value ->
            if (task.hasProperty(key)) {
                task."${key}" = value
            }
        }
        
        return task
    }
    
    /**
     * Cria uma lista de tarefas com dados aleatórios
     * @param count Número de tarefas a criar
     * @param overrides Map com valores para sobrescrever os padrões
     * @return Lista de Tasks
     */
    static List<Task> createTasks(int count, Map overrides = [:]) {
        (1..count).collect { createTask(overrides) }
    }
    
    /**
     * Cria uma tarefa com dados inválidos para testes de validação
     * @param type Tipo de invalidação ('emptyTitle', 'longTitle', 'longDescription')
     * @return Task com dados inválidos
     */
    static Task createInvalidTask(String type) {
        switch (type) {
            case 'emptyTitle':
                return createTask(title: '')
            case 'longTitle':
                return createTask(title: 'A' * 256) // Excede limite de 255 caracteres
            case 'longDescription':
                return createTask(description: 'A' * 1001) // Excede limite de 1000 caracteres
            default:
                return createTask()
        }
    }
    
    /**
     * Cria uma tarefa com status específico
     * @param status Status desejado
     * @return Task com status especificado
     */
    static Task createTaskWithStatus(TaskStatus status) {
        createTask(status: status)
    }
    
    /**
     * Cria uma tarefa com prioridade específica
     * @param priority Prioridade desejada
     * @return Task com prioridade especificada
     */
    static Task createTaskWithPriority(TaskPriority priority) {
        createTask(priority: priority)
    }
}
