package todoapi

/**
 * Enum para representar os possíveis níveis de prioridade de uma tarefa
 */
enum TaskPriority {
    LOW("Baixa"),
    MEDIUM("Média"),
    HIGH("Alta")
    
    final String displayName
    
    TaskPriority(String displayName) {
        this.displayName = displayName
    }
    
    @Override
    String toString() {
        return displayName
    }
}
