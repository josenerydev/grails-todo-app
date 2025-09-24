<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Dashboard - TODO API</title>
	</head>
	<body>
		<div class="jumbotron">
			<h1>TODO API</h1>
			<p class="lead">Sistema de gerenciamento de tarefas desenvolvido com Grails 2.5.6</p>
			<p>
				<g:link controller="task" action="index" class="btn btn-primary btn-lg">
					<span class="glyphicon glyphicon-list"></span> Ver Tarefas
				</g:link>
				<g:link controller="task" action="create" class="btn btn-success btn-lg">
					<span class="glyphicon glyphicon-plus"></span> Nova Tarefa
				</g:link>
			</p>
		</div>
		
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">Funcionalidades</h3>
					</div>
					<div class="panel-body">
						<ul class="list-group">
							<li class="list-group-item">
								<span class="glyphicon glyphicon-ok text-success"></span>
								<strong>CRUD Completo:</strong> Criar, visualizar, editar e excluir tarefas
							</li>
							<li class="list-group-item">
								<span class="glyphicon glyphicon-ok text-success"></span>
								<strong>API REST:</strong> Endpoints para integração com outras aplicações
							</li>
							<li class="list-group-item">
								<span class="glyphicon glyphicon-ok text-success"></span>
								<strong>Interface Web:</strong> Interface amigável com Bootstrap
							</li>
							<li class="list-group-item">
								<span class="glyphicon glyphicon-ok text-success"></span>
								<strong>Status e Prioridades:</strong> Controle de status e níveis de prioridade
							</li>
							<li class="list-group-item">
								<span class="glyphicon glyphicon-ok text-success"></span>
								<strong>Ações em Lote:</strong> Atualizar múltiplas tarefas simultaneamente
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Informações do Sistema</h3>
					</div>
					<div class="panel-body">
						<dl class="dl-horizontal">
							<dt>Versão da App:</dt>
							<dd><g:meta name="app.version"/></dd>
							
							<dt>Versão do Grails:</dt>
							<dd><g:meta name="app.grails.version"/></dd>
							
							<dt>Versão do Groovy:</dt>
							<dd>${GroovySystem.getVersion()}</dd>
							
							<dt>Versão do JVM:</dt>
							<dd>${System.getProperty('java.version')}</dd>
							
							<dt>Banco de Dados:</dt>
							<dd>MySQL 8.0 (Docker)</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-warning">
					<div class="panel-heading">
						<h3 class="panel-title">API REST Endpoints</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-6">
								<h4>Operações Básicas</h4>
								<ul class="list-unstyled">
									<li><code>GET /api/tasks</code> - Listar todas as tarefas</li>
									<li><code>GET /api/tasks/:id</code> - Buscar tarefa por ID</li>
									<li><code>POST /api/tasks</code> - Criar nova tarefa</li>
									<li><code>PUT /api/tasks/:id</code> - Atualizar tarefa</li>
									<li><code>DELETE /api/tasks/:id</code> - Excluir tarefa</li>
								</ul>
							</div>
							<div class="col-md-6">
								<h4>Operações Especiais</h4>
								<ul class="list-unstyled">
									<li><code>PATCH /api/tasks/:id/status</code> - Atualizar status</li>
									<li><code>POST /tasks/batchUpdateStatus</code> - Atualizar múltiplas tarefas</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
