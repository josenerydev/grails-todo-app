<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Lista de Tarefas</title>
</head>
<body>

<!-- Page Header -->
<div class="row mb-4">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h1 class="card-title mb-1">
                            <i class="bi bi-list-ul me-2"></i>Lista de Tarefas
                        </h1>
                        <p class="card-text text-muted mb-0">Gerencie todas as suas tarefas</p>
                    </div>
                    <g:link controller="task" action="create" class="btn btn-primary btn-lg">
                        <i class="bi bi-plus-circle me-2"></i>Nova Tarefa
                    </g:link>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Alerts -->
<g:if test="${flash.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>${flash.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</g:if>

<g:if test="${flash.error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle me-2"></i>${flash.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</g:if>

<!-- Batch Actions -->
<g:if test="${taskList && !taskList.empty}">
    <div class="row mb-3">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="bi bi-info-circle text-info"></i>
                        </div>
                        <div class="flex-grow-1">
                            <small class="text-muted">
                                <strong>Dica:</strong> Selecione as tarefas usando os checkboxes e use o botão abaixo para marcar múltiplas tarefas como concluídas.
                            </small>
                        </div>
                        <button id="markCompletedBtn" class="btn btn-success" disabled>
                            <i class="bi bi-check-circle me-1"></i>Marcar Selecionadas como Concluídas
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:if>

<!-- Tasks List -->
<g:if test="${taskList && !taskList.empty}">
    <!-- Desktop Table View -->
    <div class="card d-none d-lg-block">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th width="50">
                                <input type="checkbox" id="selectAll" class="form-check-input">
                            </th>
                            <th>Título</th>
                            <th>Status</th>
                            <th>Prioridade</th>
                            <th>Data de Criação</th>
                            <th width="200">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${taskList}" var="task">
                            <tr>
                                <td>
                                    <input type="checkbox" name="selectedTaskIds" value="${task.id}" class="task-checkbox form-check-input">
                                </td>
                                <td class="fw-bold">${task.title}</td>
                                <td>
                                    <span class="badge ${task.status.name() == 'COMPLETED' ? 'bg-success' : 'bg-secondary'}">
                                        ${task.status}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${task.priority.name() == 'HIGH' ? 'bg-danger' : task.priority.name() == 'MEDIUM' ? 'bg-warning text-dark' : 'bg-info'}">
                                        ${task.priority}
                                    </span>
                                </td>
                                <td><g:formatDate date="${task.dateCreated}" format="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <g:link controller="task" action="show" id="${task.id}" class="btn btn-sm btn-info" title="Visualizar">
                                            <i class="bi bi-eye"></i>
                                        </g:link>
                                        <g:link controller="task" action="edit" id="${task.id}" class="btn btn-sm btn-warning" title="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </g:link>
                                        <g:form controller="task" action="delete" id="${task.id}" method="DELETE" style="display: inline;">
                                            <button type="submit" class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Tem certeza que deseja excluir esta tarefa?')" title="Excluir">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </g:form>
                                    </div>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Mobile Card View -->
    <div class="d-lg-none">
        <g:each in="${taskList}" var="task">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div class="form-check">
                            <input type="checkbox" name="selectedTaskIds" value="${task.id}" class="task-checkbox form-check-input" id="task-${task.id}">
                            <label class="form-check-label fw-bold" for="task-${task.id}">
                                ${task.title}
                            </label>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary btn-sm" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-three-dots-vertical"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><g:link controller="task" action="show" id="${task.id}" class="dropdown-item">
                                    <i class="bi bi-eye me-2"></i>Visualizar
                                </g:link></li>
                                <li><g:link controller="task" action="edit" id="${task.id}" class="dropdown-item">
                                    <i class="bi bi-pencil me-2"></i>Editar
                                </g:link></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <g:form controller="task" action="delete" id="${task.id}" method="DELETE" style="display: inline;">
                                        <button type="submit" class="dropdown-item text-danger" 
                                                onclick="return confirm('Tem certeza que deseja excluir esta tarefa?')" style="border: none; background: none; width: 100%; text-align: left;">
                                            <i class="bi bi-trash me-2"></i>Excluir
                                        </button>
                                    </g:form>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row g-2">
                        <div class="col-6">
                            <span class="badge w-100 ${task.status.name() == 'COMPLETED' ? 'bg-success' : 'bg-secondary'}">
                                ${task.status}
                            </span>
                        </div>
                        <div class="col-6">
                            <span class="badge w-100 ${task.priority.name() == 'HIGH' ? 'bg-danger' : task.priority.name() == 'MEDIUM' ? 'bg-warning text-dark' : 'bg-info'}">
                                ${task.priority}
                            </span>
                        </div>
                    </div>
                    <small class="text-muted d-block mt-2">
                        <i class="bi bi-calendar me-1"></i><g:formatDate date="${task.dateCreated}" format="dd/MM/yyyy HH:mm"/>
                    </small>
                </div>
            </div>
        </g:each>
    </div>
</g:if>
<g:else>
    <div class="card">
        <div class="card-body text-center py-5">
            <div class="mb-4">
                <i class="bi bi-clipboard-x display-1 text-muted"></i>
            </div>
            <h3 class="text-muted mb-3">Nenhuma tarefa encontrada</h3>
            <p class="text-muted mb-4">Comece criando sua primeira tarefa para organizar suas atividades.</p>
            <g:link controller="task" action="create" class="btn btn-primary btn-lg">
                <i class="bi bi-plus-circle me-2"></i>Nova Tarefa
            </g:link>
        </div>
    </div>
</g:else>

<script>
$(document).ready(function() {
    // Selecionar/deselecionar todas as tarefas
    $('#selectAll').on('change', function() {
        $('.task-checkbox').prop('checked', this.checked);
        updateMarkCompletedButton();
    });
    
    // Atualizar botão de marcar como concluído
    $('.task-checkbox').on('change', function() {
        updateMarkCompletedButton();
    });
    
    function updateMarkCompletedButton() {
        var checkedCount = $('.task-checkbox:checked').length;
        $('#markCompletedBtn').prop('disabled', checkedCount === 0);
        
        // Atualizar texto do botão com quantidade selecionada
        if (checkedCount > 0) {
            $('#markCompletedBtn').html('<i class="bi bi-check-circle me-1"></i>Marcar Selecionadas como Concluídas (' + checkedCount + ')');
        } else {
            $('#markCompletedBtn').html('<i class="bi bi-check-circle me-1"></i>Marcar Selecionadas como Concluídas');
        }
    }
    
    // Marcar tarefas como concluídas
    $('#markCompletedBtn').on('click', function() {
        const selectedTaskIds = [];
        $('.task-checkbox:checked').each(function() {
            selectedTaskIds.push($(this).val());
        });

        if (selectedTaskIds.length === 0) {
            showToast('Aviso', 'Selecione pelo menos uma tarefa para realizar a ação.', 'warning');
            return;
        }

        if (confirm('Tem certeza que deseja marcar as tarefas selecionadas como CONCLUÍDAS?')) {
            $.ajax({
                url: '${g.createLink(controller: 'task', action: 'batchUpdateStatus')}',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    taskIds: selectedTaskIds,
                    newStatus: 'COMPLETED'
                }),
                success: function(response) {
                    if (response.success) {
                        showToast('Sucesso', 'Tarefas atualizadas com sucesso!', 'success');
                        // Recarregar imediatamente após sucesso
                        setTimeout(function() {
                            window.location.reload();
                        }, 1000);
                    } else {
                        showToast('Erro', 'Erro ao atualizar tarefas: ' + (response.message || 'Erro desconhecido.'), 'danger');
                    }
                },
                error: function(xhr, status, error) {
                    showToast('Erro', 'Erro na requisição: ' + xhr.responseText, 'danger');
                }
            });
        }
    });
    
    // Função para mostrar toast
    function showToast(title, message, type) {
        const toastHtml = `
            <div class="toast align-items-center text-white bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <strong>${title}:</strong> ${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        `;
        
        // Criar container de toast se não existir
        if (!$('#toastContainer').length) {
            $('body').append('<div id="toastContainer" class="toast-container position-fixed top-0 end-0 p-3"></div>');
        }
        
        $('#toastContainer').append(toastHtml);
        const toastElement = $('#toastContainer .toast').last()[0];
        const toast = new bootstrap.Toast(toastElement);
        toast.show();
        
        // Remover toast após ser escondido
        $(toastElement).on('hidden.bs.toast', function() {
            $(this).remove();
        });
    }
});
</script>

</body>
</html>