import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/shopdetain_controller.dart';
import '../model/ShopDetailPojo.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import 'orderdetail.dart';

class SaloonDetail extends StatefulWidget {
  var id = 0;

  SaloonDetail(int i, {Key? key}) : super(key: key) {
    this.id = i;
  }

  @override
  State<SaloonDetail> createState() => _SaloonDetailState(id);
}

class _SaloonDetailState extends State<SaloonDetail> {
  var shopid = 0;

  _SaloonDetailState(int id) {
    this.shopid = id;
  }

  var slotSelected = "";
  var timeSelected = "";
  var selectEmployeeId = "";
  var selectDate = "";
  var selectDay = "";
  int isSelected =
      1; // changed bool to int and set value to -1 on first time if you don't select anything otherwise set 0 to set first one as selected.

  _isSelected(int index) {
    //pass the selected index to here and set to 'isSelected'
    setState(() {
      isSelected = index;
    });
  }

  ShopDetailController salonControlller = Get.put(ShopDetailController());
  bool valuefirst = false;
  var time = 0;

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  final List<DateTime> days = [];
  List<SamleClass> data = [];

  List<String> userChecked = [];
  List<ServiceService> tempArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final today = DateTime.now();
    final monthAgo = DateTime(today.year, today.month - 1, today.day);
    for (int i = 0; i <= today.difference(monthAgo).inDays; i++) {
      days.add(monthAgo.add(Duration(days: i)));
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      salonControlller.getShopDetail(shopid.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(shopid);
    salonControlller.shopId.value = shopid.toString();
    // for(int i=0;i<=days.length;i++){
    //  // debugPrint(days[i].day.toString()+"  "+days[i].month.toString()+" "+days[i].year.toString());
    //   debugPrint(DateFormat.E().format(days[i]));
    // }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   salonControlller.getShopDetail("0EX03NjgPziSlCcTiZdxAi1c3aT1r1SA",shopid.toString());
    //
    // });
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<ShopDetailController>(builder: (salonControlller) {
        if (salonControlller.lodaer) {
          return Container();
        } else {
          var a = salonControlller.shopDetailpojo.value.data;
          salonControlller.isFavourite = a!.isFavorite!;
          print("${a.isFavorite.toString()}" + "sdfsdfsdfsd");
          return Container(
            width: width,
            height: height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width,
                    height: height * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                            image: NetworkImage(
                              a.logo.toString(),
                            ),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.all(width * 0.05),
                                width: width * 0.1,
                                height: height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'images/svgicons/whitecircle.png'),
                                  ),
                                ),
                                child: Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    salonControlller.addRemoveFavourite(shopid);
                                    //   print( salonControlller.isFavourite);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(width * 0.05),
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'images/svgicons/whitecircle.png'),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        salonControlller.isFavourite == 1
                                            ? CupertinoIcons.heart_fill
                                            : CupertinoIcons.heart,
                                        color: salonControlller.isFavourite == 1
                                            ? Colors.red
                                            : Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Share.share(
                                        'check out my website https://example.com',
                                        subject: 'Look what I made!');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(width * 0.05),
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'images/svgicons/whitecircle.png'),
                                      ),
                                    ),
                                    child: Icon(
                                      CupertinoIcons
                                          .arrowshape_turn_up_right_fill,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const SizedBox(width: 12.0),
                            GestureDetector(
                              onTap: () {
                                //	30°44.177' N	76°47.304' E
                                openMap(context, 123456.0, 12345678.0);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 6, left: 6, right: 6),
                                width: width * 0.3,
                                height: height * 0.06,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Center(
                                  child: Text(
                                    'View on map',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(
                                          Utils.hexStringToHexInt('5E5E5E'),
                                        ),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //name,address,ownerimage,ownername
                  profiledes(
                      context,
                      width,
                      height,
                      a.name.toString(),
                      a.address.toString(),
                      a.ownerProfileImage.toString(),
                      a.ownerName.toString(),
                      a.services),
                  Divider(
                    thickness: 2,
                    color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  description(context, width, height, a.description.toString(),
                      a.amenties.toString(), a.timeSlot),
                  Divider(
                    thickness: 2,
                    color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
/*Todo-----best offer view*/
                  bestoffer(context),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.16,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          return Container(
                            width: width * 0.4 + width * 0.05,
                            height: height * 0.12,
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      ' Upto 50% Off',
                                      style: TextStyle(
                                          fontFamily: 'Poppins Regular',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '  Upto 50% off via UPI',
                                      style: TextStyle(
                                          fontFamily: 'Poppins Light',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          color: Color(Utils.hexStringToHexInt(
                                              'A4A4A4'))),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '  Use Code ',
                                      style: TextStyle(
                                          fontFamily: 'Poppins Light',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          color: Color(Utils.hexStringToHexInt(
                                              'A4A4A4'))),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 10.0),
                                      color: Color(
                                          Utils.hexStringToHexInt('#46D0D9')),
                                      child: Text(
                                        'UPI50',
                                        style: TextStyle(
                                          fontFamily: 'Poppins Light',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Divider(
                    thickness: 2,
                    color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  seeall(context),

                  Container(
                    width: width,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6.0,
                      shrinkWrap: true,
                      primary: true,
                      physics: new NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10.0,
                      children: List.generate(
                        a.services!.length,
                        (index) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                        vertical: 100.0,
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Select your services ",
                                            style: TextStyle(
                                                fontSize: width * 0.03),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: Icon(Icons.cancel_outlined),
                                          ),
                                        ],
                                      ),
                                      content: StatefulBuilder(
                                        // You need this, notice the parameters below:
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return Container(
                                            width: width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: a
                                                          .services![index]
                                                          .service!
                                                          .length,
                                                      itemBuilder:
                                                          (context, position) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (tempArray.contains(a
                                                                      .services![
                                                                          index]
                                                                      .service![
                                                                  position])) {
                                                                print(
                                                                    "SDF SDF SDF DSF ");
                                                                tempArray.remove(a
                                                                        .services![
                                                                            index]
                                                                        .service![
                                                                    position]);
                                                              } else {
                                                                print(
                                                                    "sdfsdfsdfsdfsdfsd ");
                                                                tempArray.add(a
                                                                        .services![
                                                                            index]
                                                                        .service![
                                                                    position]);
                                                              }

                                                              for (var i = 0;
                                                                  i <
                                                                      tempArray
                                                                          .length;
                                                                  i++) {


                                                                print(tempArray[
                                                                            i]
                                                                        .name
                                                                        .toString() +
                                                                    "  " +
                                                                    tempArray[i]
                                                                        .price
                                                                        .toString());
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 6.0,
                                                                    right: 6.0,
                                                                    top: 2.0,
                                                                    bottom:
                                                                        1.0),
                                                            child: Card(
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            4.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          a.services![index].service![position]
                                                                              .name
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: width * 0.03,
                                                                              fontFamily: "Poppins Semibold",
                                                                              color: Colors.black),
                                                                        ),
                                                                        Text("Price: " + a.services![index].service![position].price.toString(),
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                fontFamily: "Poppins Semibold",
                                                                                color: Colors.black)),
                                                                        Text("Time :" + a.services![index].service![position].time.toString(),
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                fontFamily: "Poppins Semibold",
                                                                                color: Colors.black))
                                                                      ],
                                                                    ),
                                                                    Icon(tempArray.contains(a.services![index].service![
                                                                            position])
                                                                        ? Icons
                                                                            .remove_circle_outline
                                                                        : Icons
                                                                            .add),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                //   height: height*0.2-height*0.03,
                                margin: EdgeInsets.only(
                                    left: width * 0.004, right: width * 0.004),
                                width: width * 0.3 + width * 0.01,
                                child: Column(
                                  children: <Widget>[
                                    Material(
                                      elevation: 12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child: Container(
                                        width: width * 0.3 + width * 0.01,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 2.0,
                                                        color: Color(Utils
                                                            .hexStringToHexInt(
                                                                '#77ACA2'))),
                                                    left: BorderSide(
                                                        width: 2.0,
                                                        color: Color(Utils
                                                            .hexStringToHexInt(
                                                                '#77ACA2'))),
                                                    right: BorderSide(
                                                        width: 2.0,
                                                        color: Color(Utils
                                                            .hexStringToHexInt(
                                                                '#77ACA2'))),
                                                    bottom: BorderSide(
                                                        width: 2.0,
                                                        color: Color(Utils
                                                            .hexStringToHexInt(
                                                                '#77ACA2'))),
                                                  ),
                                                ),
                                                child: Checkbox(
                                                    value: valuefirst,
                                                    checkColor: Color(
                                                        Utils.hexStringToHexInt(
                                                            '#77ACA2')),
                                                    //  activeColor: Colors.white,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        valuefirst = value!;
                                                        debugPrint(valuefirst
                                                                .toString() +
                                                            "sfsdfsdfsdfsdf");
                                                      });
                                                    }),
                                                width: 14,
                                                height: 14),
                                            Center(
                                                child: Image.asset(
                                              'images/svgicons/hairdressing.png',
                                              width: 24,
                                              height: 24,
                                            )),
                                            SizedBox(
                                              height: height * 0.008,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.003,
                                    ),
                                    Center(
                                      child: Text(
                                        a.services![index].serviceTitle
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Poppins Regular',
                                            color: Colors.black,
                                            fontSize: width * 0.03),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 2,
                    color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  ),
                  seeallbarbaer(context),

                  Container(
                    height: a.emploeyee!.length > 0
                        ? height * 0.3 + height * 0.03
                        : 0.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        //customerRegList == null ? 0 : customerRegList.length
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            a.emploeyee == null ? 0 : a.emploeyee!.length,
                        itemBuilder: (context, position) {
                          print(a.emploeyee!.length);
                          return GestureDetector(
                            onTap: () {
                              _isSelected(position);
                              selectEmployeeId =
                                  a.emploeyee![position].id.toString();
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 12, left: width * 0.02),
                                  child: Card(
                                    elevation: 20,
                                    child: Container(
                                      width: width * 0.4 + width * 0.04,
                                      //   height: height * 0.4 - height * 0.04,
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          bottom: height * 0.02),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 12,
                                          ),
                                          CircleAvatar(
                                            radius: width * 0.1 + width * 0.03,
                                            backgroundColor: Colors.yellow,
                                            child: CircleAvatar(
                                              radius:
                                                  width * 0.1 + width * 0.02,
                                              backgroundImage: NetworkImage(a
                                                  .emploeyee![position]
                                                  .profileImage
                                                  .toString()),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            a.emploeyee![position].name
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontFamily: 'Poppins Regular'),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            a.emploeyee![position].experience
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(
                                                    Utils.hexStringToHexInt(
                                                        '8D8D8D')),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                fontFamily: 'Poppins Regular'),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          // RatingBarIndicator(
                                          //   rating: 2.75,
                                          //   itemBuilder: (context, index) =>
                                          //       Icon(
                                          //     Icons.star,
                                          //     color: Colors.amber,
                                          //   ),
                                          //   itemCount: 5,
                                          //   itemSize: 18.0,
                                          //   direction: Axis.horizontal,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // isSelected != null &&
                                //                         //         isSelected ==
                                //                         //             position
                                Visibility(
                                    visible: isSelected != null &&
                                            isSelected == position
                                        ? true
                                        : false,
                                    child: Positioned(
                                        right: 10,
                                        top: 1.0,
                                        child: Container(
                                          width: 34,
                                          height: 34,
                                          color: Colors.white,
                                          child: Image.asset(
                                            'images/svgicons/circletick.png',
                                          ),
                                        ))),
                              ],
                            ),
                          );
                        }),
                  ),

                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    thickness: 2,
                    color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  chooseyourslot(context),
/*Todo--- Calendar  list*/

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DatePicker(
                        DateTime.now(),
                        height: 100,
                        daysCount: 30,
                        initialSelectedDate: DateTime.now(),
                        selectionColor:
                            Color(Utils.hexStringToHexInt('77ACA2')),
                        selectedTextColor: Colors.black,
                        monthTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.03,
                          fontFamily: 'Poppins Medium',
                        ),
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            selectDate = date.day.toString() +
                                "-" +
                                date.month.toString() +
                                "-" +
                                date.year.toString();
                            selectDay = date.day.toString();
                            if (date.weekday.toString() == "1") {
                              selectDay = "Monday";
                            } else if (date.weekday.toString() == "2") {
                              selectDay = "Tuesday";
                            } else if (date.weekday.toString() == "3") {
                              selectDay = "Wednesday";
                            } else if (date.weekday.toString() == "4") {
                              selectDay = "Thrusday";
                            } else if (date.weekday.toString() == "5") {
                              selectDay = "Friday";
                            } else if (date.weekday.toString() == "6") {
                              selectDay = "Saturday";
                            } else if (date.weekday.toString() == "7") {
                              selectDay = "Sunday";
                            }

                            print(selectDay);
                            // _selectedValue = date;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    ' Morning',
                    style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        color: Color(Utils.hexStringToHexInt('#A3A2A2')),
                        fontSize: width * 0.04),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      slotSelected = "Morning";
                      timeSelected = "10:00 AM - 12:00 PM";
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width * 0.02),
                      padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                          top: width * 0.02,
                          bottom: width * 0.02),
                      decoration: BoxDecoration(
                          border: Border.all(
                              //color: Color(Utils.hexStringToHexInt('#8D8D8D')),
                              color: Color(Utils.hexStringToHexInt('#8D8D8D')),
                              width: 1)),
                      child: Text(
                        '10:00 AM - 12:00 PM',
                        style: TextStyle(
                            fontSize: width * 0.03,
                            color: Color(Utils.hexStringToHexInt('#8D8D8D'))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    ' Afternoon',
                    style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        color: Color(Utils.hexStringToHexInt('#A3A2A2')),
                        fontSize: width * 0.04),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        InkWell(
                          onTap: () {
                            slotSelected = "Afternoon";
                            timeSelected = "10:00 AM - 12:00 PM";
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: width * 0.02),
                            padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                                top: width * 0.02,
                                bottom: width * 0.02),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(
                                        Utils.hexStringToHexInt('#8D8D8D')),
                                    width: 1)),
                            child: Text(
                              '10:00 AM - 12:00 PM',
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Color(
                                      Utils.hexStringToHexInt('#8D8D8D'))),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              slotSelected = "Afternoon";
                              timeSelected = "10:00 AM - 12:00 PM";
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: width * 0.01),
                              padding: EdgeInsets.only(
                                  left: width * 0.02,
                                  right: width * 0.02,
                                  top: width * 0.02,
                                  bottom: width * 0.02),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(
                                          Utils.hexStringToHexInt('#8D8D8D')),
                                      width: 1)),
                              child: Text(
                                '10:00 AM - 12:00 PM',
                                style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Color(
                                        Utils.hexStringToHexInt('#8D8D8D'))),
                              )),
                        ),
                      ])),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    ' Evening',
                    style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        color: Color(Utils.hexStringToHexInt('#A3A2A2')),
                        fontSize: width * 0.04),
                  ),
                  SizedBox(
                    height: 6,
                  ),

                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        InkWell(
                          onTap: () {
                            slotSelected = "Evening";
                            timeSelected = "10:00 AM - 12:00 PM";
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: width * 0.02),
                              padding: EdgeInsets.only(
                                  left: width * 0.02,
                                  right: width * 0.02,
                                  top: width * 0.02,
                                  bottom: width * 0.02),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(
                                          Utils.hexStringToHexInt('#8D8D8D')),
                                      width: 1)),
                              child: Text(
                                '10:00 AM - 12:00 PM',
                                style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Color(
                                        Utils.hexStringToHexInt('#8D8D8D'))),
                              )),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: width * 0.01),
                            padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                                top: width * 0.02,
                                bottom: width * 0.02),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(
                                        Utils.hexStringToHexInt('#8D8D8D')),
                                    width: 1)),
                            child: Text(
                              '10:00 AM - 12:00 PM',
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Color(
                                      Utils.hexStringToHexInt('#8D8D8D'))),
                            )),
                      ])),

                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                        width: width,
                        height: height * 0.1 + height * 0.05,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                if (tempArray.isEmpty) {
                                  CommonDialog.showsnackbar(
                                      "Please select your services");
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetail(
                                            tempArray,
                                            a,
                                            selectEmployeeId.toString() + "",
                                            selectDate + "",
                                            selectDay + "",
                                            timeSelected + "")),
                                  );
                                }
                              },
                              child: Container(
                                width: width - width * 0.2,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(
                                        color: Color(
                                            Utils.hexStringToHexInt('77ACA2')),
                                        width: 2)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Next',
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt(
                                                    '77ACA2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.03),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          );
        }
      })),
    );
  }

  void openn(width, height) {
    bool _value = false;
    showModalBottomSheet<void>(
        context: context,
        enableDrag: false,
        backgroundColor: Color(Utils.hexStringToHexInt('77ACA2')),
        isScrollControlled: false,
        isDismissible: false,
        builder: (BuildContext context) {
          return Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                    child: Image.asset(
                  'images/svgicons/hairdressing.png',
                  width: 70,
                  height: 70,
                  color: Colors.white,
                )),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.08, right: width * 0.08),
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.08, right: width * 0.08),
                  child: Text(
                    'Choose your category',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height * 0.2,
                  child: ListView.builder(
                      itemCount: 8,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                      print(_value);
                                    });
                                  },
                                ),
                                Text("SDFDFDDF"),
                              ],
                            ),
                            Text("SDFF")
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ElevatedButton(onPressed: null, child: Text("click here"))
              ],
            ),
          );
        });
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
  }

  Widget profiledes(BuildContext context, width, height, name, address,
      ownerimage, ownername, List<DataService>? services) {
    return Container(
        width: width,
        height: height * 0.2 + height * 0.04,
        color: Colors.white,
        margin: EdgeInsets.only(left: width * 0.04, top: height * 0.02),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontFamily: 'Poppins Regular'),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: width * 0.05,
                            height: height * 0.04,
                            child: SvgPicture.asset(
                              "images/svgicons/mappin.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(" " + address,
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontFamily: 'Poppins Regular',
                                  color: Color(
                                      Utils.hexStringToHexInt('#77ACA2'))),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: width * 0.03,
                          backgroundImage: NetworkImage(ownerimage),
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          " " + ownername,
                          style: TextStyle(
                              color: Color(Utils.hexStringToHexInt('#5E5E5E')),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontFamily: 'Poppins Light'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Services',
                      style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Flexible(
                      child: ListView.builder(
                          // customerRegList == null ? 0 : customerRegList.length,
                          itemCount: services == null ? 0 : services.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: true,
                          itemBuilder: (context, position) {
                            return Wrap(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 3, right: 3),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 6, bottom: 6),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                      color: Color(
                                          Utils.hexStringToHexInt('E5E5E5'))),
                                  child: Center(
                                      child: Text(
                                    services![position].serviceTitle.toString(),
                                    style: TextStyle(
                                        color: Color(
                                          Utils.hexStringToHexInt('#77ACA2'),
                                        ),
                                        fontFamily: 'Poppins Light',
                                        fontSize: width * 0.03),
                                  )),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 3, right: 3),
                width: width * 0.4 - width * 0.03,
                height: height * 0.2 - height * 0.06,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(Utils.hexStringToHexInt('#C4C4C4')),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  right: width * 0.3 - 6,
                  // alignment: Alignment.topLeft,
                  child: Text(
                    '4',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.07,
                        fontFamily: 'Poppins Medium'),
                  ),
                ),
                Positioned(
                  top: height * 0.03,
                  left: width * 0.7 - 10,
                  // alignment: Alignment.topLeft,
                  child: Text(
                    '/5',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.05,
                        fontFamily: 'Poppins Medium'),
                  ),
                ),
                // Positioned(
                //   top: height * 0.04,
                //   left: width * 0.7 - 10,
                //   // alignment: Alignment.topLeft,
                //   child: Text(
                //     '/5',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: width * 0.05,
                //         fontFamily: 'Poppins Medium'),
                //   ),
                // ),
                // Positioned(
                //   top: height * 0.04,
                //   left: width * 0.7 - 10,
                //   // alignment: Alignment.topLeft,
                //   child: Text(
                //     '/5',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: width * 0.06,
                //         fontFamily: 'Poppins Medium'),
                //   ),
                // ),
                Positioned(
                  top: height * 0.04,
                  left: width * 0.8,
                  // alignment: Alignment.topLeft,
                  child: Text(
                    '10',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.02,
                        fontFamily: 'Poppins Medium'),
                  ),
                ),
                Positioned(
                  top: height * 0.06,
                  left: width * 0.8,
                  // alignment: Alignment.topLeft,
                  child: Text(
                    'opnions',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.02,
                        fontFamily: 'Poppins Medium'),
                  ),
                ),
                Positioned(
                  top: height * 0.1,
                  left: width * 0.6 + width * 0.05,
                  // alignment: Alignment.topLeft,
                  child: RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 18.0,
                    direction: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget description(BuildContext context, width, height, description,
      aminities, List<TimeSlot>? timeSlot) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6, left: 6, right: 6),
      width: width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Description',
            style: TextStyle(
                fontSize: width * 0.03,
                color: Colors.black,
                fontFamily: 'Poppins Regular'),
          ),
          AutoSizeText(
            "$description",
            style: TextStyle(
                fontSize: width * 0.02,
                color: Color(Utils.hexStringToHexInt('#8D8D8D')),
                fontFamily: 'Poppins Light'),
            maxLines: 5,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            'Amenties',
            style: TextStyle(
                fontSize: width * 0.03,
                color: Colors.black,
                fontFamily: 'Poppins Regular'),
          ),
          AutoSizeText(
            "$aminities",
            style: TextStyle(
                fontSize: width * 0.02,
                color: Color(Utils.hexStringToHexInt('#8D8D8D')),
                fontFamily: 'Poppins Light'),
            maxLines: 5,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            "Timings",
            style: TextStyle(
                fontFamily: 'Poppins Regular',
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Colors.black),
          ),
          //Utils().titleText('Timings ', context),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            children: <Widget>[
              Text(
                'Opening Time',
                style: TextStyle(
                    color: Color(Utils.hexStringToHexInt('5E5E5E')),
                    fontFamily: 'Poppins Light',
                    fontSize: width * 0.03),
              ),
              SizedBox(
                width: width * 0.09,
              ),
              Text(
                'Closing Time',
                style: TextStyle(
                    color: Color(Utils.hexStringToHexInt('5E5E5E')),
                    fontFamily: 'Poppins Light',
                    fontSize: width * 0.03),
              )
            ],
          ),
          SizedBox(
            height: height * 0.001,
          ),
          Row(
            children: <Widget>[
              Text(
                timeSlot!.length > 0
                    ? " " + timeSlot[0].openingTime.toString()
                    : "",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins Regular',
                    fontSize: width * 0.03),
              ),
              SizedBox(
                width: width * 0.2,
              ),
              //  " " + timeSlot![0].closingTime.toString()
              Text(
                timeSlot.length > 0
                    ? " " + timeSlot[0].closingTime.toString()
                    : "",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins Regular',
                    fontSize: width * 0.03),
              )
            ],
          )
        ],
      ),
    );
  }

  Future _duratin(BuildContext contextt, width, height) {
    bool _value = false;
    return showDialog(
        barrierDismissible: false,
        context: contextt,
        builder: (BuildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Row(
              children: <Widget>[
                SizedBox(width: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Center(
                          child: Image.asset(
                        'images/svgicons/hairdressing.png',
                        width: 70,
                        height: 70,
                      )),
                      Container(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Choose your category',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins Regular',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.2,
                        child: ListView.builder(
                            itemCount: 8,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value!;
                                            print(_value);
                                          });
                                        },
                                      ),
                                      Text(
                                        "SDFDFDDF",
                                        style:
                                            TextStyle(fontSize: width * 0.03),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "SDFF",
                                    style: TextStyle(fontSize: width * 0.03),
                                  )
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      ElevatedButton(onPressed: null, child: Text("click here"))
                    ],
                  ),
                )
              ],
            ),
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }

  Widget seeallbarbaer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Utils().titleText('Choose your barber', context),
        Text(
          "  Choose your barber",
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.black),
        ),
        // Text(
        //   'See all ',
        //   style: TextStyle(
        //       fontFamily: 'Poppins Regular',
        //       fontSize: MediaQuery.of(context).size.height * 0.02,
        //       color: Color(Utils.hexStringToHexInt('#77aca2'))),
        // )
      ],
    );
  }

  Widget bestoffer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '  Best Offers for you',
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.black),
        ),
        Text(
          '5 offers  ',
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              fontSize: MediaQuery.of(context).size.height * 0.01,
              color: Color(Utils.hexStringToHexInt('#77aca2'))),
        )
      ],
    );
  }

  Widget seeall(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Utils().titleText('Choose services', context),
        Text(
          "  Choose services",
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.black),
        ),
        // Text(
        //   'See all ',
        //   style: TextStyle(
        //       fontFamily: 'Poppins Regular',
        //       fontSize: MediaQuery.of(context).size.height * 0.02,
        //       color: Color(Utils.hexStringToHexInt('#77aca2'))),
        // )
      ],
    );
  }

  Widget chooseyourslot(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Utils().titleText1(' Choose your Slot', context),
        Text(
          '',
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Color(Utils.hexStringToHexInt('#77aca2'))),
        )
      ],
    );
  }

  Widget barberlist(BuildContext context, width, height, Emploeyee emploeyee) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 12, left: width * 0.02),
          child: Card(
            elevation: 20,
            child: Container(
              width: width * 0.4 + width * 0.04,
              //   height: height * 0.4 - height * 0.04,
              padding:
                  EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  CircleAvatar(
                    radius: width * 0.14,
                    backgroundColor: Colors.yellow,
                    child: CircleAvatar(
                      radius: width * 0.13,
                      backgroundImage:
                          NetworkImage(emploeyee.profileImage.toString()),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    emploeyee.name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontFamily: 'Poppins Regular'),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    emploeyee.experience.toString(),
                    style: TextStyle(
                        color: Color(Utils.hexStringToHexInt('8D8D8D')),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: 'Poppins Regular'),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 18.0,
                    direction: Axis.horizontal,
                  )
                ],
              ),
            ),
          ),
        ),
        // isSelected != null &&
        //                         //         isSelected ==
        //                         //             position
        // Visibility(
        //     visible:  isSelected != null &&isSelected ==position?true:false,
        //     child:  Positioned(
        //     right: 10,
        //     top: -1.0,
        //     child: Container(
        //       width: 34,
        //       height: 34,
        //       color: Colors.white,
        //       child: Image.asset(
        //         'images/svgicons/circletick.png',
        //       ),
        //     )))
      ],
    );
  }
}

Future<void> openMap(BuildContext context, double lat, double lng) async {
  String url = '';
  String urlAppleMaps = '';
  if (Platform.isAndroid) {
    url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  } else {
    urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
    url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  if (await canLaunch(url)) {
    await launch(url);
  } else if (await canLaunch(urlAppleMaps)) {
    await launch(urlAppleMaps);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchUrl(latitude, longitude) async {
  const _url =
      'https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate';
  Uri _uri = Uri.parse(_url);

  if (!await launchUrl(_uri)) throw 'Could not launch $_url';
}

class SamleClass {
  var check = false;
  var title = "";

  SamleClass(this.check, this.title);
}
