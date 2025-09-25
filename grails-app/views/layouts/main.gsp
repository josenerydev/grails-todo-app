<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="pt-BR" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="pt-BR" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="pt-BR" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="pt-BR" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="pt-BR" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="TODO API"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
		
		<!-- Bootstrap 5 CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Bootstrap Icons -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
		<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<!-- Bootstrap 5 JS -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>
	</head>
	<body class="d-flex flex-column min-vh-100">
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div class="container-fluid px-4">
				<a class="navbar-brand fw-bold" href="${createLink(uri: '/')}">
					<i class="bi bi-check2-square me-2"></i>TODO API
				</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav me-auto">
						<li class="nav-item">
							<a class="nav-link ${controllerName == 'index' ? 'active' : ''}" href="${createLink(uri: '/')}">
								<i class="bi bi-house me-1"></i>Dashboard
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link ${controllerName == 'task' && actionName == 'index' ? 'active' : ''}" href="${createLink(controller: 'task', action: 'index')}">
								<i class="bi bi-list-ul me-1"></i>Tarefas
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link ${controllerName == 'task' && actionName == 'create' ? 'active' : ''}" href="${createLink(controller: 'task', action: 'create')}">
								<i class="bi bi-plus-circle me-1"></i>Nova Tarefa
							</a>
						</li>
					</ul>
					<ul class="navbar-nav">
						<li class="nav-item">
							<span class="navbar-text">
								Sistema de Gerenciamento de Tarefas
							</span>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- Main Content -->
		<main class="flex-grow-1">
			<div class="container-fluid px-4 py-4">
				<g:layoutBody/>
			</div>
		</main>
		
		<!-- Footer -->
		<footer class="bg-light text-center text-muted py-3 mt-auto">
			<div class="container-fluid px-4">
				<small>&copy; 2024 TODO API - Sistema de Gerenciamento de Tarefas</small>
			</div>
		</footer>
		
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	</body>
</html>