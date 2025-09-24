<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Lista de Tarefas</title>
</head>
<body>

<div class="row">
    <div class="col-md-12">
        <h1>Lista de Tarefas</h1>
        
        <g:if test="${flash.message}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                ${flash.message}
            </div>
        </g:if>
        
        <g:if test="${flash.error}">
            <div class="alert alert-danger alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                ${flash.error}
            </div>
        </g:if>
        
        <div class="row mb-3">
            <div class="col-md-6">
                <g:link controller="task" action="create" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> Nova Tarefa
                </g:link>
            </div>
            <div class="col-md-6 text-right">
                <button id="markCompletedBtn" class="btn btn-success" disabled>
                    <span class="glyphicon glyphicon-ok"></span> Marcar como Concluído
                </button>
            </div>
        </div>
        
        <g:if test="${taskList && !taskList.empty}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAll" class="form-control">
                            </th>
                            <th>Título</th>
                            <th>Status</th>
                            <th>Prioridade</th>
                            <th>Data de Criação</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${taskList}" var="task">
                            <tr>
                                <td>
                                    <input type="checkbox" name="selectedTaskIds" value="${task.id}" class="task-checkbox form-control">
                                </td>
                                <td>${task.title}</td>
                                <td>
                                    <span class="label label-${task.status == 'COMPLETED' ? 'success' : 'warning'}">
                                        ${task.status}
                                    </span>
                                </td>
                                <td>
                                    <span class="label label-${task.priority == 'HIGH' ? 'danger' : task.priority == 'MEDIUM' ? 'warning' : 'info'}">
                                        ${task.priority}
                                    </span>
                                </td>
                                <td><g:formatDate date="${task.dateCreated}" format="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <g:link controller="task" action="show" id="${task.id}" class="btn btn-info btn-sm">
                                        <span class="glyphicon glyphicon-eye-open"></span> Visualizar
                                    </g:link>
                                    <g:link controller="task" action="edit" id="${task.id}" class="btn btn-warning btn-sm">
                                        <span class="glyphicon glyphicon-edit"></span> Editar
                                    </g:link>
                                    <g:link controller="task" action="delete" id="${task.id}" class="btn btn-danger btn-sm" 
                                            onclick="return confirm('Tem certeza que deseja excluir esta tarefa?')">
                                        <span class="glyphicon glyphicon-trash"></span> Excluir
                                    </g:link>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </g:if>
        <g:else>
            <div class="alert alert-info" role="alert">
                <h4>Nenhuma tarefa encontrada</h4>
                <p>Clique em "Nova Tarefa" para começar a criar suas tarefas.</p>
                <g:link controller="task" action="create" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> Nova Tarefa
                </g:link>
            </div>
        </g:else>
    </div>
</div>

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
    }
    
    // Marcar tarefas como concluídas
    $('#markCompletedBtn').on('click', function() {
        const selectedTaskIds = [];
        $('.task-checkbox:checked').each(function() {
            selectedTaskIds.push($(this).val());
        });

        if (selectedTaskIds.length === 0) {
            alert('Selecione pelo menos uma tarefa para realizar a ação.');
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
                        alert('Tarefas atualizadas com sucesso!');
                        location.reload();
                    } else {
                        alert('Erro ao atualizar tarefas: ' + (response.message || 'Erro desconhecido.'));
                    }
                },
                error: function(xhr, status, error) {
                    alert('Erro na requisição: ' + xhr.responseText);
                }
            });
        }
    });
});
</script>

</body>
</html>
