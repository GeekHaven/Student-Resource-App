import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  Web({this.url});
  final String url;
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WebView(
        initialUrl: 'https://www.google.com/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
      )),
    );
  }
}
