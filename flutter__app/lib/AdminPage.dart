import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _profilePhotoController = TextEditingController();
  final TextEditingController _galleryPhotoController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> upload(String path, String folderName) async {
    File file = File(path);
    try {
      String ref = 'images/$folderName/img-${DateTime.now().toString()}.png';
      final uploadTask = await storage.ref(ref).putFile(file);
      final downloadURL = await uploadTask.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Erro no upload: $e');
    }
  }

  pickAndUploadGalleryPhoto() async {
    XFile? file = await getImage();
    if (file != null) {
      String photoURL = await upload(file.path, 'gallery_photos');
      await savePhotoURLToGallery(photoURL);
      setState(() {
        _galleryPhotoController.text = photoURL;
      });
    }
  }

  Future<void> savePhotoURLToGallery(String photoURL) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('gallery').add({
          'photoURL': photoURL,
          'userId': currentUser.uid,  // Adiciona o ID do usuário logado
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Foto adicionada à galeria com sucesso!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nenhum usuário logado!')));
      }
    } catch (e) {
      print('Erro ao salvar URL da foto na galeria: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Fotografia'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Adicionar Foto da Galeria',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _galleryPhotoController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Foto da Galeria'),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 500,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFFCFDF9),
                          backgroundColor: Color(0xFF435364),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
              ),
              onPressed: () async {
                pickAndUploadGalleryPhoto();
              },
              child: Text('Escolher Foto da Galeria',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
