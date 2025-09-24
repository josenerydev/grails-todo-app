class UrlMappings {

	static mappings = {
        // API REST routes
        "/api/tasks"(resources: "taskRest")
        
        // Web routes
        "/tasks"(resources: "task")
        
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
	}
}
