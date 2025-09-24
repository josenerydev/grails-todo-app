package todoapi

/**
 * Classe de domínio Task para representar uma tarefa no sistema TODO
 */
class Task {
    
    String title
    String description
    TaskStatus status = TaskStatus.PENDING
    TaskPriority priority = TaskPriority.MEDIUM
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        title blank: false, maxSize: 255
        description nullable: true, maxSize: 1000
        status nullable: false
        priority nullable: false
    }
    
    static mapping = {
        table 'tasks'
        version false
        sort dateCreated: 'desc'
    }
    
    @Override
    String toString() {
        return title
    }
}
