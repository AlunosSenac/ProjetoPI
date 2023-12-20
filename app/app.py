from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

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
            Email VARCHAR(255) PRIMARY KEY,
            Nome VARCHAR(255),
            Sobrenome VARCHAR(255),
            Senha VARCHAR(255),
            Tipo_Usuario VARCHAR(255),
            Endereco_RuaAv VARCHAR(255),
            Endereco_Compl VARCHAR(255),
            Endereco_Cidade VARCHAR(255),
            Endereco_CEP VARCHAR(10),
            Endereco_Estado VARCHAR(255)
        )
    """)

    # Criação da tabela fotografos
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS fotografos (
            CPF VARCHAR(14) PRIMARY KEY,
            Email_fotografo VARCHAR(255) UNIQUE,
            Foto_Perfil VARCHAR(255),
            Contato VARCHAR(20),
            Area_Atuacao VARCHAR(255),
            FOREIGN KEY (Email_fotografo) REFERENCES usuarios(Email)
        )
    """)

    return "Banco de dados e tabelas criados com sucesso!"


@app.route('/configurar_banco')
def configurar_banco():
    try:
        db = conectar_banco()
        cursor = db.cursor()
        mensagem = configurar_e_criar_tabelas(cursor)
        db.commit()
        db.close()
        return mensagem
    except Exception as e:
        return f"Erro ao configurar e criar o banco de dados: {str(e)}"

#Bloco de configuação de banco de dados do projeto - Fim


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/quemsomos')
def quemsomos():
    return render_template('quemsomos.html')

@app.route('/login')
def login():
    return render_template('login.html')

#Rota de cadastro geral para todos usuários
@app.route('/cadastro')
def cadastro():
    return render_template('cadastro.html')



if __name__ == '__main__':
    app.run(debug=True)
