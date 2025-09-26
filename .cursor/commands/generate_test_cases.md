# .cursor/commands/generate_test_cases.md

## Comando: Generate Test Cases

**Objetivo:** gerar um documento de casos de teste para uma classe específica, criando uma estrutura oculta `.test-cases/<ClassName>/Test-Cases-<ClassName>.md`.

### Parâmetros
- `class_name` (obrigatório): Nome exato da classe (ex.: `ReceivableAnticipationRequesterAnalysisService`).
- `class_path` (opcional, recomendado): Caminho do arquivo da classe para leitura/inspeção (ex.: `app/services/ReceivableAnticipationRequesterAnalysisService.groovy`).
- `output_root` (opcional): Diretório raiz para saída. **Default:** `.test-cases`.

### Instruções para o Agent

1. **Localizar e inspecionar a classe**
   - Se `class_path` for fornecido, ler o arquivo de código.
   - Se não for, procurar pela definição da classe `{{class_name}}` no workspace.
   - Extrair a assinatura da classe e a lista de **métodos públicos** e, quando possível, **métodos privados** relevantes (chamados pelos públicos).
   - Mapear dependências e comportamentos observáveis (retornos, exceções, efeitos colaterais).

2. **Criar estrutura de pastas**
   - Criar diretório `{{output_root | default(".test-cases")}}/{{class_name}}` (criar recursivamente se necessário).

3. **Gerar arquivo de casos**
   - Criar/atualizar `{{output_root | default(".test-cases")}}/{{class_name}}/Test-Cases-{{class_name}}.md` com o conteúdo abaixo.
   - O documento deve:
     - Ter **Visão Geral** da classe.
     - Listar **casos por método**, separados em **Sucesso**, **Falha** e **Edge Cases**.
     - Nomear casos como `TC001`, `TC002`, … (incremental e estável).
     - Referenciar pré-condições, entradas, mocks/stubs e resultados esperados (incluindo exceções).
     - Incluir “Notas de Cobertura” com lacunas ou dúvidas.

4. **Regras de formatação**
   - Usar Markdown válido.
   - Títulos `##` para métodos, `###` para seções internas.
   - Bullets concisos, cada caso com 1–2 linhas (objetivo → resultado esperado).

5. **Conteúdo base (template)**
   - Se existir conhecimento específico da classe (via leitura do código), preencher com casos concretos.
   - Se não, gerar template genérico com placeholders inferidos dos nomes/assinaturas.

---

# Casos de Teste - {{class_name}}

## Visão Geral
Este documento descreve os casos de teste para a classe `{{class_name}}`, cobrindo métodos públicos e privados acessíveis via comportamento observável. Os casos incluem sucesso, falha e edge cases, com foco em contratos, invariantes e efeitos colaterais.

{{#each methods as |m i|}}
## {{addOne i}}. Testes para `{{m.signature}}`

### {{addOne i}}.1 Cenários de Sucesso
- **TC{{tc "S"}}**: Deve retornar resultado esperado quando entradas válidas e estado consistente
{{#if m.domainExamples.success}}
{{#each m.domainExamples.success}}
- **TC{{tc "S"}}**: {{this}}
{{/each}}
{{/if}}

### {{addOne i}}.2 Cenários de Falha
- **TC{{tc "F"}}**: Deve lançar exceção apropriada quando entrada obrigatória ausente/nula
{{#if m.domainExamples.failure}}
{{#each m.domainExamples.failure}}
- **TC{{tc "F"}}**: {{this}}
{{/each}}
{{/if}}

### {{addOne i}}.3 Edge Cases
- **TC{{tc "E"}}**: Limites (mín./máx.), coleções vazias, duplicados, valores extremos, race conditions controláveis
{{#if m.domainExamples.edge}}
{{#each m.domainExamples.edge}}
- **TC{{tc "E"}}**: {{this}}
{{/each}}
{{/if}}

{{/each}}

## Notas de Cobertura
- Validação de parâmetros, conversões e mapeamentos
- Interações com dependências (mocks/stubs/spies), idempotência, reentrância
- Persistência, transações, timeouts, retries, logging e métricas
- Pontos a confirmar: regras de negócio ambíguas ou não documentadas

---

### Exemplo preenchido (se a classe for `ReceivableAnticipationRequesterAnalysisService` e existir método `saveIfNecessary(Long customerId, BillingType billingType)`)

## 1. Testes para `saveIfNecessary(Long customerId, BillingType billingType)`

### 1.1 Cenários de Sucesso
- **TC001**: Deve retornar análise existente quando já existe uma análise pendente para o cliente e billing type
- **TC002**: Deve criar nova análise quando não existe análise para o cliente e billing type
- **TC003**: Deve criar nova análise quando existe análise expirada para o cliente e billing type
- **TC004**: Deve retornar análise existente quando existe análise em progresso para o cliente e billing type
- **TC005**: Deve retornar análise existente quando existe análise aprovada não expirada para o cliente e billing type

### 1.2 Cenários de Falha
- **TC006**: Deve lançar exceção quando `customerId` é `null`
- **TC007**: Deve lançar exceção quando `billingType` é `null`
- **TC008**: Deve lançar exceção quando `customerId` não existe no banco
- **TC009**: Deve lançar exceção quando falha ao salvar nova análise
- **TC010**: Deve lançar exceção quando `billingType` não tem `equivalentToRequesterAnalysisBillingType` implementado

---

### Pós-condições do comando
- Garantir que o arquivo foi criado/atualizado sem erros.
- Exibir caminho final do arquivo gerado.
- Se a lista de métodos não puder ser inferida, deixar apenas o template genérico para edição manual.
