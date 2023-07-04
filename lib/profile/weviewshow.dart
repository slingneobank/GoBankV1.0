import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewshow extends StatelessWidget {
  String urllink;
   webViewshow({Key? key,required this.urllink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webviewkey = UniqueKey();
  final Completer<WebViewController>_controller1=Completer<WebViewController>();
  
    return Scaffold(
      body: WebView(
                        key: webviewkey,
                        initialUrl: urllink,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:  (WebViewController webViewController)
                            {
                             _controller1.complete(webViewController);
                            },
                        gestureNavigationEnabled: true,
                      ),
    );
  }
}