import 'package:flutter/material.dart';

class PhotoCarouselWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x55555534),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Fotos de Fotógrafos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 220),
          // Adicionar seu carrossel de fotos aqui
        ],
      ),
    );
  }
}
