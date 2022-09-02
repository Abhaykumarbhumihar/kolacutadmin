import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kolacur_admin/utils/Utils.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/manageslot_controller.dart';
import 'sidenavigation.dart';

class ManageSlotPage extends StatefulWidget {
  const ManageSlotPage({Key? key}) : super(key: key);

  @override
  State<ManageSlotPage> createState() => _HomePageState();
}

class DayManage {
  bool isCheck = false;
  String dayanme = "";

  DayManage(this.isCheck, this.dayanme);
}

class _HomePageState extends State<ManageSlotPage> {
  ManageSlotController addSlotcontroller = Get.put(ManageSlotController());
  int _currentValue = 3;
  String pickerValue = "";
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  List<DayManage> daylist = [];
  DateTime selectedDate = DateTime.now();
  String date = "";
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  var session = "";
  late SharedPreferences sharedPreferences;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  TimeOfDay openingTime = TimeOfDay.now();
  TimeOfDay closingTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: openingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != openingTime) {
      setState(() {
        openingTime = timeOfDay;
        opent =
            "${openingTime.hour}:${openingTime.minute}:${openingTime.period.toString().split('.')[1].toString()}";
      });
    }
  }

  _closingTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != closingTime) {
      setState(() {
        closingTime = timeOfDay;
        closet =
            "${closingTime.hour}:${closingTime.minute}:${closingTime.period.toString().split('.')[1].toString()}";
      });
    }
  }

  void _duratin(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            // You need this, notice the parameters below:
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: width,
                height: height * 0.4,
                child: Column(
                  children: [
                    Column(
                      children: [
                        NumberPicker(
                          value: _currentValue,
                          minValue: 0,
                          maxValue: 1000,
                          onChanged: (value) {
                            setState(() {
                              _currentValue = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  pickerValue = _currentValue.toString();
                                });
                                print(_currentValue);
                                print(_currentValue);
                                print(_currentValue);
                                // addSlotcontroller.updateCurrentValue(_currentValue);
                                Get.back();
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                        SizedBox(height: 10),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  _selectclosingDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(selectedDate.year - 1),
      lastDate: DateTime(2050),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  var opent = "";
  var closet = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    daylist.add(DayManage(false, "Mon"));
    daylist.add(DayManage(false, "TUE"));
    daylist.add(DayManage(false, "WED"));
    daylist.add(DayManage(false, "THU"));
    daylist.add(DayManage(false, "FRI"));
    daylist.add(DayManage(false, "SAT"));
    daylist.add(DayManage(false, "SUN"));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      var _session = sharedPreferences.getString("session");
      setState(() {
        session = _session!;
        name = _testValue!;
        email = emailValue!;
        phone = _phoneValue!;
        iamge = _imageValue!;
      });
      // will be null if never previously saved
      // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer:
            SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
        resizeToAvoidBottomInset: true,
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
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          titleSpacing: 0,
          title: Text(
            'Manage Slots',
            style: TextStyle(
                fontFamily: 'Poppins Regular',
                color: Colors.white,
                fontSize: width * 0.04),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
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
                SizedBox(
                  height: height * 0.04,
                ),
                Center(
                  child: Text(
                    'Configure the Slots for your salon just by \nfilling the details given below',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins Regular',
                        fontSize: width * 0.03),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        'Salon Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.03,
                            fontFamily: 'Poppins Medium'),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: width * 0.02),
                    //   width: width * 0.2,
                    //   height: height * 0.03,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(width * 0.01),
                    //       color: Color(Utils.hexStringToHexInt('#ecfafb'))),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Center(
                    //         child: SvgPicture.asset(
                    //           "images/svgicons/modify.svg",
                    //         ),
                    //       ),
                    //       Text(
                    //         'Modify',
                    //         style: TextStyle(
                    //             fontSize: width * 0.02,
                    //             fontFamily: 'Poppins Regular',
                    //             color:
                    //                 Color(Utils.hexStringToHexInt('46D0D9'))),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        'Salon booking acceptance hours',
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('5E5E5E')),
                            fontSize: width * 0.03,
                            fontFamily: 'Poppins Medium'),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: width * 0.02),
                    //   width: width * 0.2,
                    //   height: height * 0.03,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(width * 0.01),
                    //       color: Color(Utils.hexStringToHexInt('#ecfafb'))),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Center(
                    //         child: SvgPicture.asset(
                    //           "images/svgicons/modify.svg",
                    //         ),
                    //       ),
                    //       Text(
                    //         'Modify',
                    //         style: TextStyle(
                    //             fontSize: width * 0.02,
                    //             fontFamily: 'Poppins Regular',
                    //             color:
                    //                 Color(Utils.hexStringToHexInt('46D0D9'))),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.06),
                  padding: EdgeInsets.all(
                    width * 0.01,
                  ),
                  width: width * 0.5 + width * 0.03,
                  height: height * 0.1 - height * .03,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      border: Border.all(
                          width: 1,
                          color: Color(Utils.hexStringToHexInt('5E5E5E')))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Same Everyday',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.03,
                            fontFamily: 'Poppins Medium'),
                      ),
                      Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeTrackColor:
                            Color(Utils.hexStringToHexInt('46D0D9')),
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.blueAccent[100],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.06),
                  child: SizedBox(
                    width: width,
                    height: height * 0.08,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: daylist.length,
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (daylist[position].isCheck) {
                                  daylist[position].isCheck = false;
                                } else {
                                  daylist[position].isCheck = true;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width * 0.01),
                              alignment: Alignment.center,
                              height: width * 0.04,
                              width: height * 0.04,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: daylist[position].isCheck == false
                                      ? Colors.grey
                                      : Color(
                                          Utils.hexStringToHexInt('46D0D9'))),
                              child: Text(
                                daylist[position].dayanme,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.02,
                                    fontFamily: 'Poppins Regular'),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.06, right: width * 0.02),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(width * 0.003),
                              alignment: Alignment.center,
                              width: width * 0.1 + width * 0.06,
                              height: height * 0.05,
                              margin: EdgeInsets.only(right: width * 0.01),
                              decoration: BoxDecoration(
                                  color:
                                      Color(Utils.hexStringToHexInt('E5E5E5')),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                "${openingTime.hour}:${openingTime.minute}",
                                style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Colors.black,
                                    fontFamily: 'Poppins Regular'),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'AM',
                                style: TextStyle(
                                    color: openingTime.period
                                                .toString()
                                                .split('.')[1] ==
                                            "am"
                                        ? Color(
                                            Utils.hexStringToHexInt('46D0D9'))
                                        : Colors.black,
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                'PM',
                                style: TextStyle(
                                    color: openingTime.period
                                                .toString()
                                                .split('.')[1] ==
                                            "pm"
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                      height: height * 0.02,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _closingTime(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(width * 0.003),
                              alignment: Alignment.center,
                              width: width * 0.1 + width * 0.06,
                              height: height * 0.05,
                              margin: EdgeInsets.only(right: width * 0.01),
                              decoration: BoxDecoration(
                                  color:
                                      Color(Utils.hexStringToHexInt('E5E5E5')),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                "${closingTime.hour}:${closingTime.minute}",
                                style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Colors.black,
                                    fontFamily: 'Poppins Regular'),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'AM',
                                style: TextStyle(
                                    color: closingTime.period
                                                .toString()
                                                .split('.')[1] ==
                                            "am"
                                        ? Color(
                                            Utils.hexStringToHexInt('46D0D9'))
                                        : Colors.black,
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                'PM',
                                style: TextStyle(
                                    color: closingTime.period
                                                .toString()
                                                .split('.')[1] ==
                                            "pm"
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.only(left: width * 0.06),
                //       child: Text(
                //         'Duration of slots',
                //         style: TextStyle(
                //             color: Color(Utils.hexStringToHexInt('5E5E5E')),
                //             fontSize: width * 0.03,
                //             fontFamily: 'Poppins Medium'),
                //       ),
                //     ),
                //     // Container(
                //     //   margin: EdgeInsets.only(right: width * 0.02),
                //     //   width: width * 0.2,
                //     //   height: height * 0.03,
                //     //   decoration: BoxDecoration(
                //     //       borderRadius: BorderRadius.circular(width * 0.01),
                //     //       color: Color(Utils.hexStringToHexInt('#ecfafb'))),
                //     //   child: Row(
                //     //     mainAxisAlignment: MainAxisAlignment.center,
                //     //     children: <Widget>[
                //     //       Center(
                //     //         child: SvgPicture.asset(
                //     //           "images/svgicons/modify.svg",
                //     //         ),
                //     //       ),
                //     //       Text(
                //     //         'Modify',
                //     //         style: TextStyle(
                //     //             fontSize: width * 0.02,
                //     //             fontFamily: 'Poppins Regular',
                //     //             color:
                //     //                 Color(Utils.hexStringToHexInt('46D0D9'))),
                //     //       )
                //     //     ],
                //     //   ),
                //     // ),
                //   ],
                // ),
                // SizedBox(
                //   height: height * 0.01,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     _duratin(context);
                //
                //   },
                //   child: Container(
                //     margin: EdgeInsets.only(left: width * 0.06),
                //     padding: EdgeInsets.only(
                //       left: width * 0.01,
                //     ),
                //     width: width * 0.2,
                //     height: height * 0.1 - height * .06,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(width * 0.02),
                //         border: Border.all(
                //             width: 1,
                //             color: Color(Utils.hexStringToHexInt('5E5E5E')))),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         Text(
                //           '${pickerValue} min',
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontSize: width * 0.03,
                //               fontFamily: 'Poppins Medium'),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: height * 0.03,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        'Salon will be closed on',
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('5E5E5E')),
                            fontSize: width * 0.03,
                            fontFamily: 'Poppins Medium'),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: width * 0.02),
                    //   width: width * 0.2,
                    //   height: height * 0.03,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(width * 0.01),
                    //       color: Color(Utils.hexStringToHexInt('#ecfafb'))),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Center(
                    //         child: SvgPicture.asset(
                    //           "images/svgicons/modify.svg",
                    //         ),
                    //       ),
                    //       Text(
                    //         'Modify',
                    //         style: TextStyle(
                    //             fontSize: width * 0.02,
                    //             fontFamily: 'Poppins Regular',
                    //             color:
                    //                 Color(Utils.hexStringToHexInt('46D0D9'))),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    _selectclosingDate(context);
                    date =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: width * 0.06),
                    padding: EdgeInsets.only(
                      left: width * 0.01,
                    ),
                    width: width * 0.3,
                    height: height * 0.1 - height * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        border: Border.all(
                            width: 1,
                            color: Color(Utils.hexStringToHexInt('5E5E5E')))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          date != "" ? "${date}" : "dd/mm/yyyy",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.03,
                              fontFamily: 'Poppins Medium'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        addSlot();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: width * 0.4,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            color: Color(Utils.hexStringToHexInt('46D0D9'))),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins Semibold',
                                fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
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

  void addSlot() {
    var selectedday = "";
    for (var i = 0; i < daylist.length; i++) {
      if (daylist[i].isCheck) {
        selectedday = daylist[i].dayanme + "," + selectedday;
      }
    }
    print(selectedday);
    addSlotcontroller.addSlot(
        session, "slot_type", "1", selectedday.toString(), opent, closet);
  }
}
