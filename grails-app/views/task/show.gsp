<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Visualizar Tarefa</title>
</head>
<body>

<div class="row justify-content-center" style="margin-top: 1rem;">
    <div class="col-12 col-md-8 col-lg-6">
        <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center" style="background-color: #f8f9fa; border-bottom: 1px solid #dee2e6;">
                <h1 class="h4 mb-0 text-dark">
                    <i class="bi bi-eye me-2" style="color: #6c757d;"></i>Visualizar Tarefa
                </h1>
                <div class="dropdown">
                    <button class="btn btn-sm" type="button" data-bs-toggle="dropdown" style="background-color: #6c757d; border-color: #6c757d; color: white;">
                        <i class="bi bi-three-dots-vertical"></i>
                    </button>
                    <ul class="dropdown-menu">
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
            <div class="card-body">
                <g:if test="${flash.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>${flash.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </g:if>
                
                <div class="mb-4">
                    <h2 class="h5 text-muted mb-2">Título</h2>
                    <p class="h4 text-dark">${task.title}</p>
                </div>
                
                <div class="mb-4">
                    <h2 class="h5 text-muted mb-2">Descrição</h2>
                    <p class="text-dark">${task.description ?: 'Sem descrição'}</p>
                </div>
                
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <h2 class="h5 text-muted mb-2">Status</h2>
                        <span class="badge fs-6" style="background-color: ${task.status == 'COMPLETED' ? '#28a745' : '#ffc107'}; color: ${task.status == 'COMPLETED' ? 'white' : '#212529'};">
                            ${task.status}
                        </span>
                    </div>
                    
                    <div class="col-md-6">
                        <h2 class="h5 text-muted mb-2">Prioridade</h2>
                        <span class="badge fs-6" style="background-color: ${task.priority == 'HIGH' ? '#dc3545' : task.priority == 'MEDIUM' ? '#ffc107' : '#6c757d'}; color: ${task.priority == 'MEDIUM' ? '#212529' : 'white'};">
                            ${task.priority}
                        </span>
                    </div>
                </div>
                
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <h2 class="h5 text-muted mb-2">Data de Criação</h2>
                        <p class="text-dark">
                            <i class="bi bi-calendar-plus me-1"></i>
                            <g:formatDate date="${task.dateCreated}" format="dd/MM/yyyy HH:mm"/>
                        </p>
                    </div>
                    
                    <div class="col-md-6">
                        <h2 class="h5 text-muted mb-2">Última Atualização</h2>
                        <p class="text-dark">
                            <i class="bi bi-calendar-check me-1"></i>
                            <g:formatDate date="${task.lastUpdated}" format="dd/MM/yyyy HH:mm"/>
                        </p>
                    </div>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <g:link controller="task" action="index" class="btn me-md-2" style="background-color: #6c757d; border-color: #6c757d; color: white;">
                        <i class="bi bi-arrow-left me-1"></i>Voltar à Lista
                    </g:link>
                    <g:link controller="task" action="edit" id="${task.id}" class="btn" style="background-color: #ffc107; border-color: #ffc107; color: #212529;">
                        <i class="bi bi-pencil me-1"></i>Editar
                    </g:link>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
