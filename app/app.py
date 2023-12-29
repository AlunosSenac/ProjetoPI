from flask import Flask, render_template, request, redirect
from database import conectar_banco, configurar_e_criar_tabelas

app = Flask(__name__)

#Bloco de configuação de banco de dados  - Fim
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

#Rotas das paginas da aplicação
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
