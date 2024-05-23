import 'package:flutter/material.dart';
import 'package:flutter__app/footer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/camera.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 42,
                        width: 350,
                        child:TextFormField(
                          style: TextStyle(color: Colors.white,), 
                          decoration: InputDecoration(
                            labelText: 'Usuario',
                            labelStyle: TextStyle(color: Colors.white), 
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white), 
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.white), // Ícone de usuário
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 42,
                        width: 350,
                        child:TextFormField(
                            style: TextStyle(color: Colors.white), 
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(color: Colors.white), 
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white), 
                              ),
                              prefixIcon: Icon(Icons.lock, color: Colors.white), // Ícone de senha
                            ),
                            obscureText: true,
                          ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 350, 
                        height: 42, 
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFFCFDF9), 
                            backgroundColor: Color(0xFF435364), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 350, 
                        height: 42, 
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFFCFDF9), 
                            backgroundColor: Color(0xFF435364),  
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FooterWidget(), // Adicionando o FooterWidget aqui
        ],
      ),
    );
  }
}
