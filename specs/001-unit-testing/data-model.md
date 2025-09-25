# Data Model: TODO API Testing

## Entities

### Task
**Purpose**: Core domain entity representing a task in the TODO system

**Fields**:
- `id` (Long): Primary key, auto-generated
- `title` (String): Task title, required, max 255 characters
- `description` (String): Task description, optional, max 1000 characters
- `status` (TaskStatus): Task status, required, default PENDING
- `priority` (TaskPriority): Task priority, required, default MEDIUM
- `dateCreated` (Date): Creation timestamp, auto-generated
- `lastUpdated` (Date): Last update timestamp, auto-generated

**Constraints**:
- `title`: blank: false, maxSize: 255
- `description`: nullable: true, maxSize: 1000
- `status`: nullable: false
- `priority`: nullable: false

**Database Mapping**:
- Table: `tasks`
- Version: false (no optimistic locking)
- Sort: dateCreated desc

**State Transitions**:
- PENDING → COMPLETED (via status update)
- COMPLETED → PENDING (via status update)

### TaskStatus (Enum)
**Purpose**: Represents possible task statuses

**Values**:
- `PENDING` ("Pendente"): Task is not completed
- `COMPLETED` ("Concluída"): Task is completed

**Properties**:
- `displayName` (String): Human-readable name
- `toString()`: Returns displayName

### TaskPriority (Enum)
**Purpose**: Represents task priority levels

**Values**:
- `LOW` ("Baixa"): Low priority task
- `MEDIUM` ("Média"): Medium priority task (default)
- `HIGH` ("Alta"): High priority task

**Properties**:
- `displayName` (String): Human-readable name
- `toString()`: Returns displayName

## Validation Rules

### Task Validation
1. **Title Validation**:
   - Must not be blank
   - Maximum length: 255 characters
   - Required for task creation

2. **Description Validation**:
   - Optional field
   - Maximum length: 1000 characters
   - Can be null or empty

3. **Status Validation**:
   - Must be valid TaskStatus enum value
   - Cannot be null
   - Default: PENDING

4. **Priority Validation**:
   - Must be valid TaskPriority enum value
   - Cannot be null
   - Default: MEDIUM

### Enum Validation
1. **TaskStatus**:
   - Only PENDING and COMPLETED are valid
   - Case-sensitive enum values
   - Display names are localized (Portuguese)

2. **TaskPriority**:
   - Only LOW, MEDIUM, and HIGH are valid
   - Case-sensitive enum values
   - Display names are localized (Portuguese)

## Relationships

### Task Self-Relationships
- None (tasks are independent entities)

### External Relationships
- None (standalone TODO system)

## Test Data Requirements

### Unit Test Data
- Mock objects for isolated testing
- Factory methods for consistent data creation
- Random data generation for edge cases

### Integration Test Data
- Real database entities with TestContainers
- Transaction rollback for test isolation
- Cleanup between tests

### API Test Data
- JSON request/response examples
- Error scenario data
- Batch operation data

## Database Schema

### Tasks Table
```sql
CREATE TABLE tasks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    status VARCHAR(20) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Indexes
- Primary key: `id`
- Sort index: `date_created` (descending)

### Constraints
- `title`: NOT NULL, max length 255
- `description`: max length 1000
- `status`: NOT NULL, enum values only
- `priority`: NOT NULL, enum values only
