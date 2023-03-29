import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleAuthScreen extends StatefulWidget {
  @override
  _GoogleAuthScreenState createState() => _GoogleAuthScreenState();
}

class _GoogleAuthScreenState extends State<GoogleAuthScreen> {
  final String _authUrl =
      'https://accounts.google.com/o/oauth2/v2/auth?client_id=<YOUR_CLIENT_ID>&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&redirect_uri=<YOUR_REDIRECT_URI>';

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Authorization'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: _authUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
