# Tarefas: Testes de Unidade com Spock

**Entrada**: Documentos de design de `/specs/001-unit-testing/`
**Pré-requisitos**: plan.md (obrigatório), research.md, data-model.md

## Fluxo de Execução (principal)
```
1. Carregar plan.md do diretório da funcionalidade
   → Se não encontrado: ERRO "Nenhum plano de implementação encontrado"
   → Extrair: stack tecnológico, bibliotecas, estrutura
2. Carregar documentos de design opcionais:
   → data-model.md: Extrair entidades → tarefas de modelo
   → contracts/: Cada arquivo → tarefa de teste de contrato
   → research.md: Extrair decisões → tarefas de configuração
3. Gerar tarefas por categoria:
   → Configuração: inicialização do projeto, dependências, linting
   → Testes: testes de contrato, testes de integração
   → Core: modelos, serviços, comandos CLI
   → Integração: DB, middleware, logging
   → Polimento: testes unitários, performance, docs
4. Aplicar regras de tarefas:
   → Arquivos diferentes = marcar [P] para paralelo
   → Mesmo arquivo = sequencial (sem [P])
   → Testes antes da implementação (TDD)
5. Numerar tarefas sequencialmente (T001, T002...)
6. Gerar grafo de dependências
7. Criar exemplos de execução paralela
8. Validar completude das tarefas:
   → Todos os contratos têm testes?
   → Todas as entidades têm modelos?
   → Todos os endpoints implementados?
9. Retornar: SUCESSO (tarefas prontas para execução)
```

## Formato: `[ID] [P?] Descrição`
- **[P]**: Pode executar em paralelo (arquivos diferentes, sem dependências)
- Incluir caminhos exatos de arquivos nas descrições

## Convenções de Caminho
- **Projeto Grails**: `grails-app/`, `test/` na raiz do repositório
- **Estrutura de teste**: `test/unit/`, `test/integration/`
- **Configuração**: `grails-app/conf/`

## Fase 3.1: Configuração
- [ ] T001 Configurar dependências do Spock Framework em grails-app/conf/BuildConfig.groovy
- [ ] T002 Configurar banco de dados H2 in-memory para testes unitários em grails-app/conf/BuildConfig.groovy
- [ ] T003 Configurar dependências de mocking do GORM em grails-app/conf/BuildConfig.groovy
- [ ] T004 [P] Criar estrutura de diretórios de teste (test/unit/todoapi/)
- [ ] T005 [P] Criar TaskTestFactory para geração de dados aleatórios em test/unit/todoapi/TaskTestFactory.groovy

## Fase 3.2: Testes de Unidade (TDD) ⚠️ DEVE COMPLETAR ANTES DE 3.3
**CRÍTICO: Estes testes DEVEM ser escritos e DEVEM FALHAR antes de QUALQUER implementação**

### Testes de Domínio (H2 in-memory)
- [ ] T006 [P] Testes unitários do domínio Task em test/unit/todoapi/TaskSpec.groovy
- [ ] T007 [P] Testes do enum TaskStatus em test/unit/todoapi/TaskStatusSpec.groovy
- [ ] T008 [P] Testes do enum TaskPriority em test/unit/todoapi/TaskPrioritySpec.groovy

### Testes de Serviço (mocking GORM)
- [ ] T009 [P] Testes unitários do TaskService em test/unit/todoapi/TaskServiceSpec.groovy

### Testes de Controlador (mocking de serviço)
- [ ] T010 [P] Testes unitários do TaskController em test/unit/todoapi/TaskControllerSpec.groovy
- [ ] T011 [P] Testes unitários do TaskRestController em test/unit/todoapi/TaskRestControllerSpec.groovy

## Fase 3.3: Verificação dos Testes (APENAS após os testes falharem)
**NOTA: Todas as classes principais já existem - focar em fazer os testes passarem**
- [ ] T012 [P] Verificar se as constraints de validação do domínio Task funcionam corretamente com H2
- [ ] T013 [P] Verificar se o enum TaskStatus com displayName funciona corretamente
- [ ] T014 [P] Verificar se o enum TaskPriority com displayName funciona corretamente
- [ ] T015 [P] Verificar se as operações CRUD do TaskService funcionam corretamente com mocking GORM
- [ ] T016 [P] Verificar se as ações web do TaskController funcionam corretamente com mocking de serviço
- [ ] T017 [P] Verificar se os endpoints da API do TaskRestController funcionam corretamente com mocking de serviço

## Fase 3.4: Polimento
*Removido para simplicidade - focar apenas nos testes unitários principais*

## Dependências
- Testes (T006-T011) antes da verificação (T012-T017)
- T004 bloqueia toda criação de testes (T006-T011)
- T005 bloqueia T006-T011 (TaskTestFactory necessário para testes unitários)
- T002 bloqueia T006-T008 (H2 necessário para testes de domínio)
- T003 bloqueia T009 (mocking GORM necessário para testes de serviço)

## Exemplo Paralelo
```
# Lançar T006-T011 juntos (Testes de Unidade):
Tarefa: "Testes unitários do domínio Task em test/unit/todoapi/TaskSpec.groovy"
Tarefa: "Testes do enum TaskStatus em test/unit/todoapi/TaskStatusSpec.groovy"
Tarefa: "Testes do enum TaskPriority em test/unit/todoapi/TaskPrioritySpec.groovy"
Tarefa: "Testes unitários do TaskService em test/unit/todoapi/TaskServiceSpec.groovy"
Tarefa: "Testes unitários do TaskController em test/unit/todoapi/TaskControllerSpec.groovy"
Tarefa: "Testes unitários do TaskRestController em test/unit/todoapi/TaskRestControllerSpec.groovy"

# Lançar T012-T017 juntos (Verificação dos Testes):
Tarefa: "Verificar se as constraints de validação do domínio Task funcionam corretamente com H2"
Tarefa: "Verificar se o enum TaskStatus com displayName funciona corretamente"
Tarefa: "Verificar se o enum TaskPriority com displayName funciona corretamente"
Tarefa: "Verificar se as operações CRUD do TaskService funcionam corretamente com mocking GORM"
Tarefa: "Verificar se as ações web do TaskController funcionam corretamente com mocking de serviço"
Tarefa: "Verificar se os endpoints da API do TaskRestController funcionam corretamente com mocking de serviço"
```

## Requisitos de Cobertura de Testes
- **Testes de Unidade**: Todas as classes de domínio, serviços, controladores
- **Testes de Domínio**: Constraints de validação, lógica de negócio (H2 in-memory)
- **Testes de Serviço**: Operações CRUD, regras de negócio (mocking GORM)
- **Testes de Controlador**: Ações web, endpoints REST, tratamento de erros (mocking de serviço)
- **Performance**: < 5s tempo de execução
- **Cobertura**: Foco no teste de funcionalidades principais

## Requisitos do Spock Framework
- **Estrutura**: Blocos Given-When-Then em todos os testes
- **Mocking**: Usar mocking do Spock para testes unitários
- **Dados**: Geração de dados aleatórios com TaskTestFactory
- **Isolamento**: Mocking para isolamento de dependências
- **Banco de Dados**: H2 in-memory para testes de domínio, mocking GORM para serviços
- **Paralelo**: Suporte a execução paralela de testes
- **Nomenclatura**: Padrão `nomeMetodo_Condicao_ResultadoEsperado`
- **Estrutura AAA**: Comentários ARRANGE-ACT-ASSERT em todos os testes

## Padrões de Nomenclatura de Testes

### Formato Obrigatório: `nomeMetodo_Condicao_ResultadoEsperado`

**Exemplos para cada classe**:

#### TaskService
- `createTask_WithValidData_ShouldReturnCreatedTask`
- `createTask_WithEmptyTitle_ShouldThrowValidationException`
- `updateTask_WithExistingId_ShouldUpdateSuccessfully`
- `deleteTask_WithNonExistentId_ShouldThrowNotFoundException`
- `listTasks_WhenNoTasksExist_ShouldReturnEmptyList`
- `getTask_WithValidId_ShouldReturnTask`

#### TaskController
- `index_WhenTasksExist_ShouldDisplayTasksInModel`
- `create_WithValidData_ShouldRedirectToIndex`
- `create_WithInvalidData_ShouldShowValidationErrors`
- `edit_WithValidId_ShouldShowEditForm`
- `update_WithValidData_ShouldRedirectToIndex`

#### TaskRestController
- `getTasks_WhenCalled_ShouldReturnJsonList`
- `getTask_WithValidId_ShouldReturnJsonTask`
- `createTask_WithValidJson_ShouldReturnCreatedTask`
- `updateTask_WithValidData_ShouldReturnUpdatedTask`
- `deleteTask_WithValidId_ShouldReturnNoContent`

#### Task Domain
- `validate_WithValidData_ShouldPassValidation`
- `validate_WithEmptyTitle_ShouldFailValidation`
- `validate_WithLongTitle_ShouldFailValidation`

### Estrutura AAA Obrigatória
```groovy
def "nomeMetodo_Condicao_ResultadoEsperado"() {
    // ARRANGE - Preparar dados de teste
    given: "descrição do estado inicial"
        // configuração dos dados
    
    // ACT - Executar ação sendo testada
    when: "descrição da ação"
        // execução do método
    
    // ASSERT - Verificar resultados
    then: "descrição do resultado esperado"
        // verificações
}
```

## Notas
- Tarefas [P] = arquivos diferentes, sem dependências
- Todas as classes principais já existem - focar no teste de funcionalidades existentes
- Apenas testes unitários - sem testes de integração ou TestContainers
- H2 in-memory para testes de domínio, mocking GORM para serviços
- Escopo simplificado - sem tarefas de polimento (T018-T022 removidas)
- Verificar se os testes falham antes de implementar
- Commit após cada tarefa
- Seguir ciclo TDD: Vermelho → Verde → Refatorar
- Usar Spock Framework 1.3-groovy-2.4
- Manter compatibilidade com Grails 2.5.6
- Enums estão localizados em src/groovy/todoapi/ (não em grails-app/)
- **OBRIGATÓRIO**: Seguir padrão de nomenclatura e estrutura AAA em todos os testes

## Regras de Geração de Tarefas
*Aplicadas durante execução main()*

1. **Do Modelo de Dados**:
   - Entidade Task → tarefa de teste unitário [P]
   - Enum TaskStatus → tarefa de teste unitário [P]
   - Enum TaskPriority → tarefa de teste unitário [P]
   
2. **Das Classes Existentes**:
   - TaskService → tarefa de teste unitário [P]
   - TaskController → tarefa de teste unitário [P]
   - TaskRestController → tarefa de teste unitário [P]
   
3. **Dos Requisitos**:
   - Cenários de validação → tarefa de teste unitário [P]
   - Tratamento de erros → tarefa de teste unitário [P]

4. **Ordenação**:
   - Configuração → Testes → Verificação
   - Dependências bloqueiam execução paralela

## Lista de Verificação de Validação
*PORTÃO: Verificado por main() antes de retornar*

- [x] Todas as entidades têm tarefas de teste unitário
- [x] Todas as classes existentes têm tarefas de teste unitário
- [x] Todos os testes vêm antes da verificação
- [x] Tarefas paralelas verdadeiramente independentes
- [x] Cada tarefa especifica caminho exato do arquivo
- [x] Nenhuma tarefa modifica o mesmo arquivo que outra tarefa [P]
- [x] Requisitos do Spock Framework atendidos
- [x] Apenas testes unitários (sem integração)
- [x] Escopo simplificado (sem tarefas de polimento)
