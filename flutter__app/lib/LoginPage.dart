import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text ('Login',
      style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
      ),
      actions: [
        Image.asset(
        'assets/images/logoVJ.png',
            height: 50,
        ),
      ],

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                TextFormField(
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
                SizedBox(height: 20),
                TextFormField(
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
                SizedBox(height: 20),
                SizedBox(
                  width: 400, 
                  height: 50, 
                  child:ElevatedButton(
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
                  width: 400, 
                  height: 50, 
                  child:ElevatedButton(
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
    );
  }
}
