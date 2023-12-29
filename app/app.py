from flask import Flask, render_template, request, redirect
from database import conectar_banco, configurar_e_criar_tabelas, cadastrar_usuario

app = Flask(__name__)


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
        nome = request.form['inputName']
        sobrenome = request.form['inputSobrenome']
        email = request.form['inputEmail']
        nick = request.form['inputNick']
        senha = request.form['inputPassword']
        tipo_usuario = request.form['userType'] 
        estado = request.form['inputState']
        cidade = request.form['inputCity']
        bairro = request.form.get('inputBairro', '')  # Pode ser nulo, então usar get
       

        # Se o tipo de usuário for fotógrafo, obter dados específicos do fotógrafo
        dados_fotografo = None
        if tipo_usuario == 'fotografo':
        # Obter dados específicos do fotógrafo do formulário
            dados_fotografo = {
                'cpf': request.form['inputCPF'],
                'foto_perfil': request.files.get['inputProfilePic', None],
                'contato': request.form['inputContact'],
                'area_atuacao': request.form['inputArea']  
            }
              
        # Chamar a função cadastrar_usuario com os dados do formulário
        mensagem = cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado, dados_fotografo)

        return "Cadastro concluído com sucesso!"


    return render_template('cadastro.html')



if __name__ == '__main__':
    try:
            db = conectar_banco()
            cursor = db.cursor()
            mensagem = configurar_e_criar_tabelas(cursor)
            db.commit()
            db.close()
    except Exception as e:
            print (f"Erro ao configurar e criar o banco de dados: {str(e)}")

    app.run(debug=True)
