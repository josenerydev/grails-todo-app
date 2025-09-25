#!/bin/bash

# Script para executar testes de integração com MySQL via Docker Compose
echo "=== EXECUTANDO TESTES DE INTEGRAÇÃO COM MYSQL ==="

# Função para limpar containers em caso de erro
cleanup() {
    echo ""
    echo "=== LIMPANDO CONTAINERS ==="
    docker-compose -f docker-compose.test.yml down
}

# Configurar trap para limpeza em caso de erro
trap cleanup EXIT

# 1. Iniciar MySQL container diretamente com Docker Compose
echo "Iniciando MySQL container..."
docker-compose -f docker-compose.test.yml up -d

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao iniciar MySQL container"
    exit 1
fi

# 2. Aguardar MySQL estar pronto
echo "Aguardando MySQL estar pronto..."
sleep 30

# 3. Verificar se MySQL está rodando
echo "Verificando se MySQL está rodando..."
docker exec todo-mysql-test mysqladmin ping -h localhost -u root -ppassword

if [ $? -ne 0 ]; then
    echo "ERRO: MySQL não está respondendo"
    exit 1
fi

echo "MySQL está rodando!"

# 4. Executar script de inicialização
echo "Executando script de inicialização..."
docker exec -i todo-mysql-test mysql -u root -ppassword < docker-entrypoint-initdb.d/init.sql

# 5. Executar testes de integração com MySQL
echo "Executando testes de integração com MySQL..."
GRAILS_OPTS="-Dgrails.datasource.url=jdbc:mysql://localhost:3307/todo_dev?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true -Dgrails.datasource.username=todo_user -Dgrails.datasource.password=password -Dgrails.datasource.driverClassName=com.mysql.cj.jdbc.Driver" grails test-app integration: -coverage

# 6. Capturar resultado
TEST_RESULT=$?

if [ $TEST_RESULT -eq 0 ]; then
    echo "Testes executados com sucesso!"
else
    echo "Testes falharam com código: $TEST_RESULT"
fi

exit $TEST_RESULT
