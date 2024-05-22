import 'package:flutter/material.dart';
import 'package:flutter__app/LoginPage.dart';
import 'package:flutter__app/About.dart'; // Importe sua tela "About"

class DrawerMenuWidget extends StatelessWidget {
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
          ListTile(
            title: Text('Login'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()
                ),
               );
            },
          ),
          ListTile(
            title: Text('Cadastro'),
            onTap: () {
              // Implemente a lógica para abrir a tela de cadastro
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              // Navegar para a tela "About"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
