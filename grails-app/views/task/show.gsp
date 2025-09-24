<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Visualizar Tarefa</title>
</head>
<body>

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <h1>Visualizar Tarefa</h1>
        
        <g:if test="${flash.message}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                ${flash.message}
            </div>
        </g:if>
        
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Detalhes da Tarefa</h3>
            </div>
            <div class="panel-body">
                <dl class="dl-horizontal">
                    <dt>Título:</dt>
                    <dd>${task.title}</dd>
                    
                    <dt>Descrição:</dt>
                    <dd>${task.description ?: 'Sem descrição'}</dd>
                    
                    <dt>Status:</dt>
                    <dd>
                        <span class="label label-${task.status == 'COMPLETED' ? 'success' : 'warning'}">
                            ${task.status}
                        </span>
                    </dd>
                    
                    <dt>Prioridade:</dt>
                    <dd>
                        <span class="label label-${task.priority == 'HIGH' ? 'danger' : task.priority == 'MEDIUM' ? 'warning' : 'info'}">
                            ${task.priority}
                        </span>
                    </dd>
                    
                    <dt>Data de Criação:</dt>
                    <dd><g:formatDate date="${task.dateCreated}" format="dd/MM/yyyy HH:mm"/></dd>
                    
                    <dt>Última Atualização:</dt>
                    <dd><g:formatDate date="${task.lastUpdated}" format="dd/MM/yyyy HH:mm"/></dd>
                </dl>
            </div>
        </div>
        
        <div class="btn-group" role="group">
            <g:link controller="task" action="edit" id="${task.id}" class="btn btn-warning">
                <span class="glyphicon glyphicon-edit"></span> Editar
            </g:link>
            <g:link controller="task" action="delete" id="${task.id}" class="btn btn-danger" 
                    onclick="return confirm('Tem certeza que deseja excluir esta tarefa?')">
                <span class="glyphicon glyphicon-trash"></span> Excluir
            </g:link>
            <g:link controller="task" action="index" class="btn btn-default">
                <span class="glyphicon glyphicon-list"></span> Voltar à Lista
            </g:link>
        </div>
    </div>
</div>

</body>
</html>
