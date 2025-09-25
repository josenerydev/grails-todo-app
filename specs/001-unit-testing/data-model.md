# Modelo de Dados: Testes da TODO API

## Entidades

### Task
**Propósito**: Entidade de domínio principal representando uma tarefa no sistema TODO

**Campos**:
- `id` (Long): Chave primária, gerada automaticamente
- `title` (String): Título da tarefa, obrigatório, máximo 255 caracteres
- `description` (String): Descrição da tarefa, opcional, máximo 1000 caracteres
- `status` (TaskStatus): Status da tarefa, obrigatório, padrão PENDING
- `priority` (TaskPriority): Prioridade da tarefa, obrigatório, padrão MEDIUM
- `dateCreated` (Date): Timestamp de criação, gerado automaticamente
- `lastUpdated` (Date): Timestamp da última atualização, gerado automaticamente

**Constraints**:
- `title`: blank: false, maxSize: 255
- `description`: nullable: true, maxSize: 1000
- `status`: nullable: false
- `priority`: nullable: false

**Mapeamento do Banco de Dados**:
- Tabela: `tasks`
- Versão: false (sem bloqueio otimista)
- Ordenação: dateCreated desc

**Transições de Estado**:
- PENDING → COMPLETED (via atualização de status)
- COMPLETED → PENDING (via atualização de status)

### TaskStatus (Enum)
**Propósito**: Representa os possíveis status de tarefa

**Valores**:
- `PENDING` ("Pendente"): Tarefa não está concluída
- `COMPLETED` ("Concluída"): Tarefa está concluída

**Propriedades**:
- `displayName` (String): Nome legível por humanos
- `toString()`: Retorna displayName

### TaskPriority (Enum)
**Propósito**: Representa os níveis de prioridade da tarefa

**Valores**:
- `LOW` ("Baixa"): Tarefa de baixa prioridade
- `MEDIUM` ("Média"): Tarefa de prioridade média (padrão)
- `HIGH` ("Alta"): Tarefa de alta prioridade

**Propriedades**:
- `displayName` (String): Nome legível por humanos
- `toString()`: Retorna displayName

## Regras de Validação

### Validação de Task
1. **Validação de Título**:
   - Não deve estar em branco
   - Comprimento máximo: 255 caracteres
   - Obrigatório para criação de tarefa

2. **Validação de Descrição**:
   - Campo opcional
   - Comprimento máximo: 1000 caracteres
   - Pode ser null ou vazio

3. **Validação de Status**:
   - Deve ser valor válido do enum TaskStatus
   - Não pode ser null
   - Padrão: PENDING

4. **Validação de Prioridade**:
   - Deve ser valor válido do enum TaskPriority
   - Não pode ser null
   - Padrão: MEDIUM

### Validação de Enum
1. **TaskStatus**:
   - Apenas PENDING e COMPLETED são válidos
   - Valores de enum sensíveis a maiúsculas/minúsculas
   - Nomes de exibição são localizados (Português)

2. **TaskPriority**:
   - Apenas LOW, MEDIUM e HIGH são válidos
   - Valores de enum sensíveis a maiúsculas/minúsculas
   - Nomes de exibição são localizados (Português)

## Relacionamentos

### Auto-Relacionamentos de Task
- Nenhum (tarefas são entidades independentes)

### Relacionamentos Externos
- Nenhum (sistema TODO independente)

## Requisitos de Dados de Teste

### Dados de Teste Unitário
- Objetos mock para testes isolados
- Métodos de factory para criação consistente de dados
- Geração de dados aleatórios para casos extremos

### Dados de Teste de Integração
- Entidades reais de banco de dados com TestContainers
- Rollback de transação para isolamento de testes
- Limpeza entre testes

### Dados de Teste de API
- Exemplos de requisição/resposta JSON
- Dados de cenários de erro
- Dados de operações em lote

## Schema do Banco de Dados

### Tabela Tasks
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

### Índices
- Chave primária: `id`
- Índice de ordenação: `date_created` (decrescente)

### Constraints
- `title`: NOT NULL, comprimento máximo 255
- `description`: comprimento máximo 1000
- `status`: NOT NULL, apenas valores de enum
- `priority`: NOT NULL, apenas valores de enum
