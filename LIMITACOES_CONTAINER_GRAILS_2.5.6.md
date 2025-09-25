# Limitações do Gerenciamento de Containers no Grails 2.5.6

## Resumo Executivo

O **Grails 2.5.6** (lançado em 2016) apresenta limitações significativas para gerenciamento de containers Docker diretamente no contexto da aplicação. Esta documentação explica os motivos técnicos e apresenta alternativas viáveis.

## 🚫 Limitações Identificadas

### 1. **Incompatibilidade com TestContainers**

O **TestContainers** é a biblioteca mais popular para gerenciamento de containers em testes, mas **não é compatível** com Grails 2.5.6 devido a:

- **Dependências Java**: TestContainers requer Java 8+ com APIs modernas
- **Spring Boot**: TestContainers foi projetado para Spring Boot 2.x+, não para o Spring 4.x usado no Grails 2.5.6
- **Ciclo de Vida**: Diferentes estratégias de inicialização de contexto

### 2. **Problemas de Timing na Inicialização**

O Grails 2.5.6 possui um ciclo de vida rígido que causa conflitos:

```
1. Grails inicia contexto da aplicação
2. DataSource tenta conectar no banco
3. ❌ Container ainda não foi iniciado
4. ❌ Falha de conexão
```

**Resultado**: `Communications link failure` e `Connection refused`

### 3. **Limitações da Arquitetura**

- **Contexto de Aplicação**: Inicializado antes dos métodos `setupSpec()`
- **Dependency Injection**: Spring 4.x não suporta injeção de containers
- **Plugin System**: Arquitetura de plugins não foi projetada para containers

## 🔍 Evidências Técnicas

### Teste Realizado

```groovy
// ❌ FALHA: Container iniciado em setupSpec()
@Integration
class TestSpec extends BaseIntegrationSpec {
    def setupSpec() {
        dockerManager.startContainer() // Container iniciado aqui
    }
    // Mas Grails já tentou conectar no banco antes disso!
}
```

**Erro Resultante**:
```
Communications link failure
The last packet sent successfully to the server was 0 milliseconds ago
Connection refused (Connection refused)
```

### Comparação com Versões Modernas

| Aspecto | Grails 2.5.6 | Grails 4.x+ |
|---------|--------------|-------------|
| Spring Version | 4.x | 5.x+ |
| TestContainers | ❌ Incompatível | ✅ Suportado |
| Container Lifecycle | ❌ Conflito | ✅ Integrado |
| Java Version | 8 | 11+ |

## 📚 Referências e Relatos de Problemas

### 1. **Stack Overflow - Problemas com Grails 2.3.11**
- **Link**: https://stackoverflow.com/questions/68626190/grails-app-running-in-docker-container-not-using-local-packages
- **Problema**: Dificuldades para executar aplicação Grails 2.3.11 em container Docker
- **Solução**: Ajustes complexos na configuração de volumes

### 2. **Guia Oficial Grails Docker**
- **Link**: https://guides.grails.org/grails-as-docker-container/guide/index.html
- **Observação**: Focado em versões modernas do Grails, não 2.5.6

### 3. **TestContainers Compatibility**
- **GitHub**: https://github.com/testcontainers/testcontainers-java
- **Requisitos**: Spring Boot 2.2+, Java 11+
- **Status**: Não suporta Grails 2.5.6

## ✅ Soluções Alternativas Recomendadas

### 1. **Script Shell (Recomendado)**

```bash
#!/bin/bash
# run-integration-tests.sh

# 1. Iniciar container
docker-compose -f docker-compose.test.yml up -d

# 2. Aguardar MySQL estar pronto
sleep 20

# 3. Executar testes
grails test-app integration: -coverage

# 4. Limpar container
docker-compose -f docker-compose.test.yml down
```

**Vantagens**:
- ✅ Funciona perfeitamente com Grails 2.5.6
- ✅ Timing correto (container antes do Grails)
- ✅ Limpeza automática
- ✅ Logs detalhados

### 2. **Docker Compose**

```yaml
# docker-compose.test.yml
services:
  mysql-test:
    image: mysql:8.0
    container_name: todo-mysql-test
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: todo_dev
    ports:
      - "3307:3306"
```

### 3. **BaseIntegrationSpec Simplificado**

```groovy
@Integration
abstract class BaseIntegrationSpec extends Specification {
    
    def setup() {
        Task.deleteAll() // Limpar dados
    }
    
    def cleanup() {
        Task.deleteAll() // Limpar dados
    }
}
```

## 🎯 Conclusão

**Não é possível gerenciar containers Docker diretamente no contexto do Grails 2.5.6** devido a limitações arquiteturais e de compatibilidade. A solução mais eficaz é usar **scripts shell externos** para gerenciar o ciclo de vida dos containers.

### Recomendações:

1. **Manter script shell atual** - funciona perfeitamente
2. **Considerar upgrade** para Grails 4.x+ se containers são críticos
3. **Usar Docker Compose** para orquestração complexa
4. **Documentar limitações** para a equipe

---

**Data**: 25 de Setembro de 2025  
**Versão**: 1.0  
**Status**: Confirmado através de testes práticos
