import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showLogo = true;

  @override
  void initState() {
    super.initState();
    // Set a timer to hide the logo and show HomeScreen after a delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showLogo = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Stack(
        alignment: Alignment.center,
        children: [
          HomeScreen(),
          if (showLogo)
            AnimatedOpacity(
              duration: Duration(seconds: 1), // Adjust the duration as needed
              opacity: showLogo ? 1.0 : 0.0,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Image.asset(
                    'assets/images/PNU.png', // Make sure the image path is correct
                    width: 200, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
