-- Cria o banco de dados
CREATE DATABASE IF NOT EXISTS visual;

-- Usa o banco de dados
USE visual;

-- Cria a tabela perfilFotografos
CREATE TABLE IF NOT EXISTS perfilFotografos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    nome_usuario VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    foto_perfil VARCHAR(255),
    bio TEXT,
    url VARCHAR(255),
    rua VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(255),
    pais VARCHAR(255),
    codigo_postal VARCHAR(20)
);

-- Cria a tabela galeria
CREATE TABLE IF NOT EXISTS galeria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    perfil_id INT,
    foto_id INT,
    foto_url VARCHAR(255),
    descricao VARCHAR(255),
    FOREIGN KEY (perfil_id) REFERENCES perfilFotografos(id)
);

