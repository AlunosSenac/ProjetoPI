from flask import Flask, render_template

app = Flask(__name__)

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
