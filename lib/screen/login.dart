import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/register.dart';
import 'package:untitled/screen/verifyOtp.dart';
import 'package:untitled/utils/CommomDialog.dart';
import 'package:untitled/utils/Utils.dart';
import 'package:geolocator/geolocator.dart';
import '../controller/auth_controller.dart';
import 'homebottombar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailcontroller;
  AuthControlller authControlller = Get.put(AuthControlller());
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  late Position _currentPosition;
  late String _currentAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailcontroller = TextEditingController();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        if (kDebugMode) {
          print(_currentPosition);
        }
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/svgicons/dottedbackground.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.04,
              ),
              const Center(
                child: Text(
                  'Kolacut',
                  style: TextStyle(fontFamily: 'Poppins Regular'),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width * 0.5 +width*0.06,
                height: height * 0.2+height*0.06 ,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/svgicons/logibar.png'),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Utils().titleTextsemibold('Login Now', context),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: width * 0.08, right: width * 0.08),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: width * 0.2 - width * 0.20,
                        height: height * 0.1 - height * 0.04,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  1.0, 1.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Text(
                                ' +91',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins Regular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.03),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: width * 0.06,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: width - 5,
                        height: height * 0.1 - height * 0.04,
                        padding: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color: Color(Utils.hexStringToHexInt('F4F4F4')),
                        ),
                        child: Center(
                          child: TextField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter your 10 Digit Mobile No.',
                                  hintStyle: TextStyle(
                                      color: Color(
                                          Utils.hexStringToHexInt('A4A4A4')),
                                      fontFamily: 'Poppins Regular',
                                      fontSize: width * 0.03),
                                  border: InputBorder.none)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if (emailcontroller.text.toString() == "") {
                    CommonDialog.showsnackbar("Please enter mobile no");
                  } else if (!GetUtils.isPhoneNumber(
                      emailcontroller.text.toString())) {
                    CommonDialog.showsnackbar("Please enter valid mobile no");
                    //print(authControlller.sendData() + "fsdfsdfsdf");
                  } else {
                    authControlller.login(emailcontroller.text.toString());
                  }
                },
                child: Container(
                  width: width * 0.5,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.08),
                      color: Color(Utils.hexStringToHexInt('77ACA2'))),
                  child: Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins Semibold',
                          fontSize: width * 0.04),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: width * 0.08, right: width * 0.08),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Divider(
                          color: Color(Utils.hexStringToHexInt('77ACA2')),
                          thickness: 2,
                        )),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        color: Color(Utils.hexStringToHexInt('77ACA2')),
                        fontFamily: 'Poppins Regular',
                        fontSize: width * 0.02),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Color(Utils.hexStringToHexInt('77ACA2')),
                          thickness: 2,
                        )),
                  ),
                ]),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: width * 0.08, right: width * 0.08),
                width: width,
                height: height * .07,
                child: Material(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  elevation: 8,
                  child: Container(
                    width: width,
                    height: height * .07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "images/svgicons/logos_google-gmail.svg",
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Continue with Gmail',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins Regular',
                              fontSize: width * 0.03),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Don’t have an account ? ",
                      style: TextStyle(
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontFamily: 'Poppins Regular',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 3, // space between underline and text
                    ),
                    child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SignUpPage()),
                          // );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: Container(
                            child: Text("Register",
                                style: TextStyle(
                                  color:
                                      Color(Utils.hexStringToHexInt('77ACA2')),
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins Semibold',
                                ),
                                textAlign: TextAlign.end),
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  },
                  child: Container(
                    child: Text("SKIP",
                        style: TextStyle(
                          color: Color(Utils.hexStringToHexInt('77ACA2')),
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins Semibold',
                        ),
                        textAlign: TextAlign.end),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
