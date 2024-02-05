from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user
import mysql.connector
import base64

app = Flask(__name__)
app.secret_key = 'chave_secreta'

# Configurar o Flask-Login
login_manager = LoginManager(app)

# Configurações do banco de dados
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'visualdb'
}

# Função para criar a conexão com o banco de dados MySQL
def get_db_connection():
    conn = mysql.connector.connect(**db_config)
    return conn

# Classe User para representar usuários no Flask-Login
class User(UserMixin):
    def __init__(self, user_id, user_type):
        self.id = user_id
        self.user_type = user_type

# Configurar a função user_loader
@login_manager.user_loader
def load_user(user_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM usuarios WHERE id=%s", (user_id,))
    user_data = cursor.fetchone()

    conn.close()

    if user_data:
        user = User(user_data['id'], user_data['tipo_usuario'])
        return user
    else:
        return None

# Função para verificar as credenciais do usuário
def check_credentials(username_or_email, password):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM usuarios WHERE nome_usuario=%s OR email=%s", (username_or_email, username_or_email))
    user = cursor.fetchone()

    conn.close()

    if user and check_password_hash(user['senha_hash'], password):
        return user
    else:
        return None

# Função para obter dados do fotógrafo do banco de dados
def obter_dados_do_fotografo(fotografo_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Consulta para obter dados do fotógrafo com base no ID
        cursor.execute("""
            SELECT * FROM fotografos
            WHERE usuario_id = %s
        """, (fotografo_id,))

        fotografo_data = cursor.fetchone()

        if fotografo_data:
            # Convertendo imagens binárias para base64 para exibição em HTML
            fotografo_data['imagem_perfil'] = base64.b64encode(fotografo_data['imagem_perfil']).decode('utf-8')
            fotografo_data['fotos'] = [base64.b64encode(foto).decode('utf-8') for foto in fotografo_data['fotos']]

            return fotografo_data
        else:
            return None
    except Exception as e:
        print(f"Erro ao obter dados do fotógrafo: {e}")
        return None
    finally:
        conn.close()

# Rota para exibir a página de cadastro
# Rota para exibir a página de cadastro
@app.route('/cadastro', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        hashed_password = generate_password_hash(request.form['inputPassword'], method='pbkdf2:sha256')

        user_data = {
            'nome': request.form['nome'],
            'sobrenome': request.form['sobrenome'],
            'telefone': request.form.get('inputTelefone'),
            'cpf': request.form.get('inputCpf'),
            'email': request.form.get('inputEmail'),
            'nome_usuario': request.form['inputNick'],
            'senha_hash': hashed_password,
            'tipo_usuario': request.form['inputUserType']
        }

        try:
            conn = get_db_connection()
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO usuarios
                (nome, sobrenome, telefone, cpf, email, nome_usuario, senha_hash, tipo_usuario)
                VALUES (%(nome)s, %(sobrenome)s, %(telefone)s, %(cpf)s, %(email)s, %(nome_usuario)s, %(senha_hash)s, %(tipo_usuario)s)
            """, user_data)

            conn.commit()

            user = check_credentials(user_data['nome_usuario'], request.form['inputPassword'])

            if user:
                user_object = User(user['id'], user['tipo_usuario'])
                login_user(user_object)

                session['logged_in'] = True
                session['user_id'] = user['id']
                session['username'] = user_data['nome_usuario']
                session['user_type'] = user['tipo_usuario']

                if user['tipo_usuario'] == 'Fotografo':
                    return redirect(url_for('usuario_fotografo'))
                elif user['tipo_usuario'] == 'Cliente':
                    return redirect(url_for('usuario_cliente'))
                else:
                    return redirect(url_for('index'))

        except Exception as e:
            return render_template('cadastro.html', error='Erro durante o cadastro')
        finally:
            conn.close()
    else:
        return render_template('cadastro.html')

        # ... (código anterior)

# Rota para exibir a página de login
# Rota para exibir a página de login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username_or_email = request.form['inputNickOrEmail']
        password = request.form['inputPassword']

        try:
            user = check_credentials(username_or_email, password)

            if user:
                user_object = User(user['id'], user['tipo_usuario'])
                login_user(user_object)

                session['logged_in'] = True
                session['user_id'] = user['id']
                session['username'] = username_or_email
                session['user_type'] = user['tipo_usuario']

                app.logger.info(f"Usuário {username_or_email} autenticado com sucesso.")

                if user['tipo_usuario'] == 'Fotografo':
                    return redirect(url_for('usuario_fotografo'))
                elif user['tipo_usuario'] == 'Cliente':
                    return redirect(url_for('usuario_cliente'))
                else:
                    return redirect(url_for('index'))
            else:
                app.logger.warning(f"Tentativa de login com credenciais inválidas para {username_or_email}.")
                return render_template('login.html', error='Credenciais inválidas')
        except Exception as e:
            app.logger.error(f"Erro durante o login: {e}")
            return render_template('login.html', error='Erro durante o login')
    else:
        return render_template('login.html')

        # ... (código anterior)

# Rota para exibir a página de índice
@app.route('/')
def index():
    return render_template('index.html')

# Rota para exibir a página "quemsomos"
@app.route('/quemsomos')
def quemsomos():
    return render_template('quemsomos.html')

# Rota para efetuar o logout
@app.route('/logout')
@login_required
def logout():
    logout_user()
    session.clear()
    return redirect(url_for('index'))

# Rota para usuário fotógrafo
@app.route('/usuario_fotografo')
@login_required
def usuario_fotografo():
    fotografo = obter_dados_do_fotografo(session['user_id'])
    return render_template('usuarioFotografo.html', fotografo=fotografo)

# Rota para cadastrar fotógrafo
@app.route('/cadastrar_fotografo', methods=['GET', 'POST'])
@login_required
def cadastrar_fotografo():
    if request.method == 'POST':
        categoria = request.form['categoria']
        url = request.form['url']
        bio = request.form['bio']
        imagem_perfil = request.files['imagem_perfil'].read() if 'imagem_perfil' in request.files else None
        fotos = [request.files['fotos'][i].read() for i in range(len(request.files.getlist('fotos')))]

        try:
            conn = get_db_connection()
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO fotografos
                (usuario_id, categoria, url, bio, imagem_perfil, fotos)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (session['user_id'], categoria, url, bio, imagem_perfil, fotos))

            conn.commit()

            return redirect(url_for('visualizar_fotografo', fotografo_id=session['user_id']))
        except Exception as e:
            return render_template('cadastrar_fotografo.html', error='Erro durante o cadastro')
        finally:
            conn.close()

    return render_template('cadastrar_fotografo.html')

# Rota para visualizar fotógrafo
@app.route('/visualizar_fotografo/<int:fotografo_id>')
@login_required
def visualizar_fotografo(fotografo_id):
    fotografo = obter_dados_do_fotografo(fotografo_id)
    return render_template('visualizar_fotografo.html', fotografo=fotografo)

if __name__ == '__main__':
    app.run(debug=True)
