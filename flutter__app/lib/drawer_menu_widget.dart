import 'package:flutter/material.dart';
import 'package:flutter__app/LoginPage.dart';
import 'package:flutter__app/CadastroPage.dart'; 
import 'package:flutter__app/Galeria.dart';
import 'package:flutter__app/About.dart';
import 'package:flutter__app/userProfilePage.dart';
import 'package:flutter__app/explorer.dart';

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
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
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
          ListTile(
            title: Text('Usuario'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
