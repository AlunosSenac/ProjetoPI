import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visual Journey'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visual Journey',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800]), // Ajustando a cor do título
            ),
            SizedBox(height: 20),
            Text(
              'Sobre o Visual Journey:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]), // Ajustando a cor do subtítulo
            ),
            SizedBox(height: 10),
            Text(
              'O Visual Journey é uma aplicação web com o objetivo de impulsionar o setor de serviços voltados para o ramo da fotografia. Nossa plataforma facilita a venda de imagens e a contratação de profissionais, visando sempre o aprimoramento da qualidade dos serviços.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]), // Ajustando a cor do texto
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/foto1.jpg'), // Adicionando uma imagem abaixo do texto
            SizedBox(height: 20),
            Text(
              'Para Fotógrafos Profissionais:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]), // Ajustando a cor do subtítulo
            ),
            SizedBox(height: 10),
            Text(
              'Para profissionais, o Visual Journey oferece uma plataforma com design mutável para a melhor apresentação de projetos e trabalhos. Além disso, proporcionamos um local seguro para o armazenamento de imagens, eliminando preocupações com plágio e roubo de propriedade intelectual.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]), // Ajustando a cor do texto
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/foto3.jpg'), // Adicionando outra imagem abaixo do texto
            SizedBox(height: 20),
            Text(
              'Para Fotógrafos Iniciantes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]), // Ajustando a cor do subtítulo
            ),
            SizedBox(height: 10),
            Text(
              'O Visual Journey pode ser uma ótima ferramenta para fotógrafos iniciantes desenvolverem suas habilidades e apresentarem seus trabalhos. Nossa plataforma oferece suporte para que novos talentos possam se destacar e crescer profissionalmente.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
               // Ajustando a cor do texto
            ),
               SizedBox(height: 20),
               Image.asset('assets/images/foto2.jpg'), // Adicionando outra imagem abaixo do texto
               SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: About(),
  ));
}
