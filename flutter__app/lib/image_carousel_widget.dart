import 'package:flutter/material.dart';

class ImageCarouselWidget extends StatelessWidget {
  final PageController pageController;

  const ImageCarouselWidget({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView(
        controller: pageController,
        children: [
          Image.asset(
            'assets/images/banerAnimado1.gif',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/banerAnimado2.gif',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/banerAnimado3.gif',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
