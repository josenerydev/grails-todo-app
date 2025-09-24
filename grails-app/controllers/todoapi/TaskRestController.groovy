package todoapi

import grails.converters.JSON
import grails.rest.RestfulController
import grails.transaction.Transactional

/**
 * Controlador REST para gerenciar tarefas via API
 */
@Transactional(readOnly = true)
class TaskRestController extends RestfulController {
    
    static responseFormats = ['json']
    
    TaskService taskService
    
    TaskRestController() {
        super(Task)
    }

    /**
     * Lista todas as tarefas
     * GET /api/tasks
     */
    def index() {
        try {
            def tasks = taskService.listAllTasks()
            respond tasks
        } catch (Exception e) {
            log.error("Erro ao listar tarefas: ${e.message}", e)
            render status: 500, text: [error: "Erro interno do servidor"] as JSON
        }
    }

    /**
     * Busca uma tarefa por ID
     * GET /api/tasks/:id
     */
    def show() {
        try {
            def task = taskService.getTaskById(params.id as Long)
            if (task) {
                respond task
            } else {
                render status: 404, text: [error: "Tarefa não encontrada"] as JSON
            }
        } catch (Exception e) {
            log.error("Erro ao buscar tarefa ${params.id}: ${e.message}", e)
            render status: 500, text: [error: "Erro interno do servidor"] as JSON
        }
    }

    /**
     * Cria uma nova tarefa
     * POST /api/tasks
     */
    @Transactional
    def save() {
        try {
            def task = taskService.createTask(request.JSON)
            render status: 201, text: task as JSON
        } catch (Exception e) {
            log.error("Erro ao criar tarefa: ${e.message}", e)
            render status: 400, text: [error: e.message] as JSON
        }
    }

    /**
     * Atualiza uma tarefa existente
     * PUT /api/tasks/:id
     */
    @Transactional
    def update() {
        try {
            def task = taskService.updateTask(params.id as Long, request.JSON)
            respond task
        } catch (RuntimeException e) {
            if (e.message.contains("não encontrada")) {
                render status: 404, text: [error: e.message] as JSON
            } else {
                render status: 400, text: [error: e.message] as JSON
            }
        } catch (Exception e) {
            log.error("Erro ao atualizar tarefa ${params.id}: ${e.message}", e)
            render status: 500, text: [error: "Erro interno do servidor"] as JSON
        }
    }

    /**
     * Exclui uma tarefa
     * DELETE /api/tasks/:id
     */
    @Transactional
    def delete() {
        try {
            taskService.deleteTask(params.id as Long)
            render status: 204
        } catch (RuntimeException e) {
            if (e.message.contains("não encontrada")) {
                render status: 404, text: [error: e.message] as JSON
            } else {
                render status: 400, text: [error: e.message] as JSON
            }
        } catch (Exception e) {
            log.error("Erro ao excluir tarefa ${params.id}: ${e.message}", e)
            render status: 500, text: [error: "Erro interno do servidor"] as JSON
        }
    }

    /**
     * Atualiza apenas o status de uma tarefa
     * PATCH /api/tasks/:id/status
     */
    @Transactional
    def updateStatus() {
        try {
            def newStatusString = request.JSON.status
            if (!newStatusString) {
                render status: 400, text: [error: "Status é obrigatório"] as JSON
                return
            }
            
            TaskStatus newStatus
            try {
                newStatus = TaskStatus.valueOf(newStatusString.toUpperCase())
            } catch (IllegalArgumentException e) {
                render status: 400, text: [error: "Status inválido. Use PENDING ou COMPLETED"] as JSON
                return
            }
            
            def task = taskService.updateTaskStatus(params.id as Long, newStatus)
            respond task
        } catch (RuntimeException e) {
            if (e.message.contains("não encontrada")) {
                render status: 404, text: [error: e.message] as JSON
            } else {
                render status: 400, text: [error: e.message] as JSON
            }
        } catch (Exception e) {
            log.error("Erro ao atualizar status da tarefa ${params.id}: ${e.message}", e)
            render status: 500, text: [error: "Erro interno do servidor"] as JSON
        }
    }
}
