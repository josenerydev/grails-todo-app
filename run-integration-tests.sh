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
sleep 20

# 3. Verificar se MySQL está rodando (com retry)
echo "Verificando se MySQL está rodando..."
MAX_ATTEMPTS=30
ATTEMPT=1

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo "Tentativa $ATTEMPT/$MAX_ATTEMPTS..."
    if docker exec todo-mysql-test mysqladmin ping -h localhost -u root -ppassword > /dev/null 2>&1; then
        echo "MySQL está rodando!"
        break
    fi
    
    if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
        echo "ERRO: MySQL não está respondendo após $MAX_ATTEMPTS tentativas"
        exit 1
    fi
    
    sleep 2
    ATTEMPT=$((ATTEMPT + 1))
done

# 4. Executar grails clean antes dos testes
echo "Executando grails clean..."
grails clean

# 5. Executar testes de integração com MySQL
echo "Executando testes de integração com MySQL..."
grails test-app integration: -coverage

# 6. Capturar resultado
TEST_RESULT=$?

if [ $TEST_RESULT -eq 0 ]; then
    echo "Testes executados com sucesso!"
else
    echo "Testes falharam com código: $TEST_RESULT"
fi

exit $TEST_RESULT
