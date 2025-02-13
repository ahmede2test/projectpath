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
                leading: const Icon(Icons.language, color: Colors.blue),
                title: const Text('English'),
                onTap: () {
                  context.setLocale(const Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.green),
                title: const Text('Arabic'),
                onTap: () {
                  context.setLocale(const Locale('ar', 'EG'));
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
            icon: const Icon(Icons.account_circle),
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
            const DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('home'.tr()),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('dark_mode'.tr()),
              leading: const Icon(Icons.brightness_6),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                widget.toggleTheme(); // Toggle theme
              },
            ),
            ListTile(
              title: Text('about_us'.tr()),
              leading: const Icon(Icons.help),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutUsScreen.routeName);
              },
            ),
            ListTile(
              title: Text('sign_out'.tr()),
              leading: const Icon(Icons.exit_to_app),
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
            const Divider(),
            ListTile(
              title: Text('change_language'.tr()),
              leading: const Icon(Icons.language),
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
            icon: const Icon(Icons.home),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.grid_view),
            label: 'grid'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
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
