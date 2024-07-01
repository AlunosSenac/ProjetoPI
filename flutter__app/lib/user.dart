import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String userName;
  final String userPhotoUrl;
  final String whatsappNumber;
  /* final List<String> galleryImages; */

  UserProfilePage({
    required this.userName,
    required this.userPhotoUrl,
    required this.whatsappNumber,
/*     required this.galleryImages, */
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userPhotoUrl),
            ),
            SizedBox(height: 10),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'WhatsApp: $whatsappNumber',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'edit') {
                      // Lógica para editar
                    } else if (result == 'exit') {
                      // Lógica para sair
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'exit',
                      child: Text('Sair'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
           /*  GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de colunas
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1,
              ),
           /*    itemCount: galleryImages.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  galleryImages[index],
                  fit: BoxFit.cover,
                );
              }, */
            ), */
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
