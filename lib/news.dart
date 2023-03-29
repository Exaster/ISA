import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsiteScreen extends StatefulWidget {
  final String url;

  WebsiteScreen({required this.url}); // Конструктор, який приймає необхідний параметр url

  @override
  _WebsiteScreenState createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  late WebViewController _controller; // WebViewController для керування веб-переглядом

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Website Screen'),
      ),
      body: WebView(
        initialUrl: widget.url, // Установіть початкову URL-адресу з параметра віджета
        javascriptMode: JavascriptMode.unrestricted, // JavaScript у веб-перегляді
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController; // Встановлення контролера веб-перегляду під час створення веб-перегляду
        },
      ),
    );
  }
}