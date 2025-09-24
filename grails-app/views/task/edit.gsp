<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Editar Tarefa</title>
</head>
<body>

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <h1>Editar Tarefa</h1>
        
        <g:if test="${flash.error}">
            <div class="alert alert-danger alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                ${flash.error}
            </div>
        </g:if>
        
        <g:form controller="task" action="update" class="form-horizontal">
            <g:hiddenField name="id" value="${task?.id}"/>
            
            <div class="form-group">
                <label for="title" class="col-sm-2 control-label">Título *</label>
                <div class="col-sm-10">
                    <g:textField name="title" value="${task?.title}" class="form-control" required="true" maxlength="255"/>
                </div>
            </div>
            
            <div class="form-group">
                <label for="description" class="col-sm-2 control-label">Descrição</label>
                <div class="col-sm-10">
                    <g:textArea name="description" value="${task?.description}" class="form-control" rows="4" maxlength="1000"/>
                </div>
            </div>
            
            <div class="form-group">
                <label for="status" class="col-sm-2 control-label">Status</label>
                <div class="col-sm-10">
                    <g:select name="status" from="${todoapi.TaskStatus.values()}" 
                              value="${task?.status}" 
                              class="form-control"/>
                </div>
            </div>
            
            <div class="form-group">
                <label for="priority" class="col-sm-2 control-label">Prioridade</label>
                <div class="col-sm-10">
                    <g:select name="priority" from="${todoapi.TaskPriority.values()}" 
                              value="${task?.priority}" 
                              class="form-control"/>
                </div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:submitButton name="update" value="Atualizar Tarefa" class="btn btn-primary"/>
                    <g:link controller="task" action="show" id="${task?.id}" class="btn btn-info">Visualizar</g:link>
                    <g:link controller="task" action="index" class="btn btn-default">Voltar</g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>

</body>
</html>
