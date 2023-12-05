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


@app.route('/cadastros')
def cadastros():
    return render_template('cadastros.html')


@app.route('/cadastrofotog')
def cadastrofotog():
    return render_template('cadastrofotog.html')

@app.route('/cadastrouser')
def cadastrouser():
    return render_template('cadastrouser.html')

if __name__ == '__main__':
    app.run(debug=True)
