import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoGallery(),
    );
  }
}

class PhotoGallery extends StatelessWidget {
  final List<String> photos = [
    "assets/images/image1.png",
    "assets/images/image2.png",
    "assets/images/image3.png",
    "assets/images/image4.png",
    "assets/images/image5.png",
    "assets/images/image6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Tecnologia'),
                  value: 'Tecnologia',
                ),
                PopupMenuItem(
                  child: Text('Casamento'),
                  value: 'Casamento',
                ),
                PopupMenuItem(
                  child: Text('Paisagem'),
                  value: 'Paisagem',
                ),
                PopupMenuItem(
                  child: Text('Esporte'),
                  value: 'Esporte',
                ),
                PopupMenuItem(
                  child: Text('Casual'),
                  value: 'Casual',
                ),
              ];
            },
            onSelected: (String value) {
            
              print('Selecionado: $value');
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            photos[index],
            fit: BoxFit.cover, 
          );
        },
      ),
    );
  }
}
