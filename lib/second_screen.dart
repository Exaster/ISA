import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'third_screen.dart';
import 'dart:ui';

class SecondScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const primaryColor = Color(0xFFAED581);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThirdScreen(
                                  email: emailController.text,
                                ),
                              ),
                            );
                          },
                          child: Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String url =
                                "https://cit.pnu.edu.ua/corporate_email/";
                            launch(url);
                          },
                          child: Text('Forgot password'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'third_screen.dart';
import 'dart:ui';


class SecondScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const primaryColor = Color(0xFFAED581);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: primaryColor,
      /*appBar: AppBar(
        title: Text('Login/Register'),
      ),*/

      body:
      Stack(
        children: [
        Image.asset(
        'assets/images/background.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Padding(

        padding: const EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(

              controller: emailController,
              decoration: InputDecoration(

                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(

              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdScreen(
                      email: emailController.text,
                    ),
                  ),
                );
              },
              child: Text('Login'),

            ),
            ElevatedButton(
              onPressed: () {
                String url = "https://cit.pnu.edu.ua/corporate_email/";
                launch(url);
              },
              child: Text('Forgot password'),
            ),
          ],
        ),
      ),
    ]));
  }
}
*/