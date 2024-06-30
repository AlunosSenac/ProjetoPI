import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  String _userName = '';
  String _userPhotoUrl = '';
  String _whatsappNumber = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      final uid = _currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(uid).get();

        setState(() {
          _userName = userSnapshot.data()?['name'] ?? '';
          _userPhotoUrl = userSnapshot.data()?['photoUrl'] ?? '';
          _whatsappNumber = userSnapshot.data()?['phone'] ?? '';
        });
    }
  }

  void _launchWhatsApp(String phone) async {
    String whatsappUrl = "whatsapp://send?phone=$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao abrir o WhatsApp')));
  }

  Future<void> _addPhotoToGallery() async {
    // Implementar a lógica para adicionar fotos à galeria
    // Aqui você pode usar a mesma lógica de upload de imagem que foi implementada anteriormente
    // e armazenar a URL da imagem no Firestore.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(_userPhotoUrl),
            ),
            SizedBox(height: 20),
            Text(
              _userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchWhatsApp(_whatsappNumber);
              },
              child: Text('Enviar Mensagem via WhatsApp'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<DocumentSnapshot>(
                future: _firestore.collection('user_photos').doc(_currentUser!.uid).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar as fotos.'));
                  }
                  List<String> photoUrls = [];
                  if (snapshot.hasData && snapshot.data!.exists) {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    photoUrls = List<String>.from(data['photoUrls'] ?? []);
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photoUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(photoUrls[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addPhotoToGallery();
              },
              child: Text('Adicionar Foto à Galeria'),
            ),
          ],
        ),
      ),
    );
  }
}
