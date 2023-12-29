from flask import Flask, render_template, request, redirect
from database import conectar_banco, configurar_e_criar_tabelas, cadastrar_usuario

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
@app.route('/cadastro', methods = ['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        email = request.form['inputEmail4']
        nick = request.form['inputNick']
        nome = request.form['inputName']
        sobrenome = request.form['inputSurname']
        senha = request.form['inputPassword4']
        tipo_usuario = request.form['userType']
        cidade = request.form['inputCity']
        bairro = request.form.get('inputBairro', '')  # Pode ser nulo, então usar get
        estado = request.form['inputState']

        # Se o tipo de usuário for fotógrafo, obter dados específicos do fotógrafo
        dados_fotografo = None
        if tipo_usuario == 'fotografo':
        # Obter dados específicos do fotógrafo do formulário
            dados_fotografo = (
                request.form['inputCPF'],
                request.form['inputProfilePic'],
                request.form['inputContact'],
                request.form['inputArea']
            )

        # Chamar a função cadastrar_usuario com os dados do formulário
        mensagem = cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado, dados_fotografo)

        return render_template('resultado_cadastro.html', mensagem=mensagem)


    return render_template('cadastro.html')



if __name__ == '__main__':
    app.run(debug=True)
