import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class web extends StatelessWidget {
  final String url;
  final String title;
  const web({Key? key,  required this.url, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black) ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: "https://www.facebook.com/",
      ),
    );
  }
}