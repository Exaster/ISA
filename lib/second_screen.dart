import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'third_screen.dart';
import 'dart:ui';

class SecondScreen extends StatelessWidget {
  //Cтворення контролерів редагування тексту для полів електронної пошти та пароля
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // визначити основний колір
  static const primaryColor = Color(0xFFAED581);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor, // встановити колір фону
      body: Stack(
        children: [
          // Встановлення фонового зображення
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
                  color: Colors.lightBlue[100], // Встановлення кольору контейнера
                  borderRadius: BorderRadius.circular(30), // Встановлення радіусу кордону
                ),
                padding: const EdgeInsets.all(20), // set container padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Створення текстового поля електронної пошти
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
                    // Створення текстового поля пароля
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
                        // створення кнопки входу
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
                        // створення кнопки (Забув пароль).
                        ElevatedButton(
                          onPressed: () {
                            String url =
                                "https://cit.pnu.edu.ua/corporate_email/"; // set url to launch
                            launch(url); // launch url
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