import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//ignore: must_be_immutable
class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://www.growingartterrariums.com/blog',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
        ),
    );
  }
}
