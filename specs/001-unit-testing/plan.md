# Implementation Plan: Spock Unit Testing

**Branch**: `001-unit-testing` | **Date**: 2025-01-24 | **Spec**: [link]
**Input**: Feature specification from `/specs/001-unit-testing/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Fill the Constitution Check section based on the content of the constitution document.
4. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
5. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file (e.g., `CLAUDE.md` for Claude Code, `.github/copilot-instructions.md` for GitHub Copilot, `GEMINI.md` for Gemini CLI, `QWEN.md` for Qwen Code or `AGENTS.md` for opencode).
7. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Implementação de testes de unidade para aplicação TODO API usando Spock Framework, focando em validação da lógica de negócio e funcionalidades das classes existentes com mocking de dependências.

## Technical Context
**Language/Version**: Groovy 2.4 / Java 8  
**Primary Dependencies**: Spock Framework 1.3-groovy-2.4, H2 Database, GORM Mocking, Grails 2.5.6  
**Storage**: H2 in-memory para testes de domínio, GORM mocking para serviços  
**Testing**: Spock Framework com estrutura Given-When-Then  
**Target Platform**: Linux server (WSL2)  
**Project Type**: grails (single application with API + web interface)  
**Performance Goals**: Testes de unidade < 5s  
**Constraints**: Grails 2.5.6 fixo, compatibilidade com Groovy 2.4, cobertura mínima 80%  
**Scale/Scope**: POC de sistema legado, ~6 classes de teste unitário  

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Test-First Development (NON-NEGOTIABLE)
✅ **PASS**: TDD obrigatório implementado - todos os testes serão escritos antes da implementação usando Spock Framework

### Spock Framework Testing Standards  
✅ **PASS**: Estrutura Given-When-Then obrigatória definida, testes de unidade e integração especificados

### Legacy System Preservation
✅ **PASS**: Grails 2.5.6 mantido, compatibilidade com versões antigas preservada

### Docker-First Infrastructure
✅ **PASS**: MySQL via Docker Compose para desenvolvimento, H2 in-memory para testes unitários

### API Contract Stability
✅ **PASS**: Endpoints REST existentes mantidos, novos testes validam contratos

## Project Structure

### Documentation (this feature)
```
specs/001-unit-testing/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root)
```
# Grails 2.5.6 application structure
grails-app/
├── domain/todoapi/
│   └── Task.groovy
├── services/todoapi/
│   └── TaskService.groovy
├── controllers/todoapi/
│   ├── TaskController.groovy
│   └── TaskRestController.groovy
├── conf/
│   └── BuildConfig.groovy
├── views/
└── web-app/

src/groovy/todoapi/
├── TaskStatus.groovy
└── TaskPriority.groovy

test/
└── unit/todoapi/          # To be created
```

**Structure Decision**: Grails 2.5.6 single application (API + web interface)

## Phase 0: Outline & Research
1. **Extract unknowns from Technical Context** above:
   - Spock Framework 1.3-groovy-2.4 configuration for Grails 2.5.6
   - H2 in-memory database configuration for unit tests
   - GORM mocking strategies for service tests
   - Best practices for Given-When-Then structure in Spock
   - Random data generation patterns for test isolation
   - Mocking strategies for Grails services and controllers

2. **Generate and dispatch research agents**:
   ```
   Task: "Research Spock Framework 1.3-groovy-2.4 configuration for Grails 2.5.6"
   Task: "Research H2 in-memory database configuration for unit tests"
   Task: "Research GORM mocking strategies for service tests"
   Task: "Research best practices for Given-When-Then structure in Spock"
   Task: "Find random data generation patterns for test isolation"
   Task: "Research mocking strategies for Grails services and controllers"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

**Output**: research.md with all NEEDS CLARIFICATION resolved

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Task entity with constraints and relationships
   - TaskStatus and TaskPriority enums
   - Validation rules from requirements

2. **Generate unit test scenarios** from functional requirements:
   - Domain validation scenarios
   - Service method testing scenarios
   - Controller action testing scenarios
   - Error handling scenarios

3. **Extract test data requirements**:
   - Random data generation patterns
   - Mock object creation
   - Test isolation strategies
   - H2 in-memory database setup
   - GORM mocking configuration

4. **Update agent file incrementally** (O(1) operation):
   - Run `.specify/scripts/bash/update-agent-context.sh cursor`
   - Add Spock Framework + H2 + GORM mocking context
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency

**Output**: data-model.md, quickstart.md, agent-specific file

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `.specify/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (data model, quickstart)
- Each entity → unit test task [P] (H2 in-memory)
- Each service method → unit test task [P] (GORM mocking)
- Each controller action → unit test task [P] (Service mocking)
- Test data factory creation tasks
- H2 and GORM mocking configuration tasks

**Ordering Strategy**:
- Setup tasks first (dependencies, H2, GORM mocking, structure)
- Test data factory before unit tests
- Unit tests in parallel (independent files)
- Mark [P] for parallel execution (independent files)

**Estimated Output**: 12-17 numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| N/A | N/A | N/A |

## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [x] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented

---
*Based on Constitution v1.0.0 - See `/memory/constitution.md`*
