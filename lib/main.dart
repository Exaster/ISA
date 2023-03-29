import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'dart:ui';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

//Клас MyApp, який розширює StatelessWidget
class MyApp extends StatelessWidget {
  // Метод збірки для створення інтерфейсу користувача програми
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Назва програми
      title: 'Flutter Example App',
      // Тема програми
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Головний екран, який відображатиметься першим
      home: FirstScreen(),
    );
  }
}

// Клас FirstScreen, який розширює StatelessWidget
class FirstScreen extends StatelessWidget {
  // Метод збірки для створення інтерфейсу користувача першого екрана
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Налаштування тіла екрана на віджет стека
      body: Stack(
        children: [
          // Відображення фонового зображення, яке покриває весь екран
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Розміщення зображення логотипа по центру екрана
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 240,
              height: 240,
            ),
          ),
          // Відображення кнопки внизу екрана
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                // Після натискання кнопки перейдіть до другого екрана
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()),
                  );
                },
                child: Text('Celebration!'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
