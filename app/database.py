import mysql.connector

#Bloco de configuação de banco de dados do projeto - Inicio
def conectar_banco():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="PhoenixData"
        )
        return db
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {str(e)}")
        return None

def configurar_e_criar_tabelas(cursor):
    # Criação do banco de dados
    cursor.execute("CREATE DATABASE IF NOT EXISTS PhoenixData")

    # Uso do banco de dados
    cursor.execute("USE PhoenixData")

    # Criação da tabela usuarios
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS usuarios (
            Email VARCHAR(255) UNIQUE NOT NULL,
            Username VARCHAR(255) PRIMARY KEY NOT NULL,
            Nome VARCHAR(100) NOT NULL,
            Sobrenome VARCHAR(100) NOT NULL,
            Senha VARCHAR(255) NOT NULL,
            Tipo_Usuario VARCHAR(50) NOT NULL,
            Cidade VARCHAR(100) NOT NULL,
            Bairro VARCHAR(100),
            Estado VARCHAR(50) NOT NULL
        )
    """)

    # Criação da tabela fotografos
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS fotografos (
            CPF VARCHAR(11) PRIMARY KEY NOT NULL,
            Username_fotografo VARCHAR(255) UNIQUE NOT NULL,
            Foto_Perfil VARCHAR(255),
            Contato VARCHAR(15) NOT NULL,
            Area_Atuacao VARCHAR(100) NOT NULL,
            Username_usuario VARCHAR(255) NOT NULL,
            FOREIGN KEY (Username_usuario) REFERENCES usuarios(Username)
        )
    """)

    return "Banco de dados e tabelas criados com sucesso!"