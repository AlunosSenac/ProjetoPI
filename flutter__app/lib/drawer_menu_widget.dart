import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter__app/main.dart';
import 'LoginPage.dart';
import 'CadastroPage.dart';
import 'Galeria.dart';
import 'About.dart';
import 'userProfilePage.dart';
import 'explorer.dart';

class DrawerMenuWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
          if (_auth.currentUser == null) // Mostra apenas se não estiver logado
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          if (_auth.currentUser == null) // Mostra apenas se não estiver logado
            ListTile(
              title: Text('Cadastro'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage()),
                );
              },
            ),
          ListTile(
            title: Text('Galeria'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Galeria()),
              );
            },
          ),
          ListTile(
            title: Text('Explorer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Explorer()),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()),
              );
            },
          ),
          if (_auth.currentUser != null) // Mostra apenas se estiver logado
            ListTile(
              title: Text('Usuário'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
          if (_auth.currentUser != null) // Mostra apenas se estiver logado
            ListTile(
              title: Text('Sair'),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
        ],
      ),
    );
  }
}
