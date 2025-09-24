package todoapi

/**
 * Enum para representar os possíveis status de uma tarefa
 */
enum TaskStatus {
    PENDING("Pendente"),
    COMPLETED("Concluída")
    
    final String displayName
    
    TaskStatus(String displayName) {
        this.displayName = displayName
    }
    
    @Override
    String toString() {
        return displayName
    }
}
