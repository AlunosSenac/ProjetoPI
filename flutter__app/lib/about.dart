import 'package:flutter/material.dart';
import 'package:flutter__app/footer_widget.dart';

// Importações dos widgets que serão utilizados no código

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Visual Galeria',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Este é um aplicativo de galeria de fotos.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Galeria de Fotos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Gallery(),
            FooterWidget(), // Adicionando o FooterWidget aqui
          ],
        ),
      ),
    );
  }
}

class Gallery extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/photo1_teste.jpg',
    'assets/images/photo2_teste.jpg',
    'assets/images/photo3_teste.jpg',
    // Adicione mais caminhos de imagem conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Duas imagens por linha
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Implemente aqui a ação que você deseja quando a imagem for tocada
          },
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: About(),
  ));
}
