import mysql.connector

#Bloco de configuação de banco de dados do projeto - Inicio
def conectar_banco():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password=""
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
            Nick VARCHAR(255) PRIMARY KEY NOT NULL,
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
        Foto_Perfil VARCHAR(255),
        Contato VARCHAR(15) NOT NULL,
        Area_Atuacao VARCHAR(100) NOT NULL,
        Nick_usuario VARCHAR(255) NOT NULL,
        FOREIGN KEY (Nick_usuario) REFERENCES usuarios(Nick)
);
    """)

    return "Banco de dados e tabelas criados com sucesso!"

#Função de cadastro de usuario

def cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado, dados_fotografo=None):
    try:
        db = conectar_banco()
        cursor = db.cursor()

        # Consulta segura para inserir dados gerais do usuário
        consulta_usuario = """
            INSERT INTO usuarios (Email, Nick, Nome, Sobrenome, Senha, Tipo_Usuario, Cidade, Bairro, Estado)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Adicionar os dados gerais à lista de parâmetros para a consulta do usuário
        parametros_usuario = (email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado)

        # Executar a consulta segura para inserir dados gerais do usuário
        cursor.execute(consulta_usuario, parametros_usuario)

        # Se o tipo de usuário for fotógrafo, inserir dados específicos na tabela de fotógrafos
        if tipo_usuario == 'fotografo' and dados_fotografo:
            # Clonar o Nick para Nick_usuario
            nick_usuario = nick
            
            # Consulta segura para inserir dados específicos do fotógrafo
            consulta_fotografo = """
                INSERT INTO fotografos (CPF, Foto_Perfil, Contato, Area_Atuacao, Nick_usuario)
                VALUES (%s, %s, %s, %s, %s)
            """

            # Adicionar o nick à lista de parâmetros para a consulta do fotógrafo
            parametros_fotografo = (nick_usuario, ) + dados_fotografo

            # Executar a consulta segura para inserir dados específicos do fotógrafo
            cursor.execute(consulta_fotografo, parametros_fotografo)

        # Commit e fechar a conexão
        db.commit()
        db.close()

        return "Cadastro realizado com sucesso!"
    except Exception as e:
        return f"Erro ao cadastrar usuário: {str(e)}"
