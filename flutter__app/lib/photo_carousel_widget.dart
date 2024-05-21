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
  int activePage = 0;

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
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemCount: photographerPhotos.length,
              itemBuilder: (context, index) {
                return _buildPhotoCard(photographerPhotos[index], index);
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(photographerPhotos.length, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                height: 8.0,
                width: activePage == index ? 12.0 : 8.0,
                decoration: BoxDecoration(
                  color: activePage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard(String photoPath, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 220,
            width: Curves.easeInOut.transform(value) * 400,
            child: child,
          ),
        );
      },
      child: Padding(
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
      ),
    );
  }
}
