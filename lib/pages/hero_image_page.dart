import 'package:flutter/material.dart';

class HeroImagePage extends StatelessWidget {
  final String image;

  const HeroImagePage({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: image,
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
