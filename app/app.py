from flask import Flask, render_template, request, redirect, url_for
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

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        nick_or_email = request.form['inputNickOrEmail']
        senha = request.form['inputPassword']

        # Verifica se é e-mail
        if '@' in nick_or_email:
            usuario = Usuario.query.filter_by(email=nick_or_email, senha=senha).first()
        else:
            # Se não for e-mail, assume que é nick
            usuario = Usuario.query.filter_by(nick=nick_or_email, senha=senha).first()

        if usuario:
            if usuario.tipo_usuario == 'fotografo':
                return redirect(url_for('admin_fotografo'))
            else:
                return render_template('usuarioNormal.html', usuario=usuario)
        else:
            return render_template('login.html', error='Credenciais inválidas')

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
                'contato': request.form['inputContact'],
                'area_atuacao': request.form['inputArea']
            }

            # Chamar a função cadastrar_usuario com os dados do formulário
            cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado, dados_fotografo)

            # Adicionar redirecionamento para a página de administração do fotógrafo
            return redirect(url_for('admin_fotografo'))

        # Se o tipo de usuário for cliente, cadastrar como cliente
        cadastrar_usuario(email, nick, nome, sobrenome, senha, tipo_usuario, cidade, bairro, estado)

        # Redirecionar para a página adequada após o cadastro
        if tipo_usuario == 'fotografo':
            return redirect(url_for('admin_fotografo'))
        else:
            return render_template('usuarioNormal.html')

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
            contato=dados_fotografo['contato'],
            area_atuacao=dados_fotografo['area_atuacao'],
            nick_usuario=nick
        )

        # Adicionar fotógrafo ao banco de dados
        db.session.add(novo_fotografo)
        db.session.commit()

@app.route('/admin/fotografo')
def admin_fotografo():
    # Lógica para obter informações específicas do fotógrafo (bio, fotos, links, contatos)
    # Isso pode envolver consultas ao banco de dados para obter dados do fotógrafo logado
    # Substitua essa lógica com base nas suas necessidades

    # Por enquanto, vou apenas passar dados de exemplo para ilustrar
    dados_fotografo = {
        'bio': 'Essa é a bio do fotógrafo',
        'fotos': ['foto1.jpg', 'foto2.jpg'],
        'links': ['https://www.instagram.com/fotografo', 'https://www.portfolio.com'],
        'contatos': {'email': 'fotografo@email.com', 'telefone': '123-456-7890'}
    }

    return render_template('usuarioFotografo.html', fotografo=dados_fotografo)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()

    app.run(debug=True)
