import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/Grid.dart';
import 'package:untitled4/HomeContent.dart';
import 'package:untitled4/NotificationContent.dart';
import 'package:untitled4/home/AccountScreen.dart';

import '../AboutUsScreen.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;

  const HomeScreen({required this.toggleTheme, super.key});

  static const routeName = '/Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('change_language'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.language, color: Colors.blue),
                title: Text('English'),
                onTap: () {
                  context.setLocale(Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.language, color: Colors.green),
                title: Text('Arabic'),
                onTap: () {
                  context.setLocale(Locale('ar', 'EG'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr()),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/image/Group 2 .png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AccountScreen()), // استبدل AccountScreen بالشاشة المرغوبة
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('home'.tr()),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('dark_mode'.tr()),
              leading: Icon(Icons.brightness_6),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                widget.toggleTheme(); // Toggle theme
              },
            ),
            ListTile(
              title: Text('about_us'.tr()),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutUsScreen.routeName);
              },
            ),
            ListTile(
              title: Text('sign_out'.tr()),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                try {
                  await FirebaseAuth.instance
                      .signOut(); // Sign out from Firebase
                  Navigator.pushReplacementNamed(
                      context,
                      Login
                          .routeName); // Navigate to LoginScreen and replace the current route
                } catch (e) {
                  print('Sign out error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('failed_to_sign_in'.tr())),
                  );
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text('change_language'.tr()),
              leading: Icon(Icons.language),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          Homecontent(),
          Grid(),
          Notificationcontent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'grid'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notifications'.tr(),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
