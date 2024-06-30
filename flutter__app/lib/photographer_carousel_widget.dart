import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter__app/userProfilePage.dart';

class PhotographerCarouselWidget extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('users').limit(4).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Erro ao carregar fotógrafos');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              List<DocumentSnapshot> photographers = snapshot.data!.docs;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: photographers.map((photographer) {
                  Map<String, dynamic> data = photographer.data() as Map<String, dynamic>;
                  String photoUrl = data['photoURL'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(
                            userName: data['name'] ?? '',
                            userPhotoUrl: photoUrl,
                            whatsappNumber: data['phone'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
