import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled4/home/home_Screan.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _staySignedIn = false;
  bool _isLoading = false;
  bool _isInternetConnected = true;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });
      // التعامل مع تسجيل الدخول الناجح
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      // التعامل مع خطأ تسجيل الدخول
      if (e.code == 'network-request-failed') {
        setState(() {
          _isInternetConnected = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('failed_to_sign_in') + e.message!)),
      );
    }
  }

  Future<void> _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('password_reset_email_sent'))),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('error') + e.message!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/image/Group 2 .png',
            height: 40,
          ),
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    if (!_isInternetConnected) ...[
                      Text(
                        tr('no_internet_connection'),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                    Text(
                      tr('welcome_message'),
                      style: TextStyle(
                        fontSize: 64,
                        color: Color(0xFF1865A9),
                        fontFamily: 'Dynalight',
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.asset('assets/image/Frame 14.png'),
                    SizedBox(height: 10),
                    Text(
                      tr('login_prompt'),
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1865A9),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: tr('email_label'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: tr('password_label'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _staySignedIn,
                          onChanged: (bool? value) {
                            setState(() {
                              _staySignedIn = value!;
                            });
                          },
                        ),
                        Text(tr('stay_signed_in')),
                        Spacer(),
                        TextButton(
                          onPressed: _resetPassword,
                          child: Text(
                            tr('forgot_password'),
                            style: TextStyle(
                              color: Color(0xFF1865A9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _login,
                          child: Text(
                            tr('login_button'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1865A9),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text.rich(
                          TextSpan(
                            text: tr('not_registered_yet'),
                            style: TextStyle(color: Colors.red),
                            children: [
                              TextSpan(
                                text: ' ' + tr('create_account'),
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
