package todoapi

import grails.converters.JSON
import grails.transaction.Transactional

/**
 * Controlador para gerenciar tarefas via interface web
 */
@Transactional(readOnly = true)
class TaskController {
    
    TaskService taskService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", batchUpdateStatus: "POST"]

    /**
     * Lista todas as tarefas
     * GET /tasks
     */
    def index() {
        [taskList: taskService.listAllTasks()]
    }

    /**
     * Exibe uma tarefa específica
     * GET /tasks/:id
     */
    def show() {
        def task = taskService.getTaskById(params.id as Long)
        if (!task) {
            flash.message = "Tarefa não encontrada"
            redirect action: "index"
            return
        }
        [task: task]
    }

    /**
     * Exibe formulário para criar nova tarefa
     * GET /tasks/create
     */
    def create() {
        [task: new Task()]
    }

    /**
     * Salva uma nova tarefa
     * POST /tasks
     */
    @Transactional
    def save() {
        try {
            // Converter valores de displayName para enum
            if (params.priority) {
                params.priority = convertPriorityToEnum(params.priority)
            }
            
            def task = taskService.createTask(params)
            flash.message = "Tarefa criada com sucesso"
            redirect action: "show", id: task.id
        } catch (Exception e) {
            flash.error = "Erro ao criar tarefa: ${e.message}"
            [task: new Task(params)]
        }
    }

    /**
     * Exibe formulário para editar tarefa
     * GET /tasks/:id/edit
     */
    def edit() {
        def task = taskService.getTaskById(params.id as Long)
        if (!task) {
            flash.message = "Tarefa não encontrada"
            redirect action: "index"
            return
        }
        [task: task]
    }

    /**
     * Atualiza uma tarefa existente
     * PUT /tasks/:id
     */
    @Transactional
    def update() {
        try {
            // Converter valores de displayName para enum
            if (params.status) {
                params.status = convertStatusToEnum(params.status)
            }
            if (params.priority) {
                params.priority = convertPriorityToEnum(params.priority)
            }
            
            def task = taskService.updateTask(params.id as Long, params)
            flash.message = "Tarefa atualizada com sucesso"
            redirect action: "show", id: task.id
        } catch (Exception e) {
            flash.error = "Erro ao atualizar tarefa: ${e.message}"
            redirect action: "edit", id: params.id
        }
    }
    
    private TaskStatus convertStatusToEnum(String statusValue) {
        switch(statusValue) {
            case "Pendente":
                return TaskStatus.PENDING
            case "Concluída":
                return TaskStatus.COMPLETED
            default:
                return TaskStatus.valueOf(statusValue)
        }
    }
    
    private TaskPriority convertPriorityToEnum(String priorityValue) {
        switch(priorityValue) {
            case "Baixa":
                return TaskPriority.LOW
            case "Média":
                return TaskPriority.MEDIUM
            case "Alta":
                return TaskPriority.HIGH
            default:
                return TaskPriority.valueOf(priorityValue)
        }
    }

    /**
     * Exclui uma tarefa
     * DELETE /tasks/:id
     */
    @Transactional
    def delete() {
        try {
            taskService.deleteTask(params.id as Long)
            flash.message = "Tarefa excluída com sucesso"
        } catch (Exception e) {
            flash.error = "Erro ao excluir tarefa: ${e.message}"
        }
        redirect action: "index"
    }

    /**
     * Atualiza status de múltiplas tarefas em lote
     * POST /tasks/batchUpdateStatus
     */
    @Transactional
    def batchUpdateStatus() {
        if (request.method == 'POST') {
            def json = request.JSON
            List<Long> taskIds = json.taskIds as List<Long>
            String newStatusString = json.newStatus

            if (!taskIds || taskIds.isEmpty() || !newStatusString) {
                render status: 400, text: [success: false, message: 'IDs das tarefas ou novo status são obrigatórios'] as JSON
                return
            }

            try {
                TaskStatus newStatus = TaskStatus.valueOf(newStatusString)
                boolean success = taskService.updateTasksStatusBatch(taskIds, newStatus)
                if (success) {
                    render status: 200, text: [success: true, message: 'Tarefas atualizadas com sucesso'] as JSON
                } else {
                    render status: 500, text: [success: false, message: 'Algumas tarefas não puderam ser atualizadas'] as JSON
                }
            } catch (IllegalArgumentException e) {
                render status: 400, text: [success: false, message: 'Status inválido fornecido'] as JSON
            } catch (Exception e) {
                log.error("Erro ao atualizar tarefas em lote: ${e.message}", e)
                render status: 500, text: [success: false, message: 'Erro interno do servidor ao atualizar tarefas'] as JSON
            }
        } else {
            render status: 405, text: [success: false, message: 'Método não permitido'] as JSON
        }
    }
}
