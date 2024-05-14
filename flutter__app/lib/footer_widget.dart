import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                icon: Icon(FontAwesome.instagram),
                onPressed: () {
                  // Abra a página do Instagram
                },
              ),
              IconButton(
                icon: Icon(FontAwesome.twitter),
                onPressed: () {
                  // Abra a página do Twitter
                },
              ),
              IconButton(
                icon: Icon(FontAwesome.facebook),
                onPressed: () {
                  // Abra a página do Facebook
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
