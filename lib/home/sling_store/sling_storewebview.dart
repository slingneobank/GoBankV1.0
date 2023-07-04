import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class sling_storewebview extends StatelessWidget {
  String Urllink;
   sling_storewebview({Key? key,required this.Urllink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webviewkey = UniqueKey();
  final Completer<WebViewController>_controller1=Completer<WebViewController>();
   
  String url=Urllink;
  
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
           Padding(
             padding: const EdgeInsets.only(left: 10,right: 10),
             child: Container(
              height: 70,
              width: width,
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   InkWell(
                           onTap: () {
                    Navigator.pop(context);
                           },
             
                           child: Icon(Icons.arrow_back_ios,color: Colors.black),
                           ),
                  SizedBox(
                    child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 150,
                        
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                                        "Slingstore card details"  ,
                                          overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                    style: TextStyle(
                                             fontFamily: "Gilroy medium",
                                             color: Colors.white,
                                             fontSize: height / 55,),
                                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.refresh)
                    ],
                  ),)
                 ],
               ),
             ),
           ),
          Expanded(
            child: WebView(
                              key: webviewkey,
                              initialUrl: url,
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated:  (WebViewController webViewController)
                                  {
                                   _controller1.complete(webViewController);
                                  },
                              gestureNavigationEnabled: true,
                            ),
          ),
        ],
      ),
    );
  }
}