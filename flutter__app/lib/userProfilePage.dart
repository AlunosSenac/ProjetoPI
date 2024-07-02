import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir o WhatsApp
import 'full_screen_image_page.dart'; // Importando o novo arquivo

class UserProfilePage extends StatelessWidget {
  final String userId;
  final String userName;
  final String userPhotoUrl;
  final String whatsappNumber;
  final String city;
  final String uf;
  final String nick;

  UserProfilePage({
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.whatsappNumber,
    required this.city,
    required this.uf,
    required this.nick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            'assets/images/logoVJ.png',
            height: 30,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
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
                ),
              ),
              SizedBox(height: 5),
              Text(
                nick,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 5),
              Text(
                '$city, $uf',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFFCFDF9),
                          backgroundColor: Color(0xFF435364),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                onPressed: () {
                  _launchWhatsApp(whatsappNumber);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 5),
                    Text('Enviar mensagem',
                    style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildGallery(context),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildGallery(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('gallery')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erro ao carregar galeria');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final List<DocumentSnapshot> galleryItems = snapshot.data!.docs;

        if (galleryItems.isEmpty) {
          return Text('Nenhuma imagem na galeria');
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Número de colunas
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemCount: galleryItems.length,
          itemBuilder: (context, index) {
            String imageUrl = galleryItems[index]['photoURL'];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
                  ),
                );
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  } 

  void _launchWhatsApp(String number) async {
    String url = 'https://wa.me/$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
