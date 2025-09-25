package todoapi

import grails.transaction.Transactional

/**
 * Serviço para gerenciar operações de negócio relacionadas às tarefas
 */
@Transactional
class TaskService {

    /**
     * Lista todas as tarefas
     * @return Lista de todas as tarefas
     */
    List<Task> listAllTasks() {
        return Task.list()
    }

    /**
     * Busca uma tarefa por ID
     * @param id ID da tarefa
     * @return Tarefa encontrada ou null
     */
    Task getTaskById(Long id) {
        return Task.get(id)
    }

    /**
     * Cria uma nova tarefa
     * @param params Parâmetros da tarefa
     * @return Tarefa criada
     */
    Task createTask(Map params) {
        Task task = new Task()
        task.title = params.title
        task.description = params.description
        task.status = params.status ?: TaskStatus.PENDING
        task.priority = params.priority ?: TaskPriority.MEDIUM
        
        if (task.save(flush: true)) {
            return task
        } else {
            throw new RuntimeException("Erro ao criar tarefa: ${task.errors}")
        }
    }

    /**
     * Atualiza uma tarefa existente
     * @param id ID da tarefa
     * @param params Novos parâmetros da tarefa
     * @return Tarefa atualizada
     */
    Task updateTask(Long id, Map params) {
        Task task = Task.get(id)
        if (!task) {
            return null
        }
        
        task.title = params.title ?: task.title
        task.description = params.description ?: task.description
        task.status = params.status ?: task.status
        task.priority = params.priority ?: task.priority
        
        if (task.save(flush: true)) {
            return task
        } else {
            return null
        }
    }

    /**
     * Exclui uma tarefa
     * @param id ID da tarefa
     * @return true se excluída com sucesso
     */
    boolean deleteTask(Long id) {
        Task task = Task.get(id)
        if (!task) {
            return false
        }
        
        task.delete(flush: true)
        return true
    }

    /**
     * Atualiza apenas o status de uma tarefa
     * @param id ID da tarefa
     * @param status Novo status
     * @return Tarefa atualizada
     */
    Task updateTaskStatus(Long id, TaskStatus status) {
        Task task = Task.get(id)
        if (!task) {
            return null
        }
        
        task.status = status
        if (task.save(flush: true)) {
            return task
        } else {
            return null
        }
    }

    /**
     * Atualiza o status de múltiplas tarefas
     * @param taskIds Lista de IDs das tarefas
     * @param newStatus Novo status
     * @return true se todas foram processadas com sucesso
     */
    boolean updateTasksStatusBatch(List<Long> taskIds, TaskStatus newStatus) {
        boolean allSuccessful = true
        taskIds.each { id ->
            try {
                Task task = Task.get(id)
                if (task) {
                    task.status = newStatus
                    if (!task.save(flush: true, failOnError: false)) {
                        log.error("Falha ao salvar tarefa ${id}: ${task.errors}")
                        allSuccessful = false
                    }
                } else {
                    log.warn("Tarefa com ID ${id} não encontrada para atualização em lote.")
                    allSuccessful = false
                }
            } catch (Exception e) {
                log.error("Erro ao atualizar tarefa ${id} em lote: ${e.message}", e)
                allSuccessful = false
            }
        }
        return allSuccessful
    }
}
