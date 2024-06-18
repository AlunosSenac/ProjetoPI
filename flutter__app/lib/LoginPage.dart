import 'package:flutter/material.dart';
import 'package:flutter__app/CadastroPage.dart';
import 'package:flutter__app/footer_widget.dart';
//import 'package:firebase_auth/firebase_auth.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundoLogin.jpg'),
                  fit: BoxFit.cover,
                ),
        ),
        child: Center(
          child: SingleChildScrollView( 
            child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(50.0), 
            decoration: BoxDecoration(
              color: Color.fromARGB(123, 78, 74, 74),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
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
            SizedBox(
              height: 42,
              width: 350,
              child:TextFormField(
              style: TextStyle(color: Colors.white,), 
                          decoration: InputDecoration(
                            labelText: 'Usuario',
                            labelStyle: TextStyle(color: Colors.white), 
                            prefixIcon: Icon(Icons.person, color: Colors.white), 
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                            ),
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
                              prefixIcon: Icon(Icons.lock, color: Colors.white), 
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,),
                              ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CadastroPage()
                              ),
                            );
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
    );
  }
}