import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            'assets/images/logoVJ.png',
            height: 30,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/registro.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(144, 78, 74, 74),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Cadastro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 42.0,
                      width: 350.0,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 42.0,
                      width: 350.0,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 42.0,
                      width: 350.0,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 42.0,
                      width: 350.0,
                      child: TextFormField(
                        controller: _userController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 42.0,
                      width: 350.0,
                      child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 42.0,
                      width: 350.0,
                      child: TextFormField(
                        controller: _photoController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Foto de Perfil',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Adicionar foto',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: 350,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              await FirebaseFirestore.instance.collection('users').add({
                                'name': _nameController.text,
                                'email': _emailController.text,
                                'phone': _phoneController.text,
                                'user': _userController.text,
                                'photoPath': _photoController.text,
                                'uid': userCredential.user?.uid,
                              });

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuário cadastrado com sucesso')));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            } on FirebaseAuthException catch (e) {
                              String message = '';
                              if (e.code == 'email-already-in-use') {
                                message = 'Este email já está sendo usado.';
                              } else if (e.code == 'weak-password') {
                                message = 'A senha é muito fraca.';
                              } else {
                                message = e.message ?? 'Erro desconhecido.';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFFCFDF9),
                          backgroundColor: Color(0xFF435364),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                        child: Text('Cadastrar'),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Já possui cadastro? Faça seu Login',
                        style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}