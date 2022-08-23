import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kolacur_admin/controller/employeecontroller.dart';
import 'package:kolacur_admin/utils/CommomDialog.dart';
import 'package:kolacur_admin/utils/Utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _HomePageState();
}

class _HomePageState extends State<ProfilePage> {
  EmployeeController employeeController = Get.put(EmployeeController());
  late int accountStatus;

  @override
  Widget build(BuildContext context) {
    var employee_ID = Get.arguments;
    employeeController.employee_Id.value = employee_ID.toString();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: GetBuilder<EmployeeController>(builder: (employeeController) {
      if (employeeController.lodaer) {
        return Container();
      } else {
        accountStatus = employeeController.employeeListPojo.value.data!.status!;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Color(Utils.hexStringToHexInt('46D0D9')),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.keyboard_backspace_rounded,
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
                SizedBox(
                  width: width * 0.3,
                  height: 14,
                  child: InkWell(
                    onTap: () {
                      if (employeeController
                              .employeeListPojo.value.data!.status ==
                          1) {
                        print("000000000000000000");
                        employeeController.enabeDesable(0, context);
                      } else if (employeeController
                              .employeeListPojo.value.data!.status ==
                          0) {
                        print("111111111111111");
                        employeeController.enabeDesable(1, context);
                      }
                    },
                    child: Center(
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0)),
                        margin: EdgeInsets.only(right: width * 0.01),
                        child: Center(
                          child: Text(
                            employeeController
                                        .employeeListPojo.value.data!.status ==
                                    1
                                ? "Disable Account"
                                : "Enable Account",
                            style: TextStyle(fontSize: 12.0,fontFamily: "Poppins Regular"),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SizedBox(
              width: width,
              height: height,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: width,
                        height: height * 0.7,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'images/svgicons/fullbackpn.png'),
                                fit: BoxFit.fill)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.1 + height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: width * 0.2 - width * 0.06,
                                backgroundImage: NetworkImage(employeeController
                                            .employeeListPojo.value.data!.image
                                            .toString() !=
                                        ""
                                    ? employeeController
                                        .employeeListPojo.value.data!.image
                                        .toString()
                                    : ""),
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
                              Container(
                                margin: EdgeInsets.only(right: width * 0.02),
                                width: width * 0.2,
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.01),
                                    color: Color(
                                        Utils.hexStringToHexInt('#ecfafb'))),
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
                                          color: Color(Utils.hexStringToHexInt(
                                              '46D0D9'))),
                                    )
                                  ],
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
                                color: Color(Utils.hexStringToHexInt('46D0D9')),
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
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.03),
                                    ),
                                    SizedBox(
                                      width: width * 0.06,
                                    ),
                                    Text(
                                      employeeController.employeeListPojo.value
                                                  .data!.name
                                                  .toString() !=
                                              ""
                                          ? employeeController
                                              .employeeListPojo.value.data!.name
                                              .toString()
                                          : "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
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
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.03),
                                    ),
                                    SizedBox(
                                      width: width * 0.06,
                                    ),
                                    Text(
                                      employeeController.employeeListPojo.value
                                                  .data!.email
                                                  .toString() !=
                                              ""
                                          ? " " +
                                              employeeController
                                                  .employeeListPojo
                                                  .value
                                                  .data!
                                                  .email
                                                  .toString()
                                          : "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
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
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.03),
                                    ),
                                    SizedBox(
                                      width: width * 0.04,
                                    ),
                                    Text(
                                      employeeController.employeeListPojo.value
                                                  .data!.phone
                                                  .toString() !=
                                              ""
                                          ? employeeController.employeeListPojo
                                              .value.data!.phone
                                              .toString()
                                          : "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.04),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Skills',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2')),
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.03),
                                    ),
                                    SizedBox(
                                      width: width * 0.06,
                                    ),
                                    SizedBox(
                                      width: width * 0.6,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: employeeController
                                              .employeeListPojo
                                              .value
                                              .data!
                                              .skills!
                                              .length,
                                          itemBuilder: (context, position) {
                                            return Text(
                                              "  . " +
                                                  employeeController
                                                      .employeeListPojo
                                                      .value
                                                      .data!
                                                      .skills![position],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color(
                                                      Utils.hexStringToHexInt(
                                                          'A3A2A2')),
                                                  fontFamily: 'Poppins Regular',
                                                  fontSize: width * 0.04),
                                            );
                                          }),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: width * 0.06),
                                child: Text(
                                  'Leave Management',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.03,
                                      fontFamily: 'Poppins Medium'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: width * 0.02),
                                width: width * 0.2,
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.01),
                                    color: Color(
                                        Utils.hexStringToHexInt('#ecfafb'))),
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
                                          color: Color(Utils.hexStringToHexInt(
                                              '46D0D9'))),
                                    )
                                  ],
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
                                color: Color(Utils.hexStringToHexInt('46D0D9')),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            width: width,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: employeeController.employeeListPojo
                                    .value.data!.leaveManagement!.length,
                                itemBuilder: (context, position) {
                                  print(employeeController
                                      .employeeListPojo.value.data);
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: width * 0.04,
                                        right: width * 0.04,
                                        top: height * 0.02),
                                    child: Material(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.04),
                                      elevation: 6,
                                      child: Container(
                                        width: width,
                                        height: height * 0.2 - height * 0.06,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              width * 0.04),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: width * 0.02),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: height * 0.002,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: width * 0.01),
                                                        width: width * 0.2,
                                                        height: height * 0.03,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        width *
                                                                            0.01),
                                                            color: employeeController
                                                                        .employeeListPojo
                                                                        .value
                                                                        .data!
                                                                        .leaveManagement![
                                                                            position]
                                                                        .holidayType ==
                                                                    "partialy_off"
                                                                ? Color(Utils
                                                                    .hexStringToHexInt(
                                                                        '#fed69b'))
                                                                : Color(Utils
                                                                    .hexStringToHexInt(
                                                                        '#ecfafb'))),
                                                        child: Center(
                                                          child: Text(
                                                            employeeController
                                                                        .employeeListPojo
                                                                        .value
                                                                        .data!
                                                                        .leaveManagement![
                                                                            position]
                                                                        .holidayType ==
                                                                    "partialy_off"
                                                                ? "Partial off"
                                                                : "Full day off",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: employeeController
                                                                            .employeeListPojo
                                                                            .value
                                                                            .data!
                                                                            .leaveManagement![
                                                                                position]
                                                                            .holidayType ==
                                                                        "partialy_off"
                                                                    ? Colors
                                                                        .black
                                                                    : Color(Utils
                                                                        .hexStringToHexInt(
                                                                            '46D0D9')),
                                                                fontFamily:
                                                                    'Poppins Regular',
                                                                fontSize:
                                                                    width *
                                                                        0.02),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Text(
                                                        employeeController
                                                                .employeeListPojo
                                                                .value
                                                                .data!
                                                                .leaveManagement![
                                                                    position]
                                                                .leaveDate
                                                                .toString() +
                                                            "",
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.02,
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
                                                        employeeController
                                                                .employeeListPojo
                                                                .value
                                                                .data!
                                                                .leaveManagement![
                                                                    position]
                                                                .holidayReason
                                                                .toString() +
                                                            "",
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.02,
                                                            color: Color(Utils
                                                                .hexStringToHexInt(
                                                                    'C4C4C4')),
                                                            fontFamily:
                                                                'Poppins Regular'),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      )
                                                    ],
                                                  ),
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
                                                  employeeController
                                                              .employeeListPojo
                                                              .value
                                                              .data!
                                                              .leaveManagement![
                                                                  position]
                                                              .holidayType ==
                                                          "partialy_off"
                                                      ? Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                '${employeeController.employeeListPojo.value.data!.leaveManagement![position].startFrom}-'
                                                                '${employeeController.employeeListPojo.value.data!.leaveManagement![position].endFrom}',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        Utils.hexStringToHexInt(
                                                                            '8D8D8D')),
                                                                    fontFamily:
                                                                        'Poppins Regular',
                                                                    fontSize:
                                                                        width *
                                                                            0.02),
                                                              ),
                                                              Container(
                                                                width: width *
                                                                    0.06,
                                                                height: height *
                                                                    0.06,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        Utils.hexStringToHexInt(
                                                                            '#fed69b'))),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          width: width * 0.2 -
                                                              width * 0.06,
                                                          height: height * 0.02,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          width *
                                                                              0.04),
                                                              color:
                                                                  Colors.black),
                                                        )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: width * 0.06),
                                child: Text(
                                  'Customer Feedbacks',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.03,
                                      fontFamily: 'Poppins Medium'),
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
                                color: Color(Utils.hexStringToHexInt('46D0D9')),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.06, right: width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Sara Blush',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.03,
                                      fontFamily: 'Poppins Medium'),
                                ),
                                Row(
                                  children: <Widget>[
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: width * 0.05,
                                      direction: Axis.horizontal,
                                    ),
                                    Text(
                                      ' 11/5/21',
                                      style: TextStyle(
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.02,
                                          color: Color(Utils.hexStringToHexInt(
                                              'C4C4C4'))),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                AutoSizeText(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim facilisi rhoncus, vitae, id convallis eu nisl enim quam. Sed aenean molestie leo venenatis. Aliquet turpis nulla sodales aenean. Bibendum ut egestas massa sit.',
                                  style: TextStyle(
                                      fontSize: width * 0.02,
                                      color: Color(
                                          Utils.hexStringToHexInt('#8D8D8D')),
                                      fontFamily: 'Poppins Light'),
                                  maxLines: 5,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Divider(
                                  color:
                                      Color(Utils.hexStringToHexInt('C4C4C4')),
                                  thickness: 1,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.06, right: width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Sara Blush',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.03,
                                      fontFamily: 'Poppins Medium'),
                                ),
                                Row(
                                  children: <Widget>[
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: width * 0.05,
                                      direction: Axis.horizontal,
                                    ),
                                    Text(
                                      ' 11/5/21',
                                      style: TextStyle(
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.02,
                                          color: Color(Utils.hexStringToHexInt(
                                              'C4C4C4'))),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                AutoSizeText(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim facilisi rhoncus, vitae, id convallis eu nisl enim quam. Sed aenean molestie leo venenatis. Aliquet turpis nulla sodales aenean. Bibendum ut egestas massa sit.',
                                  style: TextStyle(
                                      fontSize: width * 0.02,
                                      color: Color(
                                          Utils.hexStringToHexInt('#8D8D8D')),
                                      fontFamily: 'Poppins Light'),
                                  maxLines: 5,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Divider(
                                  color:
                                      Color(Utils.hexStringToHexInt('C4C4C4')),
                                  thickness: 1,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ));
      }
    }));
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
