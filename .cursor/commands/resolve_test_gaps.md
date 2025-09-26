# .cursor/commands/resolve_test_gaps.md

## Comando: Resolve Test Gaps

**Objetivo:** ler as pendências geradas por `.cursor/commands/map_test_stack.md`, fazer perguntas ao usuário no chat para tomar decisões e **atualizar os artefatos** em `.diagnostics/**` (sem alterar código-fonte do projeto).

### Parâmetros
- `project_root` (opcional): raiz do projeto. **Default:** `.`
- `output_root` (opcional): raiz dos artefatos. **Default:** `.diagnostics`
- `non_interactive` (opcional): `true` → usa padrões seguros; `false` → faz perguntas no chat. **Default:** `false`
- `auto_defaults` (opcional): quando `non_interactive=true`, define padrões por stack:
  - `.NET`: `xunit` + `coverlet.collector` + `FluentAssertions`
  - `Groovy/Grails`: `spock-core` + `jacoco`
- `apply_code_changes` (opcional): se `true`, autoriza **gerar apenas sugestões** em `DIAGNOSTICS-REPORT.md` (não altera código). **Default:** `false`

### Artefatos lidos/atualizados
- Lê:
  - `${output_root}/tests/pending.yaml`
  - `${output_root}/tests/test_tooling.json`
  - `${output_root}/stack/stack.json`
  - `${output_root}/evidence/detector.log` (apenas referência)
- Atualiza/cria:
  - `${output_root}/tests/pending.yaml` (inclui `status`, `decisions`, `questions`, `answers`)
  - `${output_root}/tests/test_tooling.json` (atualiza `frameworks`, `mocks`, `coverage`, `confidence`, `evidence`)
  - `${output_root}/DIAGNOSTICS-REPORT.md` (contadores e resumo)
  - `${output_root}/tests/resolutions.yaml` (histórico idempotente de decisões)
  - `${output_root}/tests/pending_questionnaire.md` (espelho das perguntas feitas no chat)

---

## Fluxo do Agent

1. **Carregar pendências**
   - Abrir `${output_root}/tests/pending.yaml`.
   - Se não existir ou estiver vazio, finalizar com nota no relatório (“Nenhuma pendência mapeada”).

2. **Para cada pendência (`pending[*]`)**
   - Garantir campos:
     - `id` (string, obrigatório)
     - `description` (string)
     - `severity` (`high|medium|low`)
     - `evidence` (array)
     - **Adicionar/normalizar**:
       - `status`: `open|waiting_for_user|answered|resolved|not_applicable|wontfix`
       - `questions`: array de strings
       - `answers`: mapa `pergunta -> resposta`
       - `decisions`: objeto com chaves específicas por tipo (ver “Regras de decisão”)
   - Se `non_interactive=true`: preencher `decisions` com `auto_defaults`, ajustar `status=answered`.
   - Caso contrário:
     - **Gerar perguntas** conforme “Modelo de perguntas por tipo”.
     - Exibir no chat em bloco numerado. Registrar respostas em `answers`.
     - Derivar `decisions` a partir das respostas (heurísticas abaixo).
     - Atualizar `status=answered` e, se aplicável, `status=resolved` quando não houver ação pendente.

3. **Aplicar decisões nos artefatos**
   - Atualizar `${output_root}/tests/test_tooling.json`:
     - Mesclar `testStacks[*].frameworks|mocks|coverage` por `name`.
     - Preencher `version` (se informada), `confidence` (`0.9` resposta explícita; `0.8` confirmada; `0.6` inferida; `0.5` default), `evidence` (ex.: `"resolve_test_gaps: <id> -> <decisao>"`).
   - Atualizar `${output_root}/DIAGNOSTICS-REPORT.md`:
     - Recontar pendências por `status`.
     - Adicionar seção “Atualizações desta execução” com bullets por pendência.
   - Registrar snapshot em `${output_root}/tests/resolutions.yaml` (append idempotente por `id` + timestamp ISO).
   - Gerar/atualizar `${output_root}/tests/pending_questionnaire.md` com perguntas e respostas consolidadas.

4. **Idempotência e merge**
   - Ao reexecutar, mesclar por `id`:
     - Não duplicar perguntas iguais.
     - Se uma resposta mudar, manter histórico em `resolutions.yaml` e sobrescrever `answers` atuais.
     - Recalcular `confidence` (se usuário confirmou, elevar para `0.9`).

5. **Saída**
   - Exibir caminhos dos artefatos atualizados.
   - Se `apply_code_changes=true`, **apenas** anexar ao relatório sugestões de commits/patches (sem gravar no projeto).

---

## Modelo de perguntas por tipo

### 1) Definir framework de testes (.NET)
- `Qual framework de testes .NET você prefere? (xunit|nunit|mstest)`
- `Deseja adicionar assertions auxiliares? (FluentAssertions|None)`
- `Deseja configurar cobertura? (coverlet.collector|coverlet.msbuild|None)`
- `Há padrão de nome de projetos de teste? (ex.: *.Tests|*.UnitTests)`

**Decisões derivadas (`decisions.framework_dotnet`):**
```yaml
framework: xunit|nunit|mstest
assertions: FluentAssertions|None
coverage: coverlet.collector|coverlet.msbuild|None
test_project_pattern: "*.Tests"
