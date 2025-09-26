# Casos de Teste - TaskService

## Visão Geral
Este documento descreve os casos de teste para a classe `TaskService`, cobrindo métodos públicos e privados acessíveis via comportamento observável. Os casos incluem sucesso, falha e edge cases, com foco em contratos, invariantes e efeitos colaterais.

## 1. Testes para `listAllTasks()`

### 1.1 Cenários de Sucesso
- **TC001**: Deve retornar lista vazia quando não existem tarefas no banco
- **TC002**: Deve retornar todas as tarefas existentes quando há tarefas cadastradas
- **TC003**: Deve retornar lista com tarefas de diferentes status e prioridades

### 1.2 Cenários de Falha
- **TC004**: Deve lidar com falha de conexão com banco de dados
- **TC005**: Deve lidar com timeout de consulta ao banco

### 1.3 Edge Cases
- **TC006**: Deve retornar lista vazia quando banco está vazio mas acessível
- **TC007**: Deve lidar com grandes volumes de tarefas (performance)

## 2. Testes para `getTaskById(Long id)`

### 2.1 Cenários de Sucesso
- **TC008**: Deve retornar tarefa quando ID existe no banco
- **TC009**: Deve retornar tarefa com todos os campos preenchidos corretamente

### 2.2 Cenários de Falha
- **TC010**: Deve retornar null quando ID não existe no banco
- **TC011**: Deve lançar exceção quando ID é null
- **TC012**: Deve lançar exceção quando ID é negativo
- **TC013**: Deve lançar exceção quando ID é zero

### 2.3 Edge Cases
- **TC014**: Deve lidar com ID muito grande (Long.MAX_VALUE)
- **TC015**: Deve lidar com ID de tarefa excluída (soft delete)

## 3. Testes para `createTask(Map params)`

### 3.1 Cenários de Sucesso
- **TC016**: Deve criar tarefa com todos os parâmetros fornecidos
- **TC017**: Deve criar tarefa com apenas título obrigatório
- **TC018**: Deve definir status PENDING como padrão quando não fornecido
- **TC019**: Deve definir prioridade MEDIUM como padrão quando não fornecida
- **TC020**: Deve retornar tarefa criada com ID gerado

### 3.2 Cenários de Falha
- **TC021**: Deve lançar exceção quando params é null
- **TC022**: Deve lançar exceção quando título é null
- **TC023**: Deve lançar exceção quando título é vazio
- **TC024**: Deve lançar exceção quando título excede tamanho máximo
- **TC025**: Deve lançar exceção quando status inválido é fornecido
- **TC026**: Deve lançar exceção quando prioridade inválida é fornecida
- **TC027**: Deve lançar exceção quando falha ao salvar no banco

### 3.3 Edge Cases
- **TC028**: Deve lidar com descrição muito longa
- **TC029**: Deve lidar com caracteres especiais no título e descrição
- **TC030**: Deve lidar com parâmetros extras no Map
- **TC031**: Deve lidar com transação rollback em caso de erro

## 4. Testes para `updateTask(Long id, Map params)`

### 4.1 Cenários de Sucesso
- **TC032**: Deve atualizar todos os campos fornecidos
- **TC033**: Deve atualizar apenas campos fornecidos, mantendo outros inalterados
- **TC034**: Deve atualizar apenas título
- **TC035**: Deve atualizar apenas descrição
- **TC036**: Deve atualizar apenas status
- **TC037**: Deve atualizar apenas prioridade
- **TC038**: Deve retornar tarefa atualizada

### 4.2 Cenários de Falha
- **TC039**: Deve retornar null quando ID não existe
- **TC040**: Deve lançar exceção quando ID é null
- **TC041**: Deve lançar exceção quando params é null
- **TC042**: Deve lançar exceção quando título é vazio
- **TC043**: Deve lançar exceção quando status inválido é fornecido
- **TC044**: Deve lançar exceção quando prioridade inválida é fornecida
- **TC045**: Deve retornar null quando falha ao salvar

### 4.3 Edge Cases
- **TC046**: Deve lidar com Map vazio (não deve alterar nada)
- **TC047**: Deve lidar com parâmetros null no Map (não deve alterar campo)
- **TC048**: Deve lidar com atualização de tarefa já excluída
- **TC049**: Deve lidar com concorrência (dois updates simultâneos)

## 5. Testes para `deleteTask(Long id)`

### 5.1 Cenários de Sucesso
- **TC050**: Deve excluir tarefa quando ID existe
- **TC051**: Deve retornar true quando exclusão é bem-sucedida
- **TC052**: Deve remover tarefa do banco de dados

### 5.2 Cenários de Falha
- **TC053**: Deve retornar false quando ID não existe
- **TC054**: Deve lançar exceção quando ID é null
- **TC055**: Deve lançar exceção quando ID é negativo
- **TC056**: Deve lançar exceção quando falha ao excluir do banco

### 5.3 Edge Cases
- **TC057**: Deve lidar com exclusão de tarefa já excluída
- **TC058**: Deve lidar com exclusão de tarefa com dependências
- **TC059**: Deve lidar com rollback de transação em caso de erro

## 6. Testes para `updateTaskStatus(Long id, TaskStatus status)`

### 6.1 Cenários de Sucesso
- **TC060**: Deve atualizar status quando ID existe e status é válido
- **TC061**: Deve atualizar para PENDING
- **TC062**: Deve atualizar para IN_PROGRESS
- **TC063**: Deve atualizar para COMPLETED
- **TC064**: Deve atualizar para CANCELLED
- **TC065**: Deve retornar tarefa atualizada

### 6.2 Cenários de Falha
- **TC066**: Deve retornar null quando ID não existe
- **TC067**: Deve lançar exceção quando ID é null
- **TC068**: Deve lançar exceção quando status é null
- **TC069**: Deve retornar null quando falha ao salvar

### 6.3 Edge Cases
- **TC070**: Deve lidar com atualização para mesmo status
- **TC071**: Deve lidar com transições de status inválidas
- **TC072**: Deve lidar com concorrência na atualização de status

## 7. Testes para `updateTasksStatusBatch(List<Long> taskIds, TaskStatus newStatus)`

### 7.1 Cenários de Sucesso
- **TC073**: Deve atualizar status de todas as tarefas quando todos os IDs existem
- **TC074**: Deve atualizar status de tarefas válidas ignorando IDs inválidos
- **TC075**: Deve retornar true quando todas as atualizações são bem-sucedidas
- **TC076**: Deve processar lista vazia sem erro
- **TC077**: Deve processar lista com um único ID

### 7.2 Cenários de Falha
- **TC078**: Deve retornar false quando algum ID não existe
- **TC079**: Deve retornar false quando taskIds é null
- **TC080**: Deve retornar false quando newStatus é null
- **TC081**: Deve retornar false quando falha ao salvar alguma tarefa
- **TC082**: Deve retornar false quando todos os IDs são inválidos

### 7.3 Edge Cases
- **TC083**: Deve lidar com lista contendo IDs duplicados
- **TC084**: Deve lidar com lista contendo IDs negativos
- **TC085**: Deve lidar com lista contendo IDs zero
- **TC086**: Deve lidar com grandes volumes de IDs (performance)
- **TC087**: Deve lidar com falha parcial (algumas tarefas atualizadas, outras não)
- **TC088**: Deve manter transação atômica (todas ou nenhuma)

## Notas de Cobertura
- **Validação de parâmetros**: Verificar validação de entrada em todos os métodos
- **Interações com dependências**: Mockar Task domain class e verificar chamadas
- **Persistência e transações**: Verificar flush: true e comportamento transacional
- **Logging**: Verificar logs de erro e warning nos métodos apropriados
- **Idempotência**: Verificar comportamento de operações repetidas
- **Reentrância**: Verificar thread safety em operações concorrentes
- **Performance**: Verificar comportamento com grandes volumes de dados
- **Pontos a confirmar**: 
  - Comportamento exato de validação de Task domain class
  - Estratégia de rollback em operações em lote
  - Tratamento de exceções específicas do Grails/Hibernate
  - Configuração de timeout para operações de banco
