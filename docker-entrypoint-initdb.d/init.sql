-- Cria o banco de dados se não existir
CREATE DATABASE IF NOT EXISTS todo_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Cria o usuário e define a senha
CREATE USER IF NOT EXISTS 'todo_user'@'%' IDENTIFIED BY 'password';

-- Concede todas as permissões ao usuário no banco de dados todo_dev
GRANT ALL PRIVILEGES ON todo_dev.* TO 'todo_user'@'%';

-- Aplica as permissões
FLUSH PRIVILEGES;

-- Define configurações de charset e collation para o servidor
SET GLOBAL character_set_server = 'utf8mb4';
SET GLOBAL collation_server = 'utf8mb4_unicode_ci';
