# Plano de Implementação: Testes de Unidade com Spock

**Branch**: `001-unit-testing` | **Data**: 2025-01-24 | **Spec**: [link]
**Entrada**: Especificação da funcionalidade de `/specs/001-unit-testing/spec.md`

## Fluxo de Execução (escopo do comando /plan)
```
1. Carregar especificação da funcionalidade do caminho de entrada
   → Se não encontrado: ERRO "Nenhuma especificação de funcionalidade em {caminho}"
2. Preencher Contexto Técnico (procurar por NECESSITA ESCLARECIMENTO)
   → Detectar Tipo de Projeto do contexto (web=frontend+backend, mobile=app+api)
   → Definir Decisão de Estrutura baseada no tipo de projeto
3. Preencher a seção Verificação da Constituição baseada no conteúdo do documento da constituição.
4. Avaliar seção Verificação da Constituição abaixo
   → Se violações existirem: Documentar em Rastreamento de Complexidade
   → Se não for possível justificar: ERRO "Simplificar abordagem primeiro"
   → Atualizar Rastreamento de Progresso: Verificação Inicial da Constituição
5. Executar Fase 0 → research.md
   → Se NECESSITA ESCLARECIMENTO permanecer: ERRO "Resolver incógnitas"
6. Executar Fase 1 → contratos, data-model.md, quickstart.md, arquivo de template específico do agente (ex., `CLAUDE.md` para Claude Code, `.github/copilot-instructions.md` para GitHub Copilot, `GEMINI.md` para Gemini CLI, `QWEN.md` para Qwen Code ou `AGENTS.md` para opencode).
7. Re-avaliar seção Verificação da Constituição
   → Se novas violações: Refatorar design, retornar à Fase 1
   → Atualizar Rastreamento de Progresso: Verificação Pós-Design da Constituição
8. Planejar Fase 2 → Descrever abordagem de geração de tarefas (NÃO criar tasks.md)
9. PARAR - Pronto para comando /tasks
```

**IMPORTANTE**: O comando /plan PARA na etapa 7. As Fases 2-4 são executadas por outros comandos:
- Fase 2: comando /tasks cria tasks.md
- Fases 3-4: Execução da implementação (manual ou via ferramentas)

## Resumo
Implementação de testes de unidade para aplicação TODO API usando Spock Framework, focando na validação da lógica de negócio e funcionalidades das classes existentes com mocking de dependências.

## Contexto Técnico
**Linguagem/Versão**: Groovy 2.4 / Java 8  
**Dependências Principais**: Spock Framework 1.3-groovy-2.4, H2 Database, GORM Mocking, Grails 2.5.6  
**Armazenamento**: H2 in-memory para testes de domínio, GORM mocking para serviços  
**Testes**: Spock Framework com estrutura Given-When-Then  
**Plataforma Alvo**: Servidor Linux (WSL2)  
**Tipo de Projeto**: grails (aplicação única com API + interface web)  
**Objetivos de Performance**: Testes de unidade < 5s  
**Restrições**: Grails 2.5.6 fixo, compatibilidade com Groovy 2.4, cobertura mínima 80%  
**Escala/Escopo**: POC de sistema legado, ~6 classes de teste unitário  

## Verificação da Constituição
*PORTÃO: Deve passar antes da pesquisa da Fase 0. Re-verificar após o design da Fase 1.*

### Desenvolvimento Test-First (NÃO NEGOCIÁVEL)
✅ **PASSOU**: TDD obrigatório implementado - todos os testes serão escritos antes da implementação usando Spock Framework

### Padrões de Teste do Spock Framework  
✅ **PASSOU**: Estrutura Given-When-Then obrigatória definida, testes de unidade e integração especificados

### Preservação do Sistema Legado
✅ **PASSOU**: Grails 2.5.6 mantido, compatibilidade com versões antigas preservada

### Infraestrutura Docker-First
✅ **PASSOU**: MySQL via Docker Compose para desenvolvimento, H2 in-memory para testes unitários

### Estabilidade do Contrato da API
✅ **PASSOU**: Endpoints REST existentes mantidos, novos testes validam contratos

## Estrutura do Projeto

### Documentação (esta funcionalidade)
```
specs/001-unit-testing/
├── plan.md              # Este arquivo (saída do comando /plan)
├── research.md          # Saída da Fase 0 (comando /plan)
├── data-model.md        # Saída da Fase 1 (comando /plan)
├── quickstart.md        # Saída da Fase 1 (comando /plan)
├── contracts/           # Saída da Fase 1 (comando /plan)
└── tasks.md             # Saída da Fase 2 (comando /tasks - NÃO criado por /plan)
```

### Código Fonte (raiz do repositório)
```
# Estrutura da aplicação Grails 2.5.6
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
└── unit/todoapi/          # A ser criado
```

**Decisão de Estrutura**: Aplicação única Grails 2.5.6 (API + interface web)

## Fase 0: Esboço e Pesquisa
1. **Extrair incógnitas do Contexto Técnico** acima:
   - Configuração do Spock Framework 1.3-groovy-2.4 para Grails 2.5.6
   - Configuração do banco de dados H2 in-memory para testes unitários
   - Estratégias de mocking do GORM para testes de serviço
   - Melhores práticas para estrutura Given-When-Then no Spock
   - Padrões de geração de dados aleatórios para isolamento de testes
   - Estratégias de mocking para serviços e controladores Grails

2. **Gerar e despachar agentes de pesquisa**:
   ```
   Tarefa: "Pesquisar configuração do Spock Framework 1.3-groovy-2.4 para Grails 2.5.6"
   Tarefa: "Pesquisar configuração do banco de dados H2 in-memory para testes unitários"
   Tarefa: "Pesquisar estratégias de mocking do GORM para testes de serviço"
   Tarefa: "Pesquisar melhores práticas para estrutura Given-When-Then no Spock"
   Tarefa: "Encontrar padrões de geração de dados aleatórios para isolamento de testes"
   Tarefa: "Pesquisar estratégias de mocking para serviços e controladores Grails"
   ```

3. **Consolidar descobertas** em `research.md` usando formato:
   - Decisão: [o que foi escolhido]
   - Justificativa: [por que escolhido]
   - Alternativas consideradas: [o que mais foi avaliado]

**Saída**: research.md com todos os NECESSITA ESCLARECIMENTO resolvidos

## Fase 1: Design e Contratos
*Pré-requisitos: research.md completo*

1. **Extrair entidades da especificação da funcionalidade** → `data-model.md`:
   - Entidade Task com constraints e relacionamentos
   - Enums TaskStatus e TaskPriority
   - Regras de validação dos requisitos

2. **Gerar cenários de teste unitário** dos requisitos funcionais:
   - Cenários de validação de domínio
   - Cenários de teste de métodos de serviço
   - Cenários de teste de ações de controlador
   - Cenários de tratamento de erro

3. **Extrair requisitos de dados de teste**:
   - Padrões de geração de dados aleatórios
   - Criação de objetos mock
   - Estratégias de isolamento de testes
   - Configuração do banco de dados H2 in-memory
   - Configuração de mocking do GORM

4. **Atualizar arquivo do agente incrementalmente** (operação O(1)):
   - Executar `.specify/scripts/bash/update-agent-context.sh cursor`
   - Adicionar contexto Spock Framework + H2 + GORM mocking
   - Atualizar mudanças recentes (manter últimas 3)
   - Manter abaixo de 150 linhas para eficiência de tokens

**Saída**: data-model.md, quickstart.md, arquivo específico do agente

## Fase 2: Abordagem de Planejamento de Tarefas
*Esta seção descreve o que o comando /tasks fará - NÃO executar durante /plan*

**Estratégia de Geração de Tarefas**:
- Carregar `.specify/templates/tasks-template.md` como base
- Gerar tarefas dos documentos de design da Fase 1 (modelo de dados, quickstart)
- Cada entidade → tarefa de teste unitário [P] (H2 in-memory)
- Cada método de serviço → tarefa de teste unitário [P] (mocking GORM)
- Cada ação de controlador → tarefa de teste unitário [P] (mocking de serviço)
- Tarefas de criação de factory de dados de teste
- Tarefas de configuração de mocking H2 e GORM

**Estratégia de Ordenação**:
- Tarefas de configuração primeiro (dependências, H2, mocking GORM, estrutura)
- Factory de dados de teste antes dos testes unitários
- Testes unitários em paralelo (arquivos independentes)
- Marcar [P] para execução paralela (arquivos independentes)

**Saída Estimada**: 12-17 tarefas numeradas e ordenadas em tasks.md

**IMPORTANTE**: Esta fase é executada pelo comando /tasks, NÃO por /plan

## Fase 3+: Implementação Futura
*Essas fases estão além do escopo do comando /plan*

**Fase 3**: Execução de tarefas (comando /tasks cria tasks.md)  
**Fase 4**: Implementação (executar tasks.md seguindo princípios constitucionais)  
**Fase 5**: Validação (executar testes, executar quickstart.md, validação de performance)

## Rastreamento de Complexidade
*Preencher APENAS se Verificação da Constituição tiver violações que devem ser justificadas*

| Violação | Por que Necessário | Alternativa Mais Simples Rejeitada Porque |
|-----------|------------|-------------------------------------|
| N/A | N/A | N/A |

## Rastreamento de Progresso
*Esta lista de verificação é atualizada durante o fluxo de execução*

**Status das Fases**:
- [x] Fase 0: Pesquisa completa (comando /plan)
- [x] Fase 1: Design completo (comando /plan)
- [x] Fase 2: Planejamento de tarefas completo (comando /plan - descrever abordagem apenas)
- [x] Fase 3: Tarefas geradas (comando /tasks)
- [ ] Fase 4: Implementação completa
- [ ] Fase 5: Validação aprovada

**Status dos Portões**:
- [x] Verificação Inicial da Constituição: PASSOU
- [x] Verificação Pós-Design da Constituição: PASSOU
- [x] Todos os NECESSITA ESCLARECIMENTO resolvidos
- [x] Desvios de complexidade documentados

---
*Baseado na Constituição v1.0.0 - Ver `/memory/constitution.md`*
