import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/screen/homebottombar.dart';
import 'package:kolacur_admin/screen/homepage.dart';
import 'package:kolacur_admin/screen/verifyOtp.dart';
import 'package:kolacur_admin/utils/CommomDialog.dart';
import 'package:http/http.dart' as http;
import '../controller/auth_controller.dart';
import '../utils/Utils.dart';
import '../utils/appconstant.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthControlller authControlller = Get.put(AuthControlller());
  late TextEditingController emailcontroller,_passwordcontorller;
  TextEditingController _textFieldControllerupdateABout =
  TextEditingController();
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailcontroller = TextEditingController();
    _passwordcontorller=TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('images/svgicons/dottedbackground.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.04,
              ),
              const Center(
                child: Text(
                  'Kolacut',
                  style: const TextStyle(fontFamily: 'Poppins Regular'),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width * 0.7 - width * 0.03,
                height: height * 0.4 - height * 0.03,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/svgicons/loginpn.png'),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Utils().titleTextsemibold('Login Now', context),
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: Text(
                  'Welcome to the Kolacut Partner',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(Utils.hexStringToHexInt('7E7E7E')),
                      fontFamily: 'Poppins Regular',
                      fontSize: width * 0.03),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.7,
                    height: height * 0.1 - height * 0.04,
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                              hintText: 'abc@gmail.com',
                              hintStyle: TextStyle(
                                  color:
                                      Color(Utils.hexStringToHexInt('A4A4A4')),
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              border: InputBorder.none)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.7,
                    height: height * 0.1 - height * 0.04,
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: Center(
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _passwordcontorller,
                          decoration: InputDecoration(
                              hintText: '*********',
                              hintStyle: TextStyle(
                                  color:
                                      Color(Utils.hexStringToHexInt('A4A4A4')),
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              border: InputBorder.none)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.01,),
              Container(
                margin: EdgeInsets.only(right: width*0.1+width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            var valueName = "";
                            var valuePrice = "";
                            return AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Reset password here...',
                                    style: TextStyle(
                                        fontSize: 8.0),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.pop(
                                            context),
                                    icon: const Icon(Icons
                                        .cancel_outlined),
                                  ),
                                ],
                              ),
                              content: Container(
                                width: 200,
                                child:
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                        height * 0.03,
                                      ),
                                      SizedBox(
                                        width: width,
                                        child: TextField(
                                          textCapitalization:
                                          TextCapitalization
                                              .sentences,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              valueName =
                                                  value;
                                            });
                                          },
                                          keyboardType:
                                          TextInputType
                                              .multiline,
                                          maxLines: 1,
                                          controller:
                                          _textFieldControllerupdateABout,
                                          decoration:
                                          const InputDecoration(
                                            border: OutlineInputBorder(),
                                              icon: Icon(Icons.email,color: Colors.cyan,),
                                              hintText:
                                              "Enter email here..."),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      FlatButton(
                                        padding: EdgeInsets.all(6.0),
                                        color: Color(Utils.hexStringToHexInt('46D0D9')),
                                        textColor:
                                        Colors.white,
                                        child: Text('OK'),
                                        onPressed:
                                            () async {
                                          Map map = {
                                            "session_id":
                                            box.read(
                                                'session'),
                                            "description":
                                            _textFieldControllerupdateABout
                                                .text
                                                .toString()
                                          };
                                          print(map);
                                          // var apiUrl = Uri
                                          //     .parse(AppConstant
                                          //     .BASE_URL +
                                          //     AppConstant
                                          //         .UPDTE_SHOP);
                                          // print(apiUrl);
                                          // print(map);
                                          // final response =
                                          // await http
                                          //     .post(
                                          //   apiUrl,
                                          //   body: map,
                                          // );
                                          // print(response
                                          //     .body);
                                          // _textFieldControllerupdateABout
                                          //     .clear();
                                          Navigator.pop(
                                              context);

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: <Widget>[],
                            );
                          },
                        );
                      },
                      child: Text(
                        '  Forgot Password ?',
                        style: TextStyle(
                          fontSize: width * 0.02,
                          color: Color(Utils.hexStringToHexInt('77ACA2')),
                          fontFamily: 'Poppins Regular',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if(emailcontroller.text.toString()!=""||
                  _passwordcontorller.text.toString()!=""){
authControlller.login(emailcontroller.text.toString(),  _passwordcontorller.text.toString());
                  }else{
                    CommonDialog.showsnackbar("All fileds are mandatory");
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomeBottomBar()),
                  // );
                },
                child: Container(
                  width: width * 0.5,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.08),
                      color: Color(Utils.hexStringToHexInt('46D0D9'))),
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          },
                          child: Container(
                            child: Text("Register",
                                style: TextStyle(
                                  color: Color(Utils.hexStringToHexInt('77ACA2')),
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
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
