import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();
  final TextEditingController _galleryPhotoController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    try {
      var snapshot = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
      if (snapshot.exists) {
        var userData = snapshot.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _phoneController.text = userData['phone'] ?? '';
          _userController.text = userData['user'] ?? '';
          _ufController.text = userData['UF'] ?? '';
          _cityController.text = userData['city'] ?? '';
          _profilePhotoController.text = userData['photoURL'] ?? '';
        });
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    }
  }

  Future<XFile?> getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> upload(String path, String folderName) async {
    File file = File(path);
    try {
      String ref = 'images/$folderName/img-${DateTime.now().toString()}.png'; // Pasta diferente no Firebase Storage
      final uploadTask = await storage.ref(ref).putFile(file);
      final downloadURL = await uploadTask.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Erro no upload: $e');
    }
  }

  pickAndUploadProfilePhoto() async {
    XFile? file = await getImage();
    if (file != null) {
      String photoURL = await upload(file.path, 'user_photos'); // Pasta 'user_photos' no Firebase Storage
      setState(() {
        _profilePhotoController.text = photoURL; // Atualiza o controller com o URL
      });
    }
  }

  pickAndUploadGalleryPhoto() async {
    XFile? file = await getImage();
    if (file != null) {
      String photoURL = await upload(file.path, 'gallery_photos'); // Pasta 'gallery_photos' no Firebase Storage
      setState(() {
        _galleryPhotoController.text = photoURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextFormField(
              controller: _ufController,
              decoration: InputDecoration(labelText: 'UF'),
            ),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateUserProfile();
              },
              child: Text('Salvar Dados'),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Adicionar Foto de Perfil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _profilePhotoController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Foto de Perfil'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                pickAndUploadProfilePhoto();
              },
              child: Text('Escolher Foto de Perfil'),
            ),
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
            ElevatedButton(
              onPressed: () async {
                pickAndUploadGalleryPhoto();
              },
              child: Text('Escolher Foto da Galeria'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserProfile() async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'user': _userController.text,
        'UF': _ufController.text,
        'city': _cityController.text,
        'photoURL': _profilePhotoController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dados atualizados com sucesso!')));
    } catch (e) {
      print('Erro ao atualizar dados do usuário: $e');
    }
  }
}
