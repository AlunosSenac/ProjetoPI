import 'package:flutter/material.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual Journey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visual Journey'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logoVJ.png',
                    height: 50,
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      // Adiciona a lógica de menu aqui
                    },
                  ),
                ],
              ),
            ),
            // Carrossel de imagens
            Container(
              height: 200,
              child: PageView(
                children: [
                  Image.asset(
                    'assets/images/banerAnimado1.gif',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/banerAnimado2.gif',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/banerAnimado3.gif',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            // Carrossel de fotógrafos
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Encontre um Fotógrafo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Adiciona 0 carrossel de fotógrafos aqui
                ],
              ),
            ),
            // Carrossel de fotos
            Container(
              color: Color(0x55555534),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Fotos de Fotógrafos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Adiciona o carrossel de fotos aqui
                ],
              ),
            ),
            // Footer
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[300],
              child: Column(
                children: [
                  Text(
                    '© 2024 Seu Site. Todos os direitos reservados.',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook),
                        onPressed: () {
                          // Abre a página do Facebook
                        },
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
