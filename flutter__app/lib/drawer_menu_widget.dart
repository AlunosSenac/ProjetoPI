import 'package:flutter/material.dart';

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
              // Implemente a lógica para abrir a tela de login
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
              // Implemente a lógica para abrir a tela "Sobre"
            },
          ),
        ],
      ),
    );
  }
}
