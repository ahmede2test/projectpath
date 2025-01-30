import 'package:flutter/material.dart';
import 'package:untitled4/Grid.dart';
import 'package:untitled4/NotificationContent.dart';
import 'package:untitled4/home/SignUpScreen.dart';
import 'package:untitled4/home/Splash.dart';
import 'package:untitled4/home/home_Screan.dart';
import 'package:untitled4/home/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => Splash(),
        Login.routeName: (context) => Login(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        Grid.routeName: (context) => Grid(),
        Notificationcontent.routeName: (context) => Notificationcontent(),
      },
    );
  }
}
