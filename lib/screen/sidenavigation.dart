import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Utils.dart';

class SideNavigatinPage extends StatefulWidget {
  var s = "", s1 = "", s2 = "", s3 = "";

  SideNavigatinPage(String s, String s1, String s2, String s3, {Key? key}) {
    this.s = s;
    this.s1 = s1;
    this.s2 = s2;
    this.s3 = s3;
  }

  @override
  State<SideNavigatinPage> createState() =>
      _SideNavigatinPageState(s, s1, s2, s3);
}

class _SideNavigatinPageState extends State<SideNavigatinPage> {
  late SharedPreferences sharedPreferences;

  _SideNavigatinPageState(String s, String s1, String s2, String s3);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(width * 0.06),
                      bottomRight: Radius.circular(width * 0.06),
                    )),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: width,
                          height: height,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.3,
                              ),
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: const Text(' About '),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: const Icon(Icons.keyboard_arrow_right),
                              ),
                              Divider(
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: const Text(' Employee '),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: const Icon(Icons.keyboard_arrow_right),
                              ),
                              Divider(
                                height: 1.0,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                              color: Color(Utils.hexStringToHexInt('46D0D9')),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(width * 0.06),
                                bottomRight: Radius.circular(width * 0.06),
                              )),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 6.0, right: 6.0),
                              width: width,
                              height: height * 0.1,
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(35),
                                            child: Image.network(
                                              "${widget.s1}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${widget.s}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.04,
                                            fontFamily: 'Poppins Regular',
                                          ),
                                        ),
                                        Text(
                                          "${widget.s2}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.02,
                                            fontFamily: 'Poppins Regular',
                                          ),
                                        ),
                                        Text(
                                          "${widget.s3}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.02,
                                            fontFamily: 'Poppins Regular',
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 4.0),
                                      child: Image.asset(
                                        'images/svgicons/edit.png',
                                        width: 12,
                                        height: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: height * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 4.0),
                                width: width - width * 0.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'V 1.2.3',
                                      style: TextStyle(
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.04,
                                          color: Color(
                                              Utils.hexStringToHexInt('8D8D8D'))),
                                    ),
                                    SvgPicture.asset(
                                      "images/svgicons/logoutt.svg",
                                      width: width * 0.05,
                                      height: height * 0.05,
                                      fit: BoxFit.contain,
                                      color:
                                      Color(Utils.hexStringToHexInt('A3A2A2')),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Center(
                                child: Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      color:
                                      Color(Utils.hexStringToHexInt('46D0D9')),
                                      fontFamily: 'Poppins Semibold',
                                      fontSize: width * 0.03),
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            iconSize: 30,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
