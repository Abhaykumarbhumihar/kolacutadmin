import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kolacur_admin/screen/add_employee.dart';
import 'package:kolacur_admin/screen/profile.dart';
import 'package:kolacur_admin/screen/sidenavigation.dart';
import 'package:kolacur_admin/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/manage_staff_controller.dart';

class ManageStaff extends StatefulWidget {
  const ManageStaff({Key key}) : super(key: key);

  @override
  State<ManageStaff> createState() => _HomePageState();
}

class _HomePageState extends State<ManageStaff> {
  ManageStaffController profileController = Get.put(ManageStaffController());
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
      });
      // will be null if never previously saved
      // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        drawer:
            SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(Utils.hexStringToHexInt('46D0D9')),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: 'Menu Icon',
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text(
            'Manage Staff',
            style: TextStyle(
                fontFamily: 'Poppins Regular',
                color: Colors.white,
                fontSize: width * 0.04),
          ),
          actions: <Widget>[
            // PopupMenuButton(
            //     child: Container(
            //       margin: EdgeInsets.only(right: width * 0.01),
            //       child: SvgPicture.asset(
            //         "images/svgicons/filtersv.svg",
            //       ),
            //     ),
            //     icon: null,
            //     // add this line
            //     itemBuilder: (_) => <PopupMenuItem<String>>[
            //           PopupMenuItem<String>(
            //               child: Container(
            //                   width: 100,
            //                   // height: 30,
            //                   child: const Text(
            //                     "All",
            //                     style: TextStyle(color: Colors.red),
            //                   )),
            //               value: 'All'),
            //           PopupMenuItem<String>(
            //               child: Container(
            //                   width: 100,
            //                   // height: 30,
            //                   child: const Text(
            //                     "Available",
            //                     style: TextStyle(color: Colors.red),
            //                   )),
            //               value: 'Available'),
            //           PopupMenuItem<String>(
            //               child: Container(
            //                   width: 100,
            //                   // height: 30,
            //                   child: const Text(
            //                     "Not Available",
            //                     style: TextStyle(color: Colors.red),
            //                   )),
            //               value: 'Not Available')
            //         ],
            //     onSelected: (index) async {
            //       print(index);
            //       profileController.filterStatus(index);
            //     })
          ],
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddEmployee());
          },
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/svgicons/fullbackpn.png'),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: width * 0.04,
                      left: width * 0.09,
                      right: width * 0.09),
                  child: CupertinoSearchTextField(
                    padding: EdgeInsets.all(width * 0.03),
                    onChanged: (value) {
                      profileController.filterEmplist(value);
                    },
                    onSubmitted: (value) {},
                    backgroundColor: Colors.white,
                    itemSize: 30,
                    borderRadius: BorderRadius.circular(width * 0.06),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Color(Utils.hexStringToHexInt('8D8D8D')),
                    ),
                    itemColor: Color(Utils.hexStringToHexInt('8D8D8D')),
                  ),
                ),
                SizedBox(
                  height: height * 0.1 + height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        'Total :${profileController.staffDetail.length}',
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('8D8D8D')),
                            fontSize: width * 0.03,
                            fontFamily: 'Poppins Regular'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                GetBuilder<ManageStaffController>(builder: (profileController) {
                  if (profileController.lodaer) {
                    return Container();
                  } else {
                    return SizedBox(
                      width: width,
                      height: height * 0.6,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: profileController.staffDetail.length,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(ProfilePage(),
                                    arguments: profileController
                                        .staffDetail[position].id);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.04,
                                    right: width * 0.04,
                                    top: 2,
                                    bottom: 2),
                                child: Material(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.02),
                                  elevation: 2,
                                  shadowColor: Colors.white,
                                  child: Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(width * 0.04),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topCenter,
                                              margin: EdgeInsets.only(
                                                  left: width * 0.03,
                                                  right: width * 0.01,
                                                  top: height * 0.01),
                                              child: CircleAvatar(
                                                radius: width * 0.07,
                                                backgroundImage: NetworkImage(
                                                    profileController
                                                                .staffDetail[
                                                                    position]
                                                                .profile_image
                                                                .toString() !=
                                                            ""
                                                        ? profileController
                                                            .staffDetail[
                                                                position]
                                                            .profile_image
                                                            .toString()
                                                        : "N/A"),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: height * 0.004,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Utils().titleText(
                                                        profileController
                                                                    .staffDetail[
                                                                        position]
                                                                    .name
                                                                    .toString() !=
                                                                ""
                                                            ? profileController
                                                                .staffDetail[
                                                                    position]
                                                                .name
                                                                .toString()
                                                            : "N/A",
                                                        context),
                                                    // Container(
                                                    //   margin: EdgeInsets.only(
                                                    //       left: width * 0.01),
                                                    //   width: width * 0.2,
                                                    //   height: height * 0.03,
                                                    //   decoration: BoxDecoration(
                                                    //       borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(
                                                    //                   width *
                                                    //                       0.01),
                                                    //       color: Color(Utils
                                                    //           .hexStringToHexInt(
                                                    //               '#ecfafb'))),
                                                    //   child: Center(
                                                    //     child: Text(
                                                    //       '55Available',
                                                    //       textAlign:
                                                    //           TextAlign.center,
                                                    //       style: TextStyle(
                                                    //           color: Color(Utils
                                                    //               .hexStringToHexInt(
                                                    //                   '46D0D9')),
                                                    //           fontFamily:
                                                    //               'Poppins Regular',
                                                    //           fontSize:
                                                    //               width * 0.02),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                Text(
                                                  profileController
                                                              .staffDetail[
                                                                  position]
                                                              .experience
                                                              .toString() !=
                                                          ""
                                                      ? profileController
                                                          .staffDetail[
                                                              position]
                                                          .experience
                                                          .toString()
                                                      : "N/A",
                                                  style: TextStyle(
                                                      fontSize: width * 0.02,
                                                      color: Color(Utils
                                                          .hexStringToHexInt(
                                                              '8D8D8D')),
                                                      fontFamily:
                                                          'Poppins Regular'),
                                                ),
                                                SizedBox(
                                                  height: height * 0.001,
                                                ),
                                                Text(
                                                  profileController
                                                              .staffDetail[
                                                                  position]
                                                              .email
                                                              .toString() !=
                                                          ""
                                                      ? " " +
                                                          profileController
                                                              .staffDetail[
                                                                  position]
                                                              .email
                                                              .toString()
                                                      : "N/A",
                                                  style: TextStyle(
                                                      fontSize: width * 0.02,
                                                      color: Color(Utils
                                                          .hexStringToHexInt(
                                                              'C4C4C4')),
                                                      fontFamily:
                                                          'Poppins Regular'),
                                                ),
                                                Text(
                                                  profileController
                                                              .staffDetail[
                                                                  position]
                                                              .phone
                                                              .toString() !=
                                                          ""
                                                      ? " " +
                                                          profileController
                                                              .staffDetail[
                                                                  position]
                                                              .phone
                                                              .toString()
                                                      : "N/A",
                                                  style: TextStyle(
                                                      fontSize: width * 0.02,
                                                      color: Color(Utils
                                                          .hexStringToHexInt(
                                                              'C4C4C4')),
                                                      fontFamily:
                                                          'Poppins Regular'),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: width * 0.01),
                                                  width: width * 0.2,
                                                  height: height * 0.03,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width * 0.01),
                                                      color: Color(Utils
                                                          .hexStringToHexInt(
                                                              '#ecfafb'))),
                                                  child: Center(
                                                    child: Text(
                                                      '${profileController
                                                          .staffDetail[
                                                      position]
                                                          .isDuty
                                                          .toString()}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color(Utils
                                                              .hexStringToHexInt(
                                                                  '46D0D9')),
                                                          fontFamily:
                                                              'Poppins Regular',
                                                          fontSize:
                                                              width * 0.02),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: width * 0.02),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${profileController.staffDetail[position].rating.toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: width * 0.03,
                                                    fontFamily:
                                                        'Poppins Medium'),
                                              ),
                                              Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: width * 0.01,
                                                    fontFamily:
                                                        'Poppins Medium'),
                                              ),
                                              RatingBarIndicator(
                                                rating: profileController
                                                    .staffDetail[position]
                                                    .rating
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: width * 0.03,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }),
                SizedBox(
                  height: height * 0.04,
                )
              ],
            ),
          ),
        ),
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
