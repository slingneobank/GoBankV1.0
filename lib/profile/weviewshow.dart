import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/media.dart';
class webViewshow extends StatefulWidget {
   String urllink;
   
   webViewshow( {Key? key,required this.urllink}) : super(key: key);

  @override
  State<webViewshow> createState() => _webViewshowState();
}

class _webViewshowState extends State<webViewshow> {
 
@override
  void dispose() {
  
    _webViewshowState();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final webviewkey = UniqueKey();
  final Completer<WebViewController>_controller1=Completer<WebViewController>();
  
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: WebView(
                        key: webviewkey,
                        initialUrl: widget.urllink,
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
