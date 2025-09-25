# Tasks: Spock Unit Testing

**Input**: Design documents from `/specs/001-unit-testing/`
**Prerequisites**: plan.md (required), research.md, data-model.md

## Execution Flow (main)
```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure
2. Load optional design documents:
   → data-model.md: Extract entities → model tasks
   → contracts/: Each file → contract test task
   → research.md: Extract decisions → setup tasks
3. Generate tasks by category:
   → Setup: project init, dependencies, linting
   → Tests: contract tests, integration tests
   → Core: models, services, CLI commands
   → Integration: DB, middleware, logging
   → Polish: unit tests, performance, docs
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Tests before implementation (TDD)
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness:
   → All contracts have tests?
   → All entities have models?
   → All endpoints implemented?
9. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths in descriptions

## Path Conventions
- **Grails project**: `grails-app/`, `test/` at repository root
- **Test structure**: `test/unit/`, `test/integration/`
- **Configuration**: `grails-app/conf/`

## Phase 3.1: Setup
- [ ] T001 Configure Spock Framework dependencies in grails-app/conf/BuildConfig.groovy
- [ ] T002 Configure H2 in-memory database for unit tests in grails-app/conf/BuildConfig.groovy
- [ ] T003 Configure GORM mocking dependencies in grails-app/conf/BuildConfig.groovy
- [ ] T004 [P] Create test directory structure (test/unit/todoapi/)
- [ ] T005 [P] Create TaskTestFactory for random data generation in test/unit/todoapi/TaskTestFactory.groovy

## Phase 3.2: Unit Tests (TDD) ⚠️ MUST COMPLETE BEFORE 3.3
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

### Domain Tests (H2 in-memory)
- [ ] T006 [P] Task domain unit tests in test/unit/todoapi/TaskSpec.groovy
- [ ] T007 [P] TaskStatus enum tests in test/unit/todoapi/TaskStatusSpec.groovy
- [ ] T008 [P] TaskPriority enum tests in test/unit/todoapi/TaskPrioritySpec.groovy

### Service Tests (GORM mocking)
- [ ] T009 [P] TaskService unit tests in test/unit/todoapi/TaskServiceSpec.groovy

### Controller Tests (Service mocking)
- [ ] T010 [P] TaskController unit tests in test/unit/todoapi/TaskControllerSpec.groovy
- [ ] T011 [P] TaskRestController unit tests in test/unit/todoapi/TaskRestControllerSpec.groovy

## Phase 3.3: Test Verification (ONLY after tests are failing)
**NOTE: All core classes already exist - focus on making tests pass**
- [ ] T012 [P] Verify Task domain validation constraints work correctly with H2
- [ ] T013 [P] Verify TaskStatus enum with displayName works correctly
- [ ] T014 [P] Verify TaskPriority enum with displayName works correctly
- [ ] T015 [P] Verify TaskService CRUD operations work correctly with GORM mocking
- [ ] T016 [P] Verify TaskController web actions work correctly with service mocking
- [ ] T017 [P] Verify TaskRestController API endpoints work correctly with service mocking

## Phase 3.4: Polish
*Removed for simplicity - focus on core unit testing only*

## Dependencies
- Tests (T006-T011) before verification (T012-T017)
- T004 blocks all test creation (T006-T011)
- T005 blocks T006-T011 (TaskTestFactory needed for unit tests)
- T002 blocks T006-T008 (H2 needed for domain tests)
- T003 blocks T009 (GORM mocking needed for service tests)

## Parallel Example
```
# Launch T006-T011 together (Unit Tests):
Task: "Task domain unit tests in test/unit/todoapi/TaskSpec.groovy"
Task: "TaskStatus enum tests in test/unit/todoapi/TaskStatusSpec.groovy"
Task: "TaskPriority enum tests in test/unit/todoapi/TaskPrioritySpec.groovy"
Task: "TaskService unit tests in test/unit/todoapi/TaskServiceSpec.groovy"
Task: "TaskController unit tests in test/unit/todoapi/TaskControllerSpec.groovy"
Task: "TaskRestController unit tests in test/unit/todoapi/TaskRestControllerSpec.groovy"

# Launch T012-T017 together (Test Verification):
Task: "Verify Task domain validation constraints work correctly with H2"
Task: "Verify TaskStatus enum with displayName works correctly"
Task: "Verify TaskPriority enum with displayName works correctly"
Task: "Verify TaskService CRUD operations work correctly with GORM mocking"
Task: "Verify TaskController web actions work correctly with service mocking"
Task: "Verify TaskRestController API endpoints work correctly with service mocking"
```

## Test Coverage Requirements
- **Unit Tests**: All domain classes, services, controllers
- **Domain Tests**: Validation constraints, business logic (H2 in-memory)
- **Service Tests**: CRUD operations, business rules (GORM mocking)
- **Controller Tests**: Web actions, REST endpoints, error handling (Service mocking)
- **Performance**: < 5s execution time
- **Coverage**: Focus on core functionality testing

## Spock Framework Requirements
- **Structure**: Given-When-Then blocks in all tests
- **Mocking**: Use Spock mocking for unit tests
- **Data**: Random data generation with TaskTestFactory
- **Isolation**: Mocking for dependency isolation
- **Database**: H2 in-memory for domain tests, GORM mocking for services
- **Parallel**: Support parallel test execution

## Notes
- [P] tasks = different files, no dependencies
- All core classes already exist - focus on testing existing functionality
- Unit tests only - no integration tests or TestContainers
- H2 in-memory for domain tests, GORM mocking for services
- Simplified scope - no polish tasks (T018-T022 removed)
- Verify tests fail before implementing
- Commit after each task
- Follow TDD cycle: Red → Green → Refactor
- Use Spock Framework 1.3-groovy-2.4
- Maintain Grails 2.5.6 compatibility
- Enums are located in src/groovy/todoapi/ (not grails-app/)

## Task Generation Rules
*Applied during main() execution*

1. **From Data Model**:
   - Task entity → unit test task [P]
   - TaskStatus enum → unit test task [P]
   - TaskPriority enum → unit test task [P]
   
2. **From Existing Classes**:
   - TaskService → unit test task [P]
   - TaskController → unit test task [P]
   - TaskRestController → unit test task [P]
   
3. **From Requirements**:
   - Validation scenarios → unit test task [P]
   - Error handling → unit test task [P]

4. **Ordering**:
   - Setup → Tests → Verification
   - Dependencies block parallel execution

## Validation Checklist
*GATE: Checked by main() before returning*

- [x] All entities have unit test tasks
- [x] All existing classes have unit test tasks
- [x] All tests come before verification
- [x] Parallel tasks truly independent
- [x] Each task specifies exact file path
- [x] No task modifies same file as another [P] task
- [x] Spock Framework requirements met
- [x] Unit testing only (no integration)
- [x] Simplified scope (no polish tasks)
