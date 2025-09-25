<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Dashboard - TODO API</title>
	</head>
	<body>
		<!-- Page Header -->
		<div class="row mb-4">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">
							<i class="bi bi-speedometer2 me-2"></i>Dashboard
						</h1>
						<p class="card-text text-muted">Sistema de gerenciamento de tarefas desenvolvido com Grails 2.5.6</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Quick Actions -->
		<div class="row mb-4">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h5 class="mb-0">
							<i class="bi bi-lightning me-2"></i>Ações Rápidas
						</h5>
					</div>
					<div class="card-body">
						<g:link controller="task" action="index" class="btn btn-primary me-2 mb-2">
							<i class="bi bi-list-ul me-1"></i>Ver Tarefas
						</g:link>
						<g:link controller="task" action="create" class="btn btn-success me-2 mb-2">
							<i class="bi bi-plus-circle me-1"></i>Nova Tarefa
						</g:link>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<!-- Features -->
			<div class="col-lg-6 mb-4">
				<div class="card">
					<div class="card-header">
						<h5 class="mb-0">
							<i class="bi bi-star me-2"></i>Funcionalidades
						</h5>
					</div>
					<div class="card-body">
						<ul class="list-group list-group-flush">
							<li class="list-group-item d-flex align-items-center">
								<i class="bi bi-check-circle text-success me-2"></i>
								<div>
									<strong>CRUD Completo:</strong> Criar, visualizar, editar e excluir tarefas
								</div>
							</li>
							<li class="list-group-item d-flex align-items-center">
								<i class="bi bi-cloud text-info me-2"></i>
								<div>
									<strong>API REST:</strong> Endpoints para integração com outras aplicações
								</div>
							</li>
							<li class="list-group-item d-flex align-items-center">
								<i class="bi bi-palette text-warning me-2"></i>
								<div>
									<strong>Interface Web:</strong> Interface amigável com Bootstrap
								</div>
							</li>
							<li class="list-group-item d-flex align-items-center">
								<i class="bi bi-flag text-danger me-2"></i>
								<div>
									<strong>Status e Prioridades:</strong> Controle de status e níveis de prioridade
								</div>
							</li>
							<li class="list-group-item d-flex align-items-center">
								<i class="bi bi-layers text-primary me-2"></i>
								<div>
									<strong>Ações em Lote:</strong> Atualizar múltiplas tarefas simultaneamente
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>

			<!-- System Information -->
			<div class="col-lg-6 mb-4">
				<div class="card">
					<div class="card-header">
						<h5 class="mb-0">
							<i class="bi bi-info-circle me-2"></i>Informações do Sistema
						</h5>
					</div>
					<div class="card-body">
						<dl class="row">
							<dt class="col-sm-4">Versão da App:</dt>
							<dd class="col-sm-8"><g:meta name="app.version"/></dd>
							
							<dt class="col-sm-4">Versão do Grails:</dt>
							<dd class="col-sm-8"><g:meta name="app.grails.version"/></dd>
							
							<dt class="col-sm-4">Versão do Groovy:</dt>
							<dd class="col-sm-8">${GroovySystem.getVersion()}</dd>
							
							<dt class="col-sm-4">Versão do JVM:</dt>
							<dd class="col-sm-8">${System.getProperty('java.version')}</dd>
							
							<dt class="col-sm-4">Banco de Dados:</dt>
							<dd class="col-sm-8">MySQL 8.0 (Docker)</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>

		<!-- API Endpoints -->
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h5 class="mb-0">
							<i class="bi bi-code-slash me-2"></i>API REST Endpoints
						</h5>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-6">
								<h6>Operações Básicas</h6>
								<ul class="list-unstyled">
									<li class="mb-2">
										<span class="badge bg-success me-2">GET</span>
										<code>/api/tasks</code> - Listar todas as tarefas
									</li>
									<li class="mb-2">
										<span class="badge bg-success me-2">GET</span>
										<code>/api/tasks/:id</code> - Buscar tarefa por ID
									</li>
									<li class="mb-2">
										<span class="badge bg-primary me-2">POST</span>
										<code>/api/tasks</code> - Criar nova tarefa
									</li>
									<li class="mb-2">
										<span class="badge bg-warning me-2">PUT</span>
										<code>/api/tasks/:id</code> - Atualizar tarefa
									</li>
									<li class="mb-2">
										<span class="badge bg-danger me-2">DELETE</span>
										<code>/api/tasks/:id</code> - Excluir tarefa
									</li>
								</ul>
							</div>
							<div class="col-md-6">
								<h6>Operações Especiais</h6>
								<ul class="list-unstyled">
									<li class="mb-2">
										<span class="badge bg-info me-2">PATCH</span>
										<code>/api/tasks/:id/status</code> - Atualizar status
									</li>
									<li class="mb-2">
										<span class="badge bg-primary me-2">POST</span>
										<code>/tasks/batchUpdateStatus</code> - Atualizar múltiplas tarefas
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>