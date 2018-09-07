import 'package:flutter/material.dart';

class HeroScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
            'https://pic3.zhimg.com/v2-e9331111d1e0b952ddb8584da503369f_b.jpg'),
          ),
        ),
        onTap: () {Navigator.pop(context);},
      ),
    );
  }
}