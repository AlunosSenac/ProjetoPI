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
        title: Text(userName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userPhotoUrl),
            ),
            SizedBox(height: 10),
            Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'WhatsApp: $whatsappNumber',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
