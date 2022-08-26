import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolacur_admin/controller/dashboard_controller.dart';

import '../utils/Utils.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  DashboardController dashboardController = Get.put(DashboardController());


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashboardController.getDashboardData();
     // Get.lazyPut(()=>DashboardController().getDashboardData());

    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            ),
           title: Text(
              'Profile',
              style: TextStyle(
                  fontFamily: 'Poppins Regular',
                  color: Colors.white,
                  fontSize: width * 0.04),
            ),
          ),
      body:GetBuilder<DashboardController>(
        builder: (dashboardController){
           if(dashboardController.lodaer){
             return Container();
           }else{
             return  Container(
               width: width,
               height: height,
               child: Column(
                 children: <Widget>[
                   SizedBox(height: 20,),
                   Center(
                     child: Text(
                       'Total Revenie',
                       style: TextStyle(
                           fontFamily: 'Poppins Medium',
                           fontSize: MediaQuery.of(context).size.height * 0.03,
                           color: Colors.black),
                     ),
                   ),
                   Center(
                     child: Text(
                       '1000',
                       style: TextStyle(
                           fontFamily: 'Poppins Medium',
                           fontSize: MediaQuery.of(context).size.height * 0.03,
                           color: Colors.black),
                     ),
                   ),
                   SizedBox(
                     height: height * 0.06,
                   ),
                   Material(
                     borderRadius: BorderRadius.circular(width * 0.04),
                     elevation: 0,
                     child: Container(
                       margin:
                       EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                       width: width,
                       height: height * 0.2,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(width * 0.04),
                           gradient: LinearGradient(
                               begin: Alignment.topRight,
                               end: Alignment.bottomLeft,
                               colors: [
                                 Color(Utils.hexStringToHexInt('#76cbfb')),
                                 Color(Utils.hexStringToHexInt('#3ac1ca')),
                                 Color(Utils.hexStringToHexInt('#47c3d4')),
                               ])),
                       child: Container(
                         margin: EdgeInsets.only(left: 12, right: 12),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,

                                   children: <Widget>[
                                     Text(
                                       'Order Received',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     ),
                                     Text(
                                       '${ dashboardController.dashboardPojo
                                           .value
                                           .data![0]
                                           .openBooking
                                           .toString()} ',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     )
                                   ],
                                 ),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,

                                   children: <Widget>[
                                     Text(
                                       'Completed Orders ',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     ),
                                     Text(
                                       '0 ',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     )
                                   ],
                                 )
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text(
                                       'Total Earnings ',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     ),
                                     Text(
                                       "0",
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     )
                                   ],
                                 ),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text(
                                       'Monthly Earnings ',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     ),
                                     Text(
                                       '0',
                                       style: TextStyle(
                                           fontFamily: 'Poppins Semibold',
                                           fontSize:
                                           MediaQuery.of(context).size.height *
                                               0.02 -
                                               height * 0.003,
                                           color: Colors.white),
                                     )
                                   ],
                                 )
                               ],
                             )
                           ],
                         ),
                       ),
                     ),
                   ),
                   Flexible(
                     child: Container(
                       width: width,
                       height: height * 0.4,
                       margin: EdgeInsets.all(6.0),
                       child: Material(
                         elevation: 6,
                         child: Flexible(
                           child: WebView(
                             initialUrl:
                             'http://kolacut.kvpscampuscare.com/public/employee_graph/87',
                             javascriptMode: JavascriptMode.disabled,
                             onWebViewCreated: (WebViewController webViewController) {
                               _controller.complete(webViewController);
                             },
                             onProgress: (int progress) {

                               print('WebView is loading (progress : $progress%)');
                             },
                             javascriptChannels: <JavascriptChannel>{
                               _toasterJavascriptChannel(context),
                             },
                             navigationDelegate: (NavigationRequest request) {
                               if (request.url
                                   .startsWith('https://www.youtube.com/')) {
                                 print('blocking navigation to $request}');
                                 return NavigationDecision.prevent;
                               }
                               print('allowing navigation to $request');
                               return NavigationDecision.navigate;
                             },
                             onPageStarted: (String url) {
                               print('Page started loading: $url');
                             },
                             onPageFinished: (String url) {
                               print('Page finished loading: $url');
                             },
                             gestureNavigationEnabled: true,
                             backgroundColor: const Color(0x00000000),
                           ),
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             );
           }
        },
      )

    ));
  }

}
