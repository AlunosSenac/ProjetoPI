from database.database import db

class Usuario(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(255), unique=True, nullable=False)
    nick = db.Column(db.String(255), nullable=False)
    nome = db.Column(db.String(100), nullable=False)
    sobrenome = db.Column(db.String(100), nullable=False)
    senha = db.Column(db.String(255), nullable=False)
    tipo_usuario = db.Column(db.String(50), nullable=False)
    cidade = db.Column(db.String(100), nullable=False)
    bairro = db.Column(db.String(100))
    estado = db.Column(db.String(50), nullable=False)

    # Novos campos
    telefone = db.Column(db.String(15))

    def get_id(self):
        return str(self.id)

class Fotografo(db.Model):
    cpf = db.Column(db.String(11), primary_key=True, nullable=False)
    foto_perfil = db.Column(db.String(255))
    contato = db.Column(db.String(15), nullable=False)
    area_atuacao = db.Column(db.String(100), nullable=False)
    nick_usuario = db.Column(db.String(255), db.ForeignKey('usuario.nick'), nullable=False)
    usuario = db.relationship('Usuario', backref='fotografo')

    # Novos campos
    bio = db.Column(db.Text)
    links_rede_social = db.Column(db.String(255))
    foto_fotografo = db.Column(db.String(255))
