import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/AboutUsScreen.dart';
import 'package:untitled4/Grid.dart';
import 'package:untitled4/NotificationContent.dart';
import 'package:untitled4/home/SignUpScreen.dart';
import 'package:untitled4/home/Splash.dart';
import 'package:untitled4/home/home_Screan.dart';
import 'package:untitled4/home/login.dart';

import 'firebase_options.dart';
import 'home/AccountScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
    path: 'assets/Translation',
    fallbackLocale: Locale('en', 'US'),
    child: MyApp(),
  ));
}

// Main App Widget with ThemeMode toggle
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void initState() {
    super.initState();
    // Initialize with a default value
  }

  // Toggle between Light and Dark mode
  void _toggleTheme() {
    setState(() {
      _themeMode =
          (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => Splash(),
        Login.routeName: (context) => Login(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) =>
            HomeScreen(toggleTheme: _toggleTheme),
        Grid.routeName: (context) => Grid(),
        Notificationcontent.routeName: (context) => Notificationcontent(),
        AboutUsScreen.routeName: (context) => AboutUsScreen(),
        '/account': (context) => AccountScreen(),
      },
    );
  }
}
