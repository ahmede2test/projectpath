import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text('This is the About Us page.'),
      ),
    );
  }
}
