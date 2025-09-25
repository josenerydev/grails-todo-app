<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Editar Tarefa</title>
</head>
<body>

<div class="row justify-content-center" style="margin-top: 1rem;">
    <div class="col-12 col-md-8 col-lg-6">
        <div class="card shadow-sm">
            <div class="card-header" style="background-color: #f8f9fa; border-bottom: 1px solid #dee2e6;">
                <h1 class="h4 mb-0 text-dark">
                    <i class="bi bi-pencil-square me-2" style="color: #6c757d;"></i>Editar Tarefa
                </h1>
            </div>
            <div class="card-body">
                <g:if test="${flash.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>${flash.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </g:if>
                
                <g:form controller="task" action="update" class="needs-validation" novalidate="true">
                    <g:hiddenField name="id" value="${task?.id}"/>
                    
                    <div class="mb-3">
                        <label for="title" class="form-label">
                            Título <span class="text-danger">*</span>
                        </label>
                        <g:textField name="title" value="${task?.title}" 
                                    class="form-control form-control-lg" 
                                    required="true" 
                                    maxlength="255"
                                    placeholder="Digite o título da tarefa"/>
                        <div class="invalid-feedback">
                            Por favor, insira um título para a tarefa.
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Descrição</label>
                        <g:textArea name="description" value="${task?.description}" 
                                   class="form-control" 
                                   rows="4" 
                                   maxlength="1000"
                                   placeholder="Descreva os detalhes da tarefa (opcional)"/>
                        <div class="form-text">
                            Máximo de 1000 caracteres
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="status" class="form-label">Status</label>
                            <g:select name="status" from="${todoapi.TaskStatus.values()}" 
                                      value="${task?.status}" 
                                      class="form-select"/>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="priority" class="form-label">Prioridade</label>
                            <g:select name="priority" from="${todoapi.TaskPriority.values()}" 
                                      value="${task?.priority}" 
                                      class="form-select"/>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <g:link controller="task" action="index" class="btn me-md-2" style="background-color: #6c757d; border-color: #6c757d; color: white;">
                            <i class="bi bi-arrow-left me-1"></i>Voltar
                        </g:link>
                        <g:link controller="task" action="show" id="${task?.id}" class="btn me-md-2" style="background-color: #17a2b8; border-color: #17a2b8; color: white;">
                            <i class="bi bi-eye me-1"></i>Visualizar
                        </g:link>
                        <g:submitButton name="update" value="Atualizar Tarefa" class="btn" style="background-color: #ffc107; border-color: #ffc107; color: #212529;">
                            <i class="bi bi-check-circle me-1"></i>Atualizar Tarefa
                        </g:submitButton>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script>
// Validação do formulário
(function() {
    'use strict';
    window.addEventListener('load', function() {
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function(form) {
            form.addEventListener('submit', function(event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();
</script>

</body>
</html>
