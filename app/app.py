# Conteúdo do arquivo app.py
from flask import Flask, render_template, request
from database.database import db
from database.models import Usuario, Fotografo
from config import SECRET_KEY

app = Flask(__name__)
app.secret_key = SECRET_KEY

# Configuração do banco de dados
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///projeto_fotografia.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Inicialização do objeto db
db.init_app(app)


# Rotas e lógica da aplicação
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/quemsomos')
def quemsomos():
    return render_template('quemsomos.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/cadastro', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        # Lógica de cadastro de usuário
        nome = request.form['inputName']
        sobrenome = request.form['inputSobrenome']
        email = request.form['inputEmail']
        nick = request.form['inputNick']
        senha = request.form['inputPassword']
        tipo_usuario = request.form['userType']
        estado = request.form['inputState']
        cidade = request.form['inputCity']
        bairro = request.form.get('inputBairro', '')

        # Se o tipo de usuário for fotógrafo, obter dados específicos do fotógrafo
        dados_fotografo = None
        if tipo_usuario == 'fotografo':
            dados_fotografo = {
                'cpf': request.form['inputCPF'],
                'foto_perfil': request.files.get('inputProfilePic', None),
                'contato': request.form['inputContact'],
                'area_atuacao': request.form['inputArea']
            }

        # Chamar a função cadastrar_usuario com os dados do formulário
        mensagem = cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado, dados_fotografo)

        return mensagem

    return render_template('cadastro.html')

if __name__ == '__main__':
    try:
        with app.app_context():
            db.init_app(app)
            db.create_all()
    except Exception as e:
        print(f"Erro ao configurar e criar o banco de dados: {str(e)}")

    app.run(debug=True)
