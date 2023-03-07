import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kolacur_admin/controller/dashboard_controller.dart';
import 'package:kolacur_admin/screen/manageslot.dart';
import 'package:kolacur_admin/screen/managestaff.dart';
import 'package:kolacur_admin/screen/notification.dart';
import 'package:kolacur_admin/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allbooking.dart';
import 'sidenavigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashboardController dashboardController = Get.put(DashboardController());
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
   SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      setState(() {
        name = _testValue;
        email = emailValue;
        phone = _phoneValue;
        iamge = _imageValue;
      //  print(name+" "+email+" "+phone+" "+_imageValue);
      });
      // will be null if never previously saved
     // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Future.delayed(Duration(seconds: 2), (){
    //     dashboardController.getDashboardData();
    //   });
    // });

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer:
              SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/svgicons/fullbackpn.png'),
                        fit: BoxFit.fill)),
                child: GetBuilder<DashboardController>(
                    builder: (dashboardController) {
                  if (dashboardController.lodaer) {
                    return Container();
                  } else {
                    return Column(
                      children: <Widget>[
                        customAppBar(context, width, height),
                        Container(
                          margin: EdgeInsets.only(
                              top: width * 0.05,
                              left: width * 0.09,
                              right: width * 0.09),
                          child: CupertinoSearchTextField(
                            padding: EdgeInsets.all(width * 0.03),
                            onChanged: (value) {},
                            onSubmitted: (value) {},
                            backgroundColor: Colors.white,
                            itemSize: 30,
                            borderRadius: BorderRadius.circular(width * 0.06),
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: Color(Utils.hexStringToHexInt('8D8D8D')),
                              size: width * 0.06,
                            ),
                            itemColor: Color(Utils.hexStringToHexInt('8D8D8D')),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.2 - height * 0.08,
                        ),
                        Container(
                          width: width,
                          margin: EdgeInsets.only(left: width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                           Container(
                             width: width,
                             //margin: EdgeInsets.only(left: width*0.03),
                             child: Center(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text(
                                     'Statistics',
                                     style: TextStyle(
                                         fontFamily: 'Poppins Medium',
                                         fontSize:
                                         MediaQuery.of(context).size.height *
                                             0.02,
                                         color: Colors.black),
                                   ),
                                   Row(
                                     children: <Widget>[
                                       Material(
                                         borderRadius:
                                         BorderRadius.circular(width * 0.04),
                                         elevation: 12,
                                         child: Container(
                                           width: width * 0.4+width*0.02,
                                           height: height * 0.1 - height * 0.01,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(
                                                   width * 0.04),
                                               gradient: LinearGradient(
                                                   begin: Alignment.topRight,
                                                   end: Alignment.bottomLeft,
                                                   colors: [
                                                     Color(Utils.hexStringToHexInt(
                                                         '#76cbfb')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#3ac1ca')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#47c3d4')),
                                                   ])),
                                           child: Container(
                                             margin:
                                             EdgeInsets.only(left: width * 0.03),
                                             child: Stack(
                                               children: <Widget>[
                                                 Positioned(
                                                   top: height * 0.01,
                                                   child: Text(
                                                     "2",
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.03,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                                 Positioned(
                                                   top: height * 0.05,
                                                   child: Text(
                                                     'Total Staff ',
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.02 -
                                                             height * 0.003,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                       SizedBox(
                                         width: width * 0.05,
                                       ),
                                       Material(
                                         borderRadius:
                                         BorderRadius.circular(width * 0.04),
                                         elevation: 12,
                                         child: Container(
                                           width: width * 0.4+width*0.02,
                                           height: height * 0.1 - height * 0.01,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(
                                                   width * 0.04),
                                               gradient: LinearGradient(
                                                   begin: Alignment.topRight,
                                                   end: Alignment.bottomLeft,
                                                   colors: [
                                                     Color(Utils.hexStringToHexInt(
                                                         '#0c5eed')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#306ed9')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#3f6dbd')),
                                                   ])),
                                           child: Container(
                                             margin:
                                             EdgeInsets.only(left: width * 0.03),
                                             child: Stack(
                                               children: <Widget>[
                                                 Positioned(
                                                   top: height * 0.01,
                                                   child: Text(
                                                     "5",
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.03,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                                 Positioned(
                                                   top: height * 0.05,
                                                   child: Text(
                                                     'Total Bookings ',
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.02 -
                                                             height * 0.003,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(
                                     height: height * 0.01,
                                   ),
                                   Row(
                                     children: <Widget>[
                                       Material(
                                         borderRadius:
                                         BorderRadius.circular(width * 0.04),
                                         elevation: 12,
                                         child: Container(
                                           width: width * 0.4+width*0.02,
                                           height: height * 0.1 - height * 0.01,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(
                                                   width * 0.04),
                                               gradient: LinearGradient(
                                                   begin: Alignment.topRight,
                                                   end: Alignment.bottomLeft,
                                                   colors: [
                                                     Color(Utils.hexStringToHexInt(
                                                         '#0c5eed')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#306ed9')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#3f6dbd')),
                                                   ])),
                                           child: Container(
                                             margin:
                                             EdgeInsets.only(left: width * 0.03),
                                             child: Stack(
                                               children: <Widget>[
                                                 Positioned(
                                                   top: height * 0.01,
                                                   child: Text(
                                                     "10",
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.03,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                                 Positioned(
                                                   top: height * 0.05,
                                                   child: Text(
                                                     'Open Bookings ',
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.02 -
                                                             height * 0.003,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                       SizedBox(
                                         width: width * 0.05,
                                       ),
                                       Material(
                                         borderRadius:
                                         BorderRadius.circular(width * 0.04),
                                         elevation: 12,
                                         child: Container(
                                           width: width * 0.4+width*0.02,
                                           height: height * 0.1 - height * 0.01,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(
                                                   width * 0.04),
                                               gradient: LinearGradient(
                                                   begin: Alignment.topRight,
                                                   end: Alignment.bottomLeft,
                                                   colors: [
                                                     Color(Utils.hexStringToHexInt(
                                                         '#76cbfb')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#3ac1ca')),
                                                     Color(Utils.hexStringToHexInt(
                                                         '#47c3d4')),
                                                   ])),
                                           child: Container(
                                             margin:
                                             EdgeInsets.only(left: width * 0.03),
                                             child: Stack(
                                               children: <Widget>[
                                                 Positioned(
                                                   top: height * 0.01,
                                                   child: Text("₹ "+
                                                   "500",
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.03,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                                 Positioned(
                                                   top: height * 0.05,
                                                   child: Text(
                                                     'Total Revenue ',
                                                     style: TextStyle(
                                                         fontFamily:
                                                         'Poppins Semibold',
                                                         fontSize:
                                                         MediaQuery.of(context)
                                                             .size
                                                             .height *
                                                             0.02 -
                                                             height * 0.003,
                                                         color: Colors.white),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllBooking()),
                                  );
                                  //  Get.to();
                                },
                                child: Container(
                                  width: width,
                                  margin: EdgeInsets.only(right: width * 0.05),
                                  height: height * 0.2 - height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                  ),
                                  child: Material(
                                    elevation: 6,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(width * 0.03),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: width * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'All Bookings',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins Regular',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'View all bookings here',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins Regular',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.3,
                                                margin: EdgeInsets.only(
                                                    right: width * 0.03),
                                                child: SvgPicture.asset(
                                                  "images/svgicons/allbookingsv.svg",
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.2,
                                                width: width * 0.09,
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Utils.hexStringToHexInt(
                                                            '46D0D9')),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    width *
                                                                        0.03),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    width *
                                                                        0.03))),
                                                child: const Center(
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .right_chevron,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ManageStaff()),
                                  );
                                },
                                child: Container(
                                  width: width,
                                  margin: EdgeInsets.only(right: width * 0.05),
                                  height: height * 0.2 - height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                  ),
                                  child: Material(
                                    elevation: 6,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(width * 0.03),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: width * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Manage Staff',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins Regular',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                          color: Colors.black),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        'Add , Remove or edit information\n about the people working with\n you.',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins Regular',
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.3,
                                                margin: EdgeInsets.only(
                                                    right: width * 0.03),
                                                child: SvgPicture.asset(
                                                  "images/svgicons/allbookingsv.svg",
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.2,
                                                width: width * 0.09,
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Utils.hexStringToHexInt(
                                                            '46D0D9')),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    width *
                                                                        0.03),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    width *
                                                                        0.03))),
                                                child: const Center(
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .right_chevron,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ManageSlotPage()),
                                  );
                                },
                                child: Container(
                                  width: width,
                                  margin: EdgeInsets.only(right: width * 0.05),
                                  height: height * 0.2 - height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                  ),
                                  child: Material(
                                    elevation: 6,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(width * 0.03),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: width * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Manage Time Slots',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins Regular',
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.02 -
                                                              0.001,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'Add / Edit the salon time slots\n according to your convenience.',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins Regular',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.3,
                                                margin: EdgeInsets.only(
                                                    right: width * 0.03),
                                                child: SvgPicture.asset(
                                                  "images/svgicons/manageclock.svg",
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.2,
                                                width: width * 0.09,
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Utils.hexStringToHexInt(
                                                            '46D0D9')),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    width *
                                                                        0.03),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    width *
                                                                        0.03))),
                                                child: const Center(
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .right_chevron,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                })),
          )),
    );
  }

  Widget customAppBar(BuildContext context, width, height) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: 'Menu Icon',
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          Container(
            child: Stack(
              children: [
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     margin: EdgeInsets.only(top: height * 0.02),
                //     child: Text(' Crossing Republick, Ghaziabad',
                //         style: TextStyle(
                //             fontSize: width * 0.03,
                //             fontFamily: 'Poppins Regular',
                //             color: Colors.black),
                //         textAlign: TextAlign.center),
                //   ),
                // ),
                Center(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: height * 0.03, left: width * 0.04),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Container(
                          //   width: width * 0.03,
                          //   height: height * 0.03,
                          //   child: SvgPicture.asset(
                          //     "images/svgicons/mappin.svg",
                          //   ),
                          // ),
                          // Text(' Crossing Republick, Ghaziabad',
                          //     style: TextStyle(
                          //         fontSize: width * 0.02,
                          //         fontFamily: 'Poppins Regular',
                          //         color: Colors.black),
                          //     textAlign: TextAlign.center),
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.keyboard_arrow_down_sharp,
                          //     size: width * 0.05,
                          //     color: Colors.black,
                          //   ),
                          //   tooltip: 'Comment Icon',
                          //   onPressed: () {},
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            iconSize: width * 0.07,
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.white,
            ),
            tooltip: 'Setting Icon',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          )
        ],
      ),
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
        builder: (context) => IconButton(
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
}
