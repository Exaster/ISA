import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';
import 'news.dart';

class ThirdScreen extends StatelessWidget {
  final String email;
  static const primaryColor = Color(0xFFAED581);

  const ThirdScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Welcome $email'),
      ),

      body:Image.asset(

        'assets/images/background.png',
        fit: BoxFit.fill,
        width: window.physicalSize.width,
        height: window.physicalSize.height,
      ),
      // Створення ящика, який містить список опцій для користувача
      drawer: Drawer(
        backgroundColor: primaryColor,
        child: ListView(
          children: [
            // Додаємо заголовок до ящика, який відображає електронну адресу користувача та зображення профілю
            UserAccountsDrawerHeader(
              accountName: Text(email),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFFF1F8E9),
                child: Text(
                  email.substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            // Додайте плитку списку для кожного параметра в ящику
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Розклад'),
              onTap: () {
                // Коли користувач натискає опцію (Розклад), його закидає на екран веб-сайту, на якому відображається розклад
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebsiteScreen(url: 'https://asu.pnu.edu.ua/search-groups.html'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Дистанційне навчання'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebsiteScreen(url: 'https://d-learn.pro/'),
                  ),
                );
              },
            ),
            // Список плиток, які відображатимуться в панелі програми
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Журнал'),
              // Функція, яка викликається під час торкання
              onTap: () {
                // Переходить на екран веб-сайту, який показує журнал, коли торкнутися
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebsiteScreen(url: 'https://webportal.pnu.edu.ua/apps'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Новини'),
              // Функція, яка викликається під час торкання
              onTap: () {
                // Переходить на екран веб-сайту, який показує журнал, коли торкнутися
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebsiteScreen(url: 'https://pnu.edu.ua/'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Навігація'),
              onTap: () {
                // Переходить на екран веб-сайту, який показує журнал, коли торкнутися
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebsiteScreen(url: 'https://city.dozor.tech/ua/iv-frankivsk/city'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Путівник студента'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebsiteScreen(url: 'https://pnu.edu.ua/studentam-2/'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Вихід'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


