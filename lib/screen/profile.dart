import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/controller/profile_controllet.dart';
import 'package:untitled/screen/profile_update.dart';

import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import 'sidenavigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());
  late TextEditingController emailcontroller,
      _nameController,
      _dobController,
      _phonecontroller;
  String date = "";

  // Initial Selected Value
  String dropdownvalue = 'Male';
  final list = ['Male', 'Female'];

  var imageFile;
  DateTime selectedDate = DateTime.now();
  var genderSelect = "";
  var dob = "";
  var dropdown;
  var showselectGender = "";
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  late SharedPreferences sharedPreferences;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem<String>> _createList() {
    return list
        .map<DropdownMenuItem<String>>(
          (e) =>
          DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
    )
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    emailcontroller = TextEditingController();
    _phonecontroller = TextEditingController();
    _dobController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      setState(() {
        name = _testValue!;
        email = emailValue!;
        phone = _phoneValue!;
        iamge = _imageValue!;
        //  print(name+" "+email+" "+phone+" "+_imageValue);
      });
      // will be null if never previously saved
      // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/svgicons/profilebackgound.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: scaffolKey,
            drawer: SideNavigatinPage(
                "${name}", "${iamge}", "${email}", "${phone}"),
            appBar: AppBar(
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Color(Utils.hexStringToHexInt('77ACA2')),
              leading: InkWell(
                onTap: () {
                  scaffolKey.currentState!.openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              titleSpacing: 0,
              title: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'Poppins Regular',
                    color: Colors.white,
                    fontSize: width * 0.04),
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: width * 0.01),
                  child: SvgPicture.asset(
                    "images/svgicons/dissabledisco.svg",
                  ),
                )
              ],
            ),
            backgroundColor: Colors.transparent,
            body:

            GetBuilder<ProfileController>(builder: (profileController) {
              if (profileController.lodaer) {
                return Container();
              }
              else {
                return SingleChildScrollView(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  SizedBox(
                  height: height * 0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: width * 0.2 - width * 0.06,
                        backgroundImage: NetworkImage(profileController
                            .profilePojo.value.data!.profileImage!),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: width * 0.06),
                        child: Text(
                          'Personal Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.03,
                              fontFamily: 'Poppins Medium'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(ProfileUpdate());

                          //  _profileUpdate(context,width,height);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: width * 0.02),
                          width: width * 0.2,
                          height: height * 0.03,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.01),
                              color: Color(Utils.hexStringToHexInt('#ecfafb'))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: SvgPicture.asset(
                                  "images/svgicons/modify.svg",
                                ),
                              ),
                              Text(
                                'Modify',
                                style: TextStyle(
                                    fontSize: width * 0.02,
                                    fontFamily: 'Poppins Regular',
                                    color:
                                    Color(Utils.hexStringToHexInt('46D0D9'))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.06),
                    child: SizedBox(
                      width: width * 0.09,
                      child: Divider(
                        thickness: 3,
                        color: Color(Utils.hexStringToHexInt('77ACA2')),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.06),
                    width: width,
                    child: Column(
                      children: <Widget>[
                    Row(
                    children: <Widget>[
                      Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(Utils.hexStringToHexInt('A3A2A2')),
                          fontFamily: 'Poppins Regular',
                          fontSize: width * 0.03),
                    ),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Text(

                      profileController.profilePojo.value.data!.name
                          .toString() + "" != "" ? profileController.profilePojo
                          .value.data!.name.toString() + "" : "N/A",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(Utils.hexStringToHexInt('A3A2A2')),
                          fontFamily: 'Poppins Regular',
                          fontSize: width * 0.04),
                    )

                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Email',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('A3A2A2')),
                            fontFamily: 'Poppins Regular',
                            fontSize: width * 0.03),
                      ),
                      SizedBox(
                        width: width * 0.06,
                      ),
                      Text(
                        profileController.profilePojo.value.data!.email
                            .toString() + "" != ""
                            ? profileController.profilePojo.value.data!.email
                            .toString() + ""
                            : "N/A",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('A3A2A2')),
                            fontFamily: 'Poppins Regular',
                            fontSize: width * 0.04),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Contact',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('A3A2A2')),
                            fontFamily: 'Poppins Regular',
                            fontSize: width * 0.03),
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Text(
                        profileController.profilePojo.value.data!.phone
                            .toString() + "" != ""
                            ? profileController.profilePojo.value.data!.phone
                            .toString() + ""
                            : "N/A",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('A3A2A2')),
                            fontFamily: 'Poppins Regular',
                            fontSize: width * 0.04),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'DOB',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('A3A2A2')),
                            fontFamily: 'Poppins Regular',
                            fontSize: width * 0.03),
                      ),
                      SizedBox(
                        width: width * 0.06,
                      ),
                      Text(
                        " " + profileController.profilePojo.value.data!.dob
                            .toString() + "" != "" ? "  " + "${DateFormat.yMMMMd()
                            .format(DateTime.parse(
                            profileController.profilePojo.value.data!.dob
                                .toString()))}"+"" : "N/A",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(Utils.hexStringToHexInt('A3A2A2')),
                              fontFamily: 'Poppins Regular',
                              fontSize: width * 0.04),
                        )
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(
              height: height * 0.02,
              ),
              Divider(
              thickness: 1,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.only(left: width * 0.06),
              //       child: Text(
              //         'Leave Management',
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: width * 0.03,
              //             fontFamily: 'Poppins Medium'),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(right: width * 0.02),
              //       width: width * 0.2,
              //       height: height * 0.03,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(width * 0.01),
              //           color: Color(Utils.hexStringToHexInt('#ecfafb'))),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Center(
              //             child: SvgPicture.asset(
              //               "images/svgicons/modify.svg",
              //             ),
              //           ),
              //           Text(
              //             'Modify',
              //             style: TextStyle(
              //                 fontSize: width * 0.02,
              //                 fontFamily: 'Poppins Regular',
              //                 color:
              //                 Color(Utils.hexStringToHexInt('46D0D9'))),
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // Container(
              //   margin: EdgeInsets.only(left: width * 0.06),
              //   child: SizedBox(
              //     width: width * 0.09,
              //     child: Divider(
              //       thickness: 3,
              //       color: Color(Utils.hexStringToHexInt('77ACA2')),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // Container(
              //   margin:
              //   EdgeInsets.only(left: width * 0.04, right: width * 0.04),
              //   child: Material(
              //     borderRadius: BorderRadius.circular(width * 0.04),
              //     elevation: 6,
              //     child: Container(
              //       width: width,
              //       height: height * 0.2 - height * 0.06,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(width * 0.04),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Row(
              //             children: <Widget>[
              //               Container(
              //                 margin: EdgeInsets.only(left: width * 0.02),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: <Widget>[
              //                     SizedBox(
              //                       height: height * 0.002,
              //                     ),
              //                     Container(
              //                       margin:
              //                       EdgeInsets.only(left: width * 0.01),
              //                       width: width * 0.2,
              //                       height: height * 0.03,
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(
              //                               width * 0.01),
              //                           color: Color(Utils.hexStringToHexInt(
              //                               '#ecfafb'))),
              //                       child: Center(
              //                         child: Text(
              //                           'Available',
              //                           textAlign: TextAlign.center,
              //                           style: TextStyle(
              //                               color: Color(
              //                                   Utils.hexStringToHexInt(
              //                                       '46D0D9')),
              //                               fontFamily: 'Poppins Regular',
              //                               fontSize: width * 0.02),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: height * 0.01,
              //                     ),
              //                     Text(
              //                       ' May 01, 2021',
              //                       style: TextStyle(
              //                           fontSize: width * 0.02,
              //                           color: Color(Utils.hexStringToHexInt(
              //                               '8D8D8D')),
              //                           fontFamily: 'Poppins Regular'),
              //                     ),
              //                     SizedBox(
              //                       height: height * 0.001,
              //                     ),
              //                     Text(
              //                       ' Emergency at the house',
              //                       style: TextStyle(
              //                           fontSize: width * 0.02,
              //                           color: Color(Utils.hexStringToHexInt(
              //                               'C4C4C4')),
              //                           fontFamily: 'Poppins Regular'),
              //                     ),
              //                     SizedBox(
              //                       height: height * 0.01,
              //                     )
              //                   ],
              //                 ),
              //               )
              //             ],
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(right: width * 0.02),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 Container(
              //                   width: width * 0.2 - width * 0.06,
              //                   height: height * 0.02,
              //                   decoration: BoxDecoration(
              //                       borderRadius:
              //                       BorderRadius.circular(width * 0.04),
              //                       color: Color(
              //                           Utils.hexStringToHexInt('46D0D9'))),
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // Container(
              //   margin:
              //   EdgeInsets.only(left: width * 0.04, right: width * 0.04),
              //   child: Material(
              //     borderRadius: BorderRadius.circular(width * 0.04),
              //     elevation: 6,
              //     child: Container(
              //       width: width,
              //       height: height * 0.2 - height * 0.06,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(width * 0.04),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Row(
              //             children: <Widget>[
              //               Container(
              //                 margin: EdgeInsets.only(left: width * 0.02),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: <Widget>[
              //                     SizedBox(
              //                       height: height * 0.002,
              //                     ),
              //                     Container(
              //                       margin:
              //                       EdgeInsets.only(left: width * 0.01),
              //                       width: width * 0.2,
              //                       height: height * 0.03,
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(
              //                               width * 0.01),
              //                           color: Color(Utils.hexStringToHexInt(
              //                               '#ecfafb'))),
              //                       child: Center(
              //                         child: Text(
              //                           'Available',
              //                           textAlign: TextAlign.center,
              //                           style: TextStyle(
              //                               color: Color(
              //                                   Utils.hexStringToHexInt(
              //                                       '46D0D9')),
              //                               fontFamily: 'Poppins Regular',
              //                               fontSize: width * 0.02),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: height * 0.01,
              //                     ),
              //                     Text(
              //                       ' May 01, 2021',
              //                       style: TextStyle(
              //                           fontSize: width * 0.02,
              //                           color: Color(Utils.hexStringToHexInt(
              //                               '8D8D8D')),
              //                           fontFamily: 'Poppins Regular'),
              //                     ),
              //                     SizedBox(
              //                       height: height * 0.001,
              //                     ),
              //                     Text(
              //                       ' Emergency at the house',
              //                       style: TextStyle(
              //                           fontSize: width * 0.02,
              //                           color: Color(Utils.hexStringToHexInt(
              //                               'C4C4C4')),
              //                           fontFamily: 'Poppins Regular'),
              //                     ),
              //                     SizedBox(
              //                       height: height * 0.01,
              //                     )
              //                   ],
              //                 ),
              //               )
              //             ],
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(right: width * 0.02),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 Container(
              //                   width: width * 0.2 - width * 0.06,
              //                   height: height * 0.02,
              //                   decoration: BoxDecoration(
              //                       borderRadius:
              //                       BorderRadius.circular(width * 0.04),
              //                       color: Color(
              //                           Utils.hexStringToHexInt('46D0D9'))),
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Divider(
              //   thickness: 1,
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.only(left: width * 0.06),
              //       child: Text(
              //         'Customer Feedbacks',
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: width * 0.03,
              //             fontFamily: 'Poppins Medium'),
              //       ),
              //     ),
              //   ],
              // ),
              // Container(
              //   margin: EdgeInsets.only(left: width * 0.06),
              //   child: SizedBox(
              //     width: width * 0.09,
              //     child: Divider(
              //       thickness: 3,
              //       color: Color(Utils.hexStringToHexInt('46D0D9')),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.04,
              // ),
              // Container(
              //   margin:
              //   EdgeInsets.only(left: width * 0.06, right: width * 0.03),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         'Sara Blush',
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: width * 0.03,
              //             fontFamily: 'Poppins Medium'),
              //       ),
              //       Row(
              //         children: <Widget>[
              //           RatingBarIndicator(
              //             rating: 2.75,
              //             itemBuilder: (context, index) => const Icon(
              //               Icons.star,
              //               color: Colors.amber,
              //             ),
              //             itemCount: 5,
              //             itemSize: width * 0.05,
              //             direction: Axis.horizontal,
              //           ),
              //           Text(
              //             ' 11/5/21',
              //             style: TextStyle(
              //                 fontFamily: 'Poppins Regular',
              //                 fontSize: width * 0.02,
              //                 color:
              //                 Color(Utils.hexStringToHexInt('C4C4C4'))),
              //           )
              //         ],
              //       ),
              //       SizedBox(
              //         height: height * 0.01,
              //       ),
              //       AutoSizeText(
              //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim facilisi rhoncus, vitae, id convallis eu nisl enim quam. Sed aenean molestie leo venenatis. Aliquet turpis nulla sodales aenean. Bibendum ut egestas massa sit.',
              //         style: TextStyle(
              //             fontSize: width * 0.02,
              //             color: Color(Utils.hexStringToHexInt('#8D8D8D')),
              //             fontFamily: 'Poppins Light'),
              //         maxLines: 5,
              //       ),
              //       SizedBox(
              //         height: height * 0.01,
              //       ),
              //       Divider(
              //         color: Color(Utils.hexStringToHexInt('C4C4C4')),
              //         thickness: 1,
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Container(
              //   margin:
              //   EdgeInsets.only(left: width * 0.06, right: width * 0.03),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         'Sara Blush',
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: width * 0.03,
              //             fontFamily: 'Poppins Medium'),
              //       ),
              //       Row(
              //         children: <Widget>[
              //           RatingBarIndicator(
              //             rating: 2.75,
              //             itemBuilder: (context, index) => const Icon(
              //               Icons.star,
              //               color: Colors.amber,
              //             ),
              //             itemCount: 5,
              //             itemSize: width * 0.05,
              //             direction: Axis.horizontal,
              //           ),
              //           Text(
              //             ' 11/5/21',
              //             style: TextStyle(
              //                 fontFamily: 'Poppins Regular',
              //                 fontSize: width * 0.02,
              //                 color:
              //                 Color(Utils.hexStringToHexInt('C4C4C4'))),
              //           )
              //         ],
              //       ),
              //       SizedBox(
              //         height: height * 0.01,
              //       ),
              //       AutoSizeText(
              //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim facilisi rhoncus, vitae, id convallis eu nisl enim quam. Sed aenean molestie leo venenatis. Aliquet turpis nulla sodales aenean. Bibendum ut egestas massa sit.',
              //         style: TextStyle(
              //             fontSize: width * 0.02,
              //             color: Color(Utils.hexStringToHexInt('#8D8D8D')),
              //             fontFamily: 'Poppins Light'),
              //         maxLines: 5,
              //       ),
              //       SizedBox(
              //         height: height * 0.01,
              //       ),
              //       Divider(
              //         color: Color(Utils.hexStringToHexInt('C4C4C4')),
              //         thickness: 1,
              //       )
              //     ],
              //   ),
              // )
              ],
              )
              ,
              );
            }
            })
        ),
      ),
    );
  }

  void openDiaolog(width, height) {
    Get.bottomSheet(
      Container(
        width: width,
        height: height,
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Container(

              width: width * 0.5,
              height: height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    height: height * 0.2,
                    child: imageFile == null
                        ? Container(
                      width: width * 0.5,
                      height: height * 0.2,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'images/svgicons/profilehoto.png'),
                              fit: BoxFit.contain)),
                    )
                        : Container(
                      width: width * 0.5,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(imageFile),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    top: height * 0.1 + height * 0.04,
                    right: width * 0.06,
                    child: GestureDetector(
                      onTap: () {
                        _showImageChooser(context);
                      },
                      child: Container(
                        width: width * 0.1,
                        height: height * 0.06,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'images/svgicons/circleaddback.png'),
                                fit: BoxFit.fill)),
                        child: Center(
                          child: SvgPicture.asset(
                            'images/svgicons/adddd.svg',
                            width: width * 0.02,
                            height: height * 0.02,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text("Update profile Photo",
                style: TextStyle(
                  color: Color(Utils.hexStringToHexInt('77ACA2')),
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins Medium',
                ),
                textAlign: TextAlign.end),
            SizedBox(
              height: height * 0.1,
            ),
            Utils().titleTextsemibold('Update profile', context),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Text(
                'Please enter the details below to update your profile.',
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
            Container(
              margin: EdgeInsets.only(left: width * 0.08, right: width * 0.08),
              child: Column(
                children: <Widget>[
                  Container(
                    width: width - 5,
                    height: height * 0.1 - height * 0.04,
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                            border: InputBorder.none)),
                  ),
                  Container(
                    width: width - 5,
                    height: height * 0.1 - height * 0.04,
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                            border: InputBorder.none)),
                  ),
                  Container(
                    width: width - 5,
                    height: height * 0.1 - height * 0.04,
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        controller: _phonecontroller,
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                            border: InputBorder.none)),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: width - 5,
                          height: height * 0.1 - height * 0.04,
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                            color: Color(Utils.hexStringToHexInt('F4F4F4')),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                dob == "" ? "Date of birth" : dob,
                                style: TextStyle(
                                    color: Color(
                                        Utils.hexStringToHexInt('A4A4A4')),
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        width: width - 5,
                        height: height * 0.1 - height * 0.04,
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(4)),
                          color: Color(Utils.hexStringToHexInt('F4F4F4')),
                        ),
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                            "${showselectGender == ""
                                ? "Gender"
                                : showselectGender}",
                            style: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                          ),
                          items: _createList(),
                          onChanged: (value) {
                            setState(() {
                              showselectGender = value.toString();
                              if (value == "Male") {
                                genderSelect = "1";
                                print(genderSelect);
                              } else if (value == "Female") {
                                genderSelect = "2";
                                print(genderSelect);
                              }
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            GestureDetector(
              onTap: () {
                CommonDialog.showsnackbar(date);

                // authControlller.registerUser(
                //     imageFile,
                //     _nameController.text.toString(),
                //     emailcontroller.text.toString(),
                //     dob,
                //     showselectGender,
                //     _phonecontroller.text.toString(),
                //     "android",
                //     "sdfsdfsdfsdf");
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
          ],
        ),
      ),
    );
  }

  Future _profileUpdate(BuildContext context, width, height) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text("Profile update"),
            children: <Widget>[
              Container(
                width: width,
                height: height,
                color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Container(

                      width: width * 0.5,
                      height: height * 0.2,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: width * 0.5,
                            height: height * 0.2,
                            child: imageFile == null
                                ? Container(
                              width: width * 0.5,
                              height: height * 0.2,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/svgicons/profilehoto.png'),
                                      fit: BoxFit.contain)),
                            )
                                : Container(
                              width: width * 0.5,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(imageFile),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Positioned(
                            top: height * 0.1 + height * 0.04,
                            right: width * 0.06,
                            child: GestureDetector(
                              onTap: () {
                                _showImageChooser(context);
                              },
                              child: Container(
                                width: width * 0.1,
                                height: height * 0.06,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'images/svgicons/circleaddback.png'),
                                        fit: BoxFit.fill)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'images/svgicons/adddd.svg',
                                    width: width * 0.02,
                                    height: height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text("Update profile Photo",
                        style: TextStyle(
                          color: Color(Utils.hexStringToHexInt('77ACA2')),
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins Medium',
                        ),
                        textAlign: TextAlign.end),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Utils().titleTextsemibold('Update profile', context),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Center(
                      child: Text(
                        'Please enter the details below to update your profile.',
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
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.08, right: width * 0.08),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width - 5,
                            height: height * 0.1 - height * 0.04,
                            padding: const EdgeInsets.only(left: 6),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(4)),
                              color: Color(Utils.hexStringToHexInt('F4F4F4')),
                            ),
                            child: TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                controller: _nameController,
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('A4A4A4')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                    border: InputBorder.none)),
                          ),
                          Container(
                            width: width - 5,
                            height: height * 0.1 - height * 0.04,
                            margin: const EdgeInsets.only(top: 6),
                            padding: const EdgeInsets.only(left: 6),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(4)),
                              color: Color(Utils.hexStringToHexInt('F4F4F4')),
                            ),
                            child: TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                controller: emailcontroller,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('A4A4A4')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                    border: InputBorder.none)),
                          ),
                          Container(
                            width: width - 5,
                            height: height * 0.1 - height * 0.04,
                            margin: const EdgeInsets.only(top: 6),
                            padding: const EdgeInsets.only(left: 6),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(4)),
                              color: Color(Utils.hexStringToHexInt('F4F4F4')),
                            ),
                            child: TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                controller: _phonecontroller,
                                decoration: InputDecoration(
                                    hintText: 'Phone',
                                    hintStyle: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('A4A4A4')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                    border: InputBorder.none)),
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  width: width - 5,
                                  height: height * 0.1 - height * 0.04,
                                  margin: const EdgeInsets.only(top: 6),
                                  padding: const EdgeInsets.only(left: 6),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                    color: Color(
                                        Utils.hexStringToHexInt('F4F4F4')),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        dob == "" ? "Date of birth" : dob,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt(
                                                    'A4A4A4')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.03),
                                      ),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: width - 5,
                                height: height * 0.1 - height * 0.04,
                                margin: const EdgeInsets.only(top: 6),
                                padding: const EdgeInsets.only(left: 6),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                                  color: Color(
                                      Utils.hexStringToHexInt('F4F4F4')),
                                ),
                                child: DropdownButton(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: Text(
                                    "${showselectGender == ""
                                        ? "Gender"
                                        : showselectGender}",
                                    style: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('A4A4A4')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                  ),
                                  items: _createList(),
                                  onChanged: (value) {
                                    setState(() {
                                      showselectGender = value.toString();
                                      if (value == "Male") {
                                        genderSelect = "1";
                                        print(genderSelect);
                                      } else if (value == "Female") {
                                        genderSelect = "2";
                                        print(genderSelect);
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        CommonDialog.showsnackbar(date);

                        // authControlller.registerUser(
                        //     imageFile,
                        //     _nameController.text.toString(),
                        //     emailcontroller.text.toString(),
                        //     dob,
                        //     showselectGender,
                        //     _phonecontroller.text.toString(),
                        //     "android",
                        //     "sdfsdfsdfsdf");
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
                  ],
                ),
              ),
            ],
          );
        }
    );
  }


  AppBar appBarr(BuildContext context, width, height) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(Utils.hexStringToHexInt('46D0D9')),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.05),
            child: Text(' Crossing Republick, Ghaziabad',
                style: TextStyle(
                    fontSize: width * 0.03,
                    fontFamily: 'Poppins Regular',
                    color: Colors.black),
                textAlign: TextAlign.center),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width * 0.03,
                height: height * 0.03,
                child: SvgPicture.asset(
                  "images/svgicons/mappin.svg",
                ),
              ),
              Text(' Crossing Republick, Ghaziabad',
                  style: TextStyle(
                      fontSize: width * 0.02,
                      fontFamily: 'Poppins Regular',
                      color: Colors.black),
                  textAlign: TextAlign.center),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: width * 0.05,
                  color: Colors.black,
                ),
                tooltip: 'Comment Icon',
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        //IconButton
        IconButton(
          iconSize: width * 0.07,
          icon: const Icon(
            CupertinoIcons.bell,
            color: Colors.blue,
          ),
          tooltip: 'Setting Icon',
          onPressed: () {},
        ), //IconButton
      ],
      //<Widget>[]

      elevation: 0.0,
      leading: Builder(
        builder: (context) =>
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              tooltip: 'Menu Icon',
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      ),
      brightness: Brightness.dark,
    );
  }

  Widget updateProfileView(width, height) {
    print("DF SDF SDF SDF SDF SDF SDF SDF SDF 00");
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        child:
        Column(
          children: <Widget>[
            Container(
              width: width * 0.5,
              height: height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    height: height * 0.2,
                    child: imageFile == null
                        ? Container(
                      width: width * 0.5,
                      height: height * 0.2,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'images/svgicons/profilehoto.png'),
                              fit: BoxFit.contain)),
                    )
                        : Container(
                      width: width * 0.5,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(imageFile),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    top: height * 0.1 + height * 0.04,
                    right: width * 0.06,
                    child: GestureDetector(
                      onTap: () {
                        _showImageChooser(context);
                      },
                      child: Container(
                        width: width * 0.1,
                        height: height * 0.06,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'images/svgicons/circleaddback.png'),
                                fit: BoxFit.fill)),
                        child: Center(
                          child: SvgPicture.asset(
                            'images/svgicons/adddd.svg',
                            width: width * 0.02,
                            height: height * 0.02,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text("Update profile Photo",
                style: TextStyle(
                  color: Color(Utils.hexStringToHexInt('77ACA2')),
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins Medium',
                ),
                textAlign: TextAlign.end),
            SizedBox(
              height: height * 0.1,
            ),
            Utils().titleTextsemibold('Update profile', context),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Text(
                'Please enter the details below to update your profile.',
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
            Container(
              margin: EdgeInsets.only(left: width * 0.08, right: width * 0.08),
              child: Column(
                children: <Widget>[
                  Container(
                    width: width - 5,
                    height: height * 0.1 - height * 0.04,
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                            border: InputBorder.none)),
                  ),
                  Container(
                    width: width - 5,
                    height: height * 0.1 - height * 0.04,
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                            border: InputBorder.none)),
                  ),
                  Container(
                    width: width - 5,
                    height: height * 0.1 - height * 0.04,
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Color(Utils.hexStringToHexInt('F4F4F4')),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        controller: _phonecontroller,
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                            border: InputBorder.none)),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: width - 5,
                          height: height * 0.1 - height * 0.04,
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                            color: Color(Utils.hexStringToHexInt('F4F4F4')),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                dob == "" ? "Date of birth" : dob,
                                style: TextStyle(
                                    color: Color(
                                        Utils.hexStringToHexInt('A4A4A4')),
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        width: width - 5,
                        height: height * 0.1 - height * 0.04,
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(4)),
                          color: Color(Utils.hexStringToHexInt('F4F4F4')),
                        ),
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                            "${showselectGender == ""
                                ? "Gender"
                                : showselectGender}",
                            style: TextStyle(
                                color: Color(Utils.hexStringToHexInt('A4A4A4')),
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03),
                          ),
                          items: _createList(),
                          onChanged: (value) {
                            setState(() {
                              showselectGender = value.toString();
                              if (value == "Male") {
                                genderSelect = "1";
                                print(genderSelect);
                              } else if (value == "Female") {
                                genderSelect = "2";
                                print(genderSelect);
                              }
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            GestureDetector(
              onTap: () {
                CommonDialog.showsnackbar(date);

                // authControlller.registerUser(
                //     imageFile,
                //     _nameController.text.toString(),
                //     emailcontroller.text.toString(),
                //     dob,
                //     showselectGender,
                //     _phonecontroller.text.toString(),
                //     "android",
                //     "sdfsdfsdfsdf");
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
          ],
        ),
      ),
    );
  }

  Future _showImageChooser(BuildContext contextt) {
    return showDialog(
        barrierDismissible: false,
        context: contextt,
        builder: (BuildContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: contentBox(context),
          );
        });
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding:
          const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text("Make a choice !",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Libre Baskervillelight',
                    ),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 35,
              ),
              RaisedButton.icon(
                  onPressed: () async {
                    _openGallery(context);
                  },
                  icon: const Icon(
                    Icons.drive_file_move_outline,
                    color: Colors.blue,
                  ),
                  label: const Text('Select from gallery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Libre Baskervillelight',
                      ))),
              const SizedBox(
                height: 15.0,
              ),
              RaisedButton.icon(
                  onPressed: () {
                    _openCame(context);
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.blue,
                  ),
                  label: const Text('Capture from camera',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Libre Baskervillelight',
                      ))),
            ],
          ),
        ),
        Positioned(
            top: 10,
            right: 2.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 10,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SvgPicture.asset(
                      "images/svgicons/002-error.svg",
                      width: 44,
                      height: 44,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  _openCame(BuildContext context) async {
    // ignore: deprecated_member_use
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() async {
      Navigator.of(context).maybePop();
      imageFile = image;
      if (image != null) {
        /*todo---this is for use image rotation stop*/
        File rotatedImage =
        await FlutterExifRotation.rotateAndSaveImage(path: image.path);

        setState(() {
          imageFile = rotatedImage;
        });
      }
    });
  }

  _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    var picture = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);

    if (picture != null) {
      File rotatedImage =
      await FlutterExifRotation.rotateAndSaveImage(path: picture.path);
      setState(() {
        imageFile = rotatedImage;
        print(imageFile);
      });
      Navigator.of(context).maybePop();
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != "") {
      setState(() {
        var outputFormat = DateFormat('yyyy-MM-dd');
        dob = outputFormat.format(selected);
      });
    } else {
      print(selected);
    }
  }
}
