import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  Text(
                    'Welcome',
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
                    'Login to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1865A9),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
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
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                      Checkbox(value: false, onChanged: (bool? value) {}),
                      Text('Stay signed in'),
                      SizedBox(
                        height: 11,
                        width: 9,
                      ),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          Text('Forgot Password?'),
                        ],
                      ),
                      SizedBox(height: 11, width: 11),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Login',
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
                          text: 'Not registered yet?',
                          style: TextStyle(color: Colors.red),
                          children: [
                            TextSpan(
                              text: ' Create your account!',
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
    );
  }
}
