# .cursor/commands/map_test_stack.md

## Comando: Map Test Stack

**Objetivo:** escanear o projeto, identificar tecnologias (ex.: .NET, Groovy/Grails), ferramentas de teste/mocks/cobertura existentes e produzir artefatos de diagnóstico. Se algo não for detectado, registrar pendências.

### Parâmetros
- `project_root` (opcional): diretório raiz. **Default:** `.`

### Saídas (em pastas ocultas)
- `.diagnostics/stack/stack.json`
- `.diagnostics/tests/test_tooling.json`
- `.diagnostics/tests/pending.yaml`
- `.diagnostics/evidence/detector.log`
- `.diagnostics/DIAGNOSTICS-REPORT.md`

---

## Instruções para o Agent

1. **Varredura Inicial**
   - Ler `project_root` e indexar arquivos relevantes (máx. 50k arquivos, ignorar `.git`, `bin`, `obj`, `build`, `out`, `node_modules`, `target`).
   - Capturar evidências (caminho + linha relevante) em `.diagnostics/evidence/detector.log`.

2. **Detecção de Stack**
   - **.NET**
     - Arquivos: `*.sln`, `*.csproj`, `Directory.Packages.props`, `global.json`, `Directory.Build.props`.
     - Extrair: `TargetFramework(s)`, `LangVersion`, `ImplicitUsings`, `Nullable`, `VersionPrefix/Version`.
     - Build: presença de `dotnet`/`msbuild` em pipelines (`azure-pipelines.yml`, `.github/workflows/*.yml`).
   - **Groovy/Grails**
     - Arquivos: `build.gradle[.kts]`, `settings.gradle[.kts]`, `gradle/wrapper/gradle-wrapper.properties`, `grails-app/**`, `application.yml`/`Config.groovy`.
     - Extrair: `GradleVersion`, `GrailsVersion`, `JavaVersion`, `sourceCompatibility`, `targetCompatibility`.
   - **Genérico (fallback)**
     - Detectar outras pistas (ex.: `package.json`, `pom.xml`, `pyproject.toml`) apenas para registrar, sem aprofundar.

3. **Detecção de Testes/Mocks/Cobertura**
   - **.NET**
     - Testes: `xunit`, `nunit`, `mstest.testadapter`, `mstest.testframework`.
     - Mocks/Asserts: `Moq`, `NSubstitute`, `FakeItEasy`, `FluentAssertions`, `Bogus`, `AutoFixture`.
     - Cobertura/Relatórios: `coverlet.collector`, `coverlet.msbuild`, `ReportGenerator`, `coverlet.console`.
     - Evidências em `<PackageReference Include="...">`, `packages.config`, `Directory.Packages.props`, `*.csproj` (capabilities `IsTestProject`, `OutputType`).
   - **Groovy/Grails**
     - Testes: `spock-core`, `spock-junit4/5`, `junit:junit`.
     - Navegação/E2E: `geb-spock`, `selenium-java`, `selenide`.
     - Mocks: `mockito-core`, `wiremock`, `groovy-mock` (via `GroovyMock`/`GroovySpy`).
     - Cobertura: `jacoco`, `cobertura` (legado).
     - Evidências em `dependencies { testImplementation ... }`, plugins `id("jacoco")`, tasks `test`, `jacocoTestReport`.

4. **Construção dos Artefatos**
   - Criar diretórios:
     - `.diagnostics/stack`
     - `.diagnostics/tests`
     - `.diagnostics/evidence`
   - Gerar `stack.json` e `test_tooling.json` seguindo os **esquemas** abaixo.
   - Gerar `pending.yaml` quando algo essencial não for detectado (ex.: ausência de framework de teste).
   - Gerar `DIAGNOSTICS-REPORT.md` com sumário estruturado.

5. **Regras**
   - Não modificar código-fonte do projeto.
   - Preferir extração por parsing leve (regex/DOM XML) aos caminhos usuais.
   - Quando múltiplas opções forem detectadas, listar todas com `confidence`.

---

## Esquemas de Saída

### `.diagnostics/stack/stack.json`
```json
{
  "projectRoot": "{{abs_path}}",
  "stacks": [
    {
      "name": ".NET",
      "confidence": 0.0,
      "artifacts": {
        "solutions": ["path/to/project.sln"],
        "projects": ["src/App/App.csproj"],
        "directoryPackagesProps": "Directory.Packages.props",
        "globalJson": "global.json",
        "buildProps": "Directory.Build.props"
      },
      "properties": {
        "targetFrameworks": ["net8.0"],
        "langVersion": "latest",
        "nullable": "enable",
        "implicitUsings": "enable"
      },
      "ciHints": {
        "workflows": [".github/workflows/build.yml"],
        "azurePipelines": ["azure-pipelines.yml"]
      }
    },
    {
      "name": "Groovy/Grails",
      "confidence": 0.0,
      "artifacts": {
        "buildFiles": ["build.gradle", "settings.gradle"],
        "wrapper": "gradle/wrapper/gradle-wrapper.properties",
        "grailsApp": "grails-app"
      },
      "properties": {
        "gradleVersion": "8.9",
        "grailsVersion": "2.5.6",
        "javaVersion": "1.8",
        "sourceCompatibility": "1.8",
        "targetCompatibility": "1.8"
      }
    }
  ],
  "otherSignals": {
    "node": { "packageJson": false },
    "maven": { "pomXml": false },
    "python": { "pyprojectToml": false }
  },
  "generatedAt": "{{iso_datetime}}"
}
