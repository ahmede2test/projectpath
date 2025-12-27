import 'package:flutter/material.dart';
import 'package:untitled4/ServiceTile.dart';

class Grid extends StatelessWidget {
  static const routeName = '/Grid';

  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset('assets/image/Services.png'),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                ServiceTile(icon: Icons.location_on, label: 'GPS'),
                ServiceTile(icon: Icons.access_time, label: 'Memories'),
                ServiceTile(icon: Icons.add, label: 'Add Service'),
                ServiceTile(icon: Icons.add, label: 'Add Service'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
