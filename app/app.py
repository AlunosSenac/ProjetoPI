from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, TextAreaField
from wtforms.validators import DataRequired, Email
from passlib.hash import sha256_crypt
import mysql.connector

app = Flask(__name__)
app.secret_key = 'malucoFotografoSenac2024'

# Conexão com o banco de dados
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",  # Substitua pela senha do seu banco de dados MySQL
    database="fotografos"
)
cursor = db.cursor()

# Define o formulário de registro
class RegistrationForm(FlaskForm):
    nome = StringField('Nome', validators=[DataRequired()])
    sobrenome = StringField('Sobrenome', validators=[DataRequired()])
    nome_usuario = StringField('Nome de Usuário', validators=[DataRequired()])
    senha = PasswordField('Senha', validators=[DataRequired()])
    telefone = StringField('Telefone', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Email()])
    submit = SubmitField('Registrar')

# Define o formulário de login
class LoginForm(FlaskForm):
    nome_usuario = StringField('Nome de Usuário', validators=[DataRequired()])
    senha = PasswordField('Senha', validators=[DataRequired()])
    submit = SubmitField('Entrar')

# Define o formulário de perfil
class ProfileForm(FlaskForm):
    nome = StringField('Nome', validators=[DataRequired()])
    sobrenome = StringField('Sobrenome', validators=[DataRequired()])
    nome_usuario = StringField('Nome de Usuário', validators=[DataRequired()])
    senha = PasswordField('Senha', validators=[DataRequired()])
    telefone = StringField('Telefone', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Email()])
    bio = TextAreaField('Biografia')
    url = StringField('URL')
    rua = StringField('Rua')
    cidade = StringField('Cidade')
    estado = StringField('Estado')
    pais = StringField('País')
    codigo_postal = StringField('Código Postal')
    submit = SubmitField('Salvar')

# Página inicial
@app.route('/')
def index():
    return render_template('index.html')

# Página 'Quem Somos'
@app.route('/quemsomos')
def quemsomos():
    return render_template('quemsomos.html')

# Página de registro
@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        nome = form.nome.data
        sobrenome = form.sobrenome.data
        nome_usuario = form.nome_usuario.data
        senha = sha256_crypt.hash(form.senha.data)
        telefone = form.telefone.data
        email = form.email.data
        
        cursor.execute("INSERT INTO perfilFotografos (nome, sobrenome, nome_usuario, senha, telefone, email) VALUES (%s, %s, %s, %s, %s, %s)",
                       (nome, sobrenome, nome_usuario, senha, telefone, email))
        db.commit()
        flash('Cadastro realizado com sucesso! Faça login para acessar sua conta.', 'success')
        return redirect(url_for('login'))
    return render_template('register.html', form=form)

# Página de login
@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        nome_usuario = form.nome_usuario.data
        senha_candidate = form.senha.data
        
        cursor.execute("SELECT * FROM perfilFotografos WHERE nome_usuario = %s", (nome_usuario,))
        account = cursor.fetchone()
        
        if account:
            senha = account[4]
            if sha256_crypt.verify(senha_candidate, senha):
                session['loggedin'] = True
                session['id'] = account[0]
                session['nome_usuario'] = account[3]
                flash('Login realizado com sucesso!', 'success')
                return redirect(url_for('profile'))
            else:
                flash('Senha incorreta. Tente novamente.', 'danger')
        else:
            flash('Usuário não encontrado.', 'danger')
    return render_template('login.html', form=form)

# Logout
@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('nome_usuario', None)
    flash('Logout realizado com sucesso!', 'success')
    return redirect(url_for('index'))

# Página de perfil
@app.route('/profile')
def profile():
    if 'loggedin' in session:
        user_id = session['id']
        cursor.execute("SELECT * FROM perfilFotografos WHERE id = %s", (user_id,))
        profile_data = cursor.fetchone()
        return render_template('profile.html', profile_data=profile_data)
    else:
        flash('Você precisa fazer login para acessar esta página.', 'danger')
        return redirect(url_for('login'))

# Página de edição de perfil
@app.route('/edit_profile', methods=['GET', 'POST'])
def edit_profile():
    form = ProfileForm()
    if 'loggedin' in session:
        user_id = session['id']
        if form.validate_on_submit():
            nome = form.nome.data
            sobrenome = form.sobrenome.data
            nome_usuario = form.nome_usuario.data
            senha = sha256_crypt.hash(form.senha.data)
            telefone = form.telefone.data
            email = form.email.data
            bio = form.bio.data
            url = form.url.data
            rua = form.rua.data
            cidade = form.cidade.data
            estado = form.estado.data
            pais = form.pais.data
            codigo_postal = form.codigo_postal.data
            
            cursor.execute("UPDATE perfilFotografos SET nome = %s, sobrenome = %s, nome_usuario = %s, senha = %s, telefone = %s, email = %s, bio = %s, url = %s, rua = %s, cidade = %s, estado = %s, pais = %s, codigo_postal = %s WHERE id = %s",
                           (nome, sobrenome, nome_usuario, senha, telefone, email, bio, url, rua, cidade, estado, pais, codigo_postal, user_id))
            db.commit()
            flash('Perfil atualizado com sucesso!', 'success')
            return redirect(url_for('profile'))
        return render_template('edit_profile.html', form=form)
    else:
        flash('Você precisa fazer login para acessar esta página.', 'danger')
        return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
