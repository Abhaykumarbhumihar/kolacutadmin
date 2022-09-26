import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermConditionPage extends StatefulWidget {
  const TermConditionPage({Key? key}) : super(key: key);

  @override
  State<TermConditionPage> createState() => _TermConditionPageState();
}

class _TermConditionPageState extends State<TermConditionPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // if (Platform.isAndroid) WebView.platform = AndroidWebView();

  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(child:
     Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0.0,
         automaticallyImplyLeading: false,
         titleSpacing: 0,
         centerTitle: false,
         leading: InkWell(
           onTap: () {
             Navigator.pop(context);
           },
           child: Icon(
             Icons.arrow_back,
             color: Colors.black,
           ),
         ),
         title: Text(
           'Terms and conditions',
           style: TextStyle(
               color: Colors.black,
               fontFamily: 'Poppins Medium',
               fontSize: width * 0.04),
         ),
         actions: <Widget>[],
       ),
       body: WebView(
         initialUrl: 'http://kolacut.kvpscampuscare.com/public/user-terms',
         javascriptMode: JavascriptMode.disabled,
       ),
     ));
  }
}
