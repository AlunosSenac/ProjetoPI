import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String userName;
  final String userPhotoUrl;
  final String whatsappNumber;

  UserProfilePage({
    required this.userName,
    required this.userPhotoUrl,
    required this.whatsappNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Fotógrafo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userPhotoUrl),
            ),
            SizedBox(height: 20),
            Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'WhatsApp: $whatsappNumber',
              style: TextStyle(fontSize: 18),
            ),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
    );
  }
}
