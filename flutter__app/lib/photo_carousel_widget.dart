import 'package:flutter/material.dart';
import 'dart:math';

class PhotoCarouselWidget extends StatefulWidget {
  @override
  _PhotoCarouselWidgetState createState() => _PhotoCarouselWidgetState();
}

class _PhotoCarouselWidgetState extends State<PhotoCarouselWidget> {
  final List<String> photographerPhotos = [
    'assets/images/photo1_teste.jpg',
    'assets/images/photo2_teste.jpg',
    'assets/images/photo3_teste.jpg',
    // Adicione mais caminhos de fotos conforme necessário
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    photographerPhotos.shuffle(Random());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x55555534),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fotos de Fotógrafos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: photographerPhotos.length,
              itemBuilder: (context, index) {
                return _buildPhotoCard(photographerPhotos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard(String photoPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            photoPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
