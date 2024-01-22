from flask import Flask, render_template, request
from database.database import db
from database.models import Usuario, Fotografo

app = Flask(__name__)
app.secret_key = 'sua_chave_secreta'

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

def cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado, dados_fotografo=None):
    # Lógica para cadastrar usuário no banco de dados
    novo_usuario = Usuario(
        email=email,
        nick=nick,
        nome=nome,
        sobrenome=sobrenome,
        senha=senha,
        tipo_usuario=tipo_usuario,
        cidade=cidade,
        bairro=bairro,
        estado=estado
    )

    # Adicionar usuário ao banco de dados
    db.session.add(novo_usuario)
    db.session.commit()

    # Se o usuário for um fotógrafo, cadastrar dados específicos do fotógrafo
    if tipo_usuario == 'fotografo' and dados_fotografo:
        novo_fotografo = Fotografo(
            cpf=dados_fotografo['cpf'],
            foto_perfil=dados_fotografo.get('foto_perfil', None),
            contato=dados_fotografo['contato'],
            area_atuacao=dados_fotografo['area_atuacao'],
            nick_usuario=nick
        )

        # Adicionar fotógrafo ao banco de dados
        db.session.add(novo_fotografo)
        db.session.commit()

    return "Usuário cadastrado com sucesso!"

if __name__ == '__main__':
    with app.app_context():
        db.create_all()

    app.run(debug=True)
