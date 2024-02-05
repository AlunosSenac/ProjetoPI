CREATE DATABASE IF NOT EXISTS visualdb;

USE visualdb;

DELIMITER $$

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    telefone VARCHAR(15),
    cpf VARCHAR(14) UNIQUE,
    email VARCHAR(255) UNIQUE NOT NULL,
    nome_usuario VARCHAR(50) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('Fotografo', 'Cliente') NOT NULL,
    cep VARCHAR(10),
    estado VARCHAR(50),
    cidade VARCHAR(50),
    bairro VARCHAR(50),
    rua VARCHAR(255),
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_conta ENUM('Ativo', 'Inativo') DEFAULT 'Inativo',
    imagem_perfil MEDIUMBLOB,  -- Armazena imagens de perfil como dados binários
    ultimo_login DATETIME, -- Alteração aqui
    tentativas_login INT DEFAULT 0
)$$

DELIMITER ;

CREATE TABLE IF NOT EXISTS fotografo (
    usuario_id INT PRIMARY KEY,
    categoria VARCHAR(255),
    url VARCHAR(255),
    bio VARCHAR(255),
    fotos MEDIUMBLOB,  -- Armazena imagens de fotógrafos como dados binários
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);

CREATE TABLE IF NOT EXISTS cliente (
    usuario_id INT PRIMARY KEY,  
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);
