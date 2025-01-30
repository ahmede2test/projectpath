import 'package:flutter/material.dart';

class Homecontent extends StatelessWidget {
  static const routeName = '/ Homecontent';

  const Homecontent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset('assets/image/Home.png'),
          ),
          SizedBox(height: 50),
          Container(
            height: 480,
            width: double.infinity,
            child: Image.asset(
              'assets/image/🌎 Map Maker_ GPS Junction, Polonnaruwa, Sri Lanka (Standard)@2x.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
