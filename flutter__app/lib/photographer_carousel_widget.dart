import 'package:flutter/material.dart';

class PhotographerCarouselWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 40,
                // Substitua os caminhos pelas imagens reais
                backgroundImage: AssetImage('assets/images/foto1.jpg'),
              ),
              CircleAvatar(
                radius: 40,
                // Substitua os caminhos pelas imagens reais
                backgroundImage: AssetImage('assets/images/foto1.jpg'),
              ),
              CircleAvatar(
                radius: 40,
                // Substitua os caminhos pelas imagens reais
                backgroundImage: AssetImage('assets/images/foto1.jpg'),
              ),
              CircleAvatar(
                radius: 40,
                // Substitua os caminhos pelas imagens reais
                backgroundImage: AssetImage('assets/images/foto1.jpg'),
              ),
              // Adicionar mais CircleAvatars conforme necessário
            ],
          ),
        ],
      ),
    );
  }
}
