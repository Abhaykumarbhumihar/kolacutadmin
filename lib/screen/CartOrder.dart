import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/CartListPojo.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:untitled/utils/CommomDialog.dart';

import '../controller/home_controller.dart';
import '../controller/shopdetain_controller.dart';
import '../utils/Utils.dart';
import 'coin.dart';

class CartOrder extends StatefulWidget {
  SlotDetail? slotDetail;

  //const CartOrder(SlotDetail slotDetail, {Key? key}) : super(key: key);
  CartOrder(SlotDetail slotDetail) {
    this.slotDetail = slotDetail;
  }

  @override
  State<CartOrder> createState() => _CartOrderState(slotDetail!);
}

class _CartOrderState extends State<CartOrder> {
  _CartOrderState(SlotDetail slotDetail);
  EzAnimation ezAnimation = EzAnimation(50.0, 200.0, Duration(seconds: 5));

  TextEditingController _textFieldcoin = TextEditingController();
  late Razorpay _razorpay;
  ShopDetailController salonControlller = Get.put(ShopDetailController());
  List resultList = [];
  var slotSelected = "";
  var timeSelected = "";
  var selectDate = "";
  var selectDay = "";
  var total_price = 0;
  List priceList = [];
  late SharedPreferences sharedPreferences;
  var coin = 0;
  var applycoin = 0.0;
  var applycouponPrice = 0.0;
  var applycouponCode="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("session");
      print(sharedPreferences.getString("session"));
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.find<HomeController>().getCoin(_testValue);
      });
    });
    print("COIN IS ${Get.find<HomeController>().coin}");
    coin = Get.find<HomeController>().coin;
    widget.slotDetail!.service!.forEach((element) {
      //totalPrice = totalPrice + int.parse(element.price.toString());
      total_price += int.parse(element.price.toString());
      print(element.name.toString() + "  " + element.price.toString());
      resultList.add(element.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //  print("COIN IS ${HomeController().coinPojo.value.coin}");
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      //  backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

Padding(
  padding: const EdgeInsets.only(left:12.0,right: 12.0),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget>[
      SizedBox(
        height: height * 0.02,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.black,
                ),
              ),
              Text(
                '${widget.slotDetail!.shopName.toString()}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontFamily: 'Poppins Regular'),
              )
            ],
          ),
          SvgPicture.asset(
            'images/svgicons/appcupon.svg',
            fit: BoxFit.contain,
            width: 24,
            height: 24,
          )
        ],
      ),
      SizedBox(
        height: height * 0.01,
      ),
      Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                "images/svgicons/mappin.svg",
              ),
            ),
            Text(' ${widget.slotDetail!.userName}',
                style: TextStyle(
                    fontSize: width * 0.03,
                    fontFamily: 'Poppins Regular',
                    color: Color(Utils.hexStringToHexInt('#77ACA2'))),
                textAlign: TextAlign.center),
          ],
        ),
      ),
      //////
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DatePicker(
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: Color(Utils.hexStringToHexInt('77ACA2')),
            selectedTextColor: Colors.white,
            monthTextStyle:
            TextStyle(color: Colors.white, fontSize: 0.0),
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
                        color:
                        Color(Utils.hexStringToHexInt('#8D8D8D')),
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
                          color:
                          Color(Utils.hexStringToHexInt('#8D8D8D')),
                          width: 1)),
                  child: Text(
                    '10:00 AM - 12:00 PM',
                    style: TextStyle(
                        fontSize: width * 0.03,
                        color:
                        Color(Utils.hexStringToHexInt('#8D8D8D'))),
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
                          color:
                          Color(Utils.hexStringToHexInt('#8D8D8D')),
                          width: 1)),
                  child: Text(
                    '10:00 AM - 12:00 PM',
                    style: TextStyle(
                        fontSize: width * 0.03,
                        color:
                        Color(Utils.hexStringToHexInt('#8D8D8D'))),
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
                        color:
                        Color(Utils.hexStringToHexInt('#8D8D8D')),
                        width: 1)),
                child: Text(
                  '10:00 AM - 12:00 PM',
                  style: TextStyle(
                      fontSize: width * 0.03,
                      color: Color(Utils.hexStringToHexInt('#8D8D8D'))),
                )),
          ])),
      ///////
      SizedBox(
        height: height * 0.04,
      ),
      Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              "images/svgicons/lock.svg",
            ),
          ),
          Text(
            '  Your Order',
            style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                fontFamily: 'Poppins Semibold'),
          )
        ],
      ),
      SizedBox(
        height: height * 0.02,
      ),
      Container(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '  Services',
              style: TextStyle(
                  color: Color(Utils.hexStringToHexInt('5E5E5E')),
                  fontSize: width * 0.03,
                  fontFamily: 'Poppins Regular'),
            ),
            Text(
              '  Prices      ',
              style: TextStyle(
                  color: Color(Utils.hexStringToHexInt('5E5E5E')),
                  fontSize: width * 0.03,
                  fontFamily: 'Poppins Regular'),
            )
          ],
        ),
      ),
      SizedBox(height: height * 0.02),
      Material(
        elevation: 1,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.slotDetail!.service!.length,
                  itemBuilder: (context, position) {
                    return Container(
                      margin: EdgeInsets.only(right: width * 0.03),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: width * 0.08,
                                height: height * 0.04,
                                child: SvgPicture.asset(
                                  "images/svgicons/checktick.svg",
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: width * 0.03),
                                child: Text(
                                    '${widget.slotDetail!.service![position].name}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.04,
                                        fontFamily: 'Poppins Regular')),
                              )
                            ],
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(right: width * 0.03),
                            child: Text(
                                'Rs. ${widget.slotDetail!.service![position].price}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.03,
                                    fontFamily: 'Poppins Regular')),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'images/svgicons/addmoreservices.svg',
                  width: width * 0.01,
                  height: height * 0.02,
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Color(Utils.hexStringToHexInt('E5E5E5')),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'images/svgicons/questionmark.svg',
                  fit: BoxFit.contain,
                  width: 18,
                  height: 18,
                ),
                Text(
                  ' Do you have any query?',
                  style: TextStyle(
                      fontFamily: 'Poppins Light',
                      fontSize: width * 0.02,
                      color: Color(Utils.hexStringToHexInt('8D8D8D'))),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    ],
  ),
),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      bool showSublist =
                          false; // Declare your variable outside the builder

                      bool showmainList = true;

                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Use coupon',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.black,
                                fontFamily: 'Poppins Medium',
                              ),
                            ),
                            IconButton(
                              onPressed: () => {Navigator.pop(context)},
                              icon: Icon(Icons.cancel_outlined),
                            ),
                          ],
                        ),
                        content: StatefulBuilder(
                          // You need this, notice the parameters below:
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              width: width,
                              height: height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            widget.slotDetail!.coupon!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, position) {
                                          return Container(
                                              width: width * 0.4 + width * 0.05,
                                              height: height * 0.12,
                                              margin: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            '  ${widget.slotDetail!.coupon![position].couponName.toString()}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins Regular',
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            '  Upto 50% off via UPI',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins Light',
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                                color: Color(Utils
                                                                    .hexStringToHexInt(
                                                                        'A4A4A4'))),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '  Use Code ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins Light',
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                                color: Color(Utils
                                                                    .hexStringToHexInt(
                                                                        'A4A4A4'))),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.0,
                                                                    horizontal:
                                                                        10.0),
                                                            color: Color(Utils
                                                                .hexStringToHexInt(
                                                                    '#46D0D9')),
                                                            child: Text(
                                                              '${widget.slotDetail!.coupon![position].couponCode.toString()}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins Light',
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                        tooltip:
                                                            "Applied coupon",
                                                        onPressed: () {
                                                          print(widget
                                                              .slotDetail!
                                                              .coupon![position]
                                                              .price
                                                              .toString());
                                                          applycouponCode=
                                                          applycouponCode =widget
                                                              .slotDetail!
                                                              .coupon![
                                                          position]
                                                              .couponCode
                                                              .toString();
                                                              double.parse(widget
                                                                  .slotDetail!
                                                                  .coupon![
                                                                      position]
                                                                  .price
                                                                  .toString());
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .tag_circle,
                                                          size: width * 0.05,
                                                          color: Colors.cyan,
                                                        )),
                                                  ),
                                                ],
                                              ));
                                        }),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: width,
                  height: height * 0.09,
                  child: Material(
                    color: Color(Utils.hexStringToHexInt('#dbe8e5')),
                    child: Container(
                        width: width,
                        height: height * 0.09,
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.03),
                        color: Color(Utils.hexStringToHexInt('#dbe8e5')),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'images/svgicons/bigoffer.svg',
                                  fit: BoxFit.contain,
                                  width: width * 0.06,
                                  height: height * 0.04,
                                ),
                                Text(
                                  ' Use Coupons',
                                  style: TextStyle(
                                      color: Color(
                                          Utils.hexStringToHexInt('77ACA2')),
                                      fontFamily: 'Poppins Medium',
                                      fontSize: width * 0.04),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color(Utils.hexStringToHexInt('77ACA2')),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () {
                  var Totalcoin = Get.find<HomeController>().coin * 0.10;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      var valueName = "";
                      var valuePrice = "";
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Use coin',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.black,
                                fontFamily: 'Poppins Medium',
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.cancel_outlined),
                            ),
                          ],
                        ),
                        content: Container(
                          width: 200,
                          height: height * 0.3,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'You have ${Get.find<HomeController>().coin} coins',
                                  style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Color(
                                        Utils.hexStringToHexInt('77ACA2')),
                                    fontFamily: 'Poppins Medium',
                                  ),
                                ),
                                // Text(
                                //   'You can only use 5% of your total coin ${Get.find<HomeController>().coin * 0.05}',
                                //   style: TextStyle(
                                //     fontSize: 8.0,
                                //     color: Color(
                                //         Utils.hexStringToHexInt('77ACA2')),
                                //     fontFamily: 'Poppins Medium',
                                //   ),
                                // ),
                                Text(
                                  ' ${Get.find<HomeController>().coin * 0.10} coin applied  .',
                                  style: TextStyle(
                                    fontSize: 8.0,
                                    color: Color(
                                        Utils.hexStringToHexInt('77ACA2')),
                                    fontFamily: 'Poppins Medium',
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),

                                // SizedBox(
                                //   width: width,
                                //   height: height * 0.1,
                                //   child: TextField(
                                //     textCapitalization:
                                //     TextCapitalization.sentences,
                                //     onChanged: (value) {
                                //       setState(() {
                                //         var Totalcoin =
                                //             Get.find<HomeController>().coin *
                                //                 0.05;
                                //         valueName = value;
                                //         if (int.parse(value) > Totalcoin) {
                                //           print("SDFDFDFDF ${value}");
                                //           CommonDialog.showsnackbar(
                                //               "You can not use coin more then ${Totalcoin}");
                                //         } else {
                                //           print(value);
                                //           applycoin = double.parse(value);
                                //         }
                                //       });
                                //     },
                                //     keyboardType: TextInputType.number,
                                //     controller: _textFieldcoin,
                                //     decoration: const InputDecoration(
                                //         border: OutlineInputBorder(),
                                //         hintText: "Enter coin here.."),
                                //   ),
                                // ),

                                AnimatedBuilder(
                                    animation: ezAnimation,
                                    builder: (context, snapshot) {
                                      return Center(
                                        child: Container(
                                          width: width * 0.3,
                                          height: height * 0.1,
                                          child: Image.asset(
                                            "images/svgicons/coin.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }),

                                SizedBox(
                                  height: 6,
                                ),

                                Center(
                                  child: FlatButton(
                                    color: Color(
                                        Utils.hexStringToHexInt('77ACA2')),
                                    textColor: Colors.white,
                                    child: Text('Use coin'),
                                    onPressed: () async {
                                      setState(() {
                                        applycoin = double.parse(
                                            "${Get.find<HomeController>().coin * 0.10}");
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
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
                child: SizedBox(
                  width: width,
                  height: height * 0.09,
                  child: Material(
                    color: Color(Utils.hexStringToHexInt('#dbe8e5')),
                    child: Container(
                        width: width,
                        height: height * 0.09,
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.03),
                        color: Color(Utils.hexStringToHexInt('#dbe8e5')),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'images/svgicons/bigoffer.svg',
                                  fit: BoxFit.contain,
                                  width: width * 0.06,
                                  height: height * 0.04,
                                ),
                                Text(
                                  ' Use Coin',
                                  style: TextStyle(
                                      color: Color(
                                          Utils.hexStringToHexInt('77ACA2')),
                                      fontFamily: 'Poppins Medium',
                                      fontSize: width * 0.04),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color(Utils.hexStringToHexInt('77ACA2')),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

              Material(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:12.0,right: 12.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.03),
                                    child: Text('Services total',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04,
                                            fontFamily: 'Poppins Regular')),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: width * 0.03),
                                //TODO--services ka total price
                                child: Text('Rs. ${total_price}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.03,
                                        fontFamily: 'Poppins Regular')),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.03),
                                    child: Text('Taxes & Charges',
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('5E5E5E')),
                                            fontSize: width * 0.03,
                                            fontFamily: 'Poppins Regular')),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: width * 0.06,
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: width * 0.03),
                                //TODO---services ka total price
                                child: Text('Rs. 0.0',
                                    style: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('5E5E5E')),
                                        fontSize: width * 0.03,
                                        fontFamily: 'Poppins Regular')),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.03),
                                    child: Text('Coupon Discount',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04,
                                            fontFamily: 'Poppins Regular')),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: width * 0.03),
                                child: Text(
                                    applycouponPrice != 0.0
                                        ? "-" + "${applycouponPrice}"
                                        : "N/A",
                                    style: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('5E5E5E')),
                                        fontSize: width * 0.03,
                                        fontFamily: 'Poppins Regular')),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.03),
                                    child: Text('Coin Applied',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04,
                                            fontFamily: 'Poppins Regular')),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: width * 0.03),
                                child: Text(
                                    applycoin != 0 ? "-" + "${applycoin}" : "N/A",
                                    style: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('5E5E5E')),
                                        fontSize: width * 0.03,
                                        fontFamily: 'Poppins Regular')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                    SizedBox(
                      height: 2,
                    ),
                    Divider(
                      color: Color(Utils.hexStringToHexInt('5E5E5E')),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),

                    /*TODO---Add to cart start from here*/
                    //TODO--bookin
                    // Container(
                    //   margin: EdgeInsets.only(right: width * 0.03),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Row(
                    //         children: <Widget>[
                    //           Container(
                    //             margin:
                    //                 EdgeInsets.only(left: width * 0.03),
                    //             child: Text('Grand Total',
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: width * 0.05,
                    //                     fontFamily: 'Poppins Medium')),
                    //           )
                    //         ],
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(right: width * 0.03),
                    //         child: Text('Rs. ${totalPrice}',
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: width * 0.05,
                    //                 fontFamily: 'Poppins Medium')),
                    //       ),
                    //       ElevatedButton(
                    //           onPressed: () {
                    //             bookService();
                    //           },
                    //           child: Text("Book service"))
                    //     ],
                    //   ),
                    // ),

                    // Container(
                    //     width: width,
                    //     margin: EdgeInsets.only(bottom: 10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius:
                    //         BorderRadius.all(Radius.circular(18))),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         GestureDetector(
                    //           onTap: () {
                    //             print(resultList.join(","));
                    //
                    //             // salonControlller.addTocart(
                    //             //     context,
                    //             //     widget.data!.id.toString(),
                    //             //     resultList.join(","));
                    //           },
                    //           child: Container(
                    //             width: width - width * 0.2,
                    //             padding: EdgeInsets.all(10),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(12)),
                    //                 border: Border.all(
                    //                     color: Color(
                    //                         Utils.hexStringToHexInt(
                    //                             '77ACA2')),
                    //                     width: 2)),
                    //             child: Center(
                    //               child: Column(
                    //                 mainAxisAlignment:
                    //                 MainAxisAlignment.center,
                    //                 children: <Widget>[
                    //                   Text(
                    //                     'Add to cart',
                    //                     style: TextStyle(
                    //                         color: Color(
                    //                             Utils.hexStringToHexInt(
                    //                                 '77ACA2')),
                    //                         fontFamily: 'Poppins Regular',
                    //                         fontSize: width * 0.03),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     )),
                    /*TODO---Add to cart end  here*/
                    Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: width,
                        height: height * 0.1 + height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Bill Total',
                                  style: TextStyle(
                                      color: Color(
                                          Utils.hexStringToHexInt('A3A2A2')),
                                      fontSize: width * 0.04,
                                      fontFamily: 'Poppins Regular'),
                                ),
                                //TODO--total price yaha pe change krna hai
/*TODO--${int.parse(total_price.toString()) - (applycouponPrice + applycoin)}*/
                                Text(
                                  " ₹${int.parse(total_price.toString())}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.05,
                                      fontFamily: 'Poppins Medium'),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                 /*TODO---- offline payment (no coupon allied no coin applied)*/

                                  },
                                  child: Container(
                                    width: width * 0.3,
                                    height: height * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        border: Border.all(
                                            color: Color(
                                                Utils.hexStringToHexInt(
                                                    '77ACA2')),
                                            width: 2)),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Pay Later',
                                            style: TextStyle(
                                                color: Color(
                                                    Utils.hexStringToHexInt(
                                                        '77ACA2')),
                                                fontFamily: 'Poppins Regular',
                                                fontSize: width * 0.03),
                                          ),
                                          Text(
                                            'No Discount',
                                            style: TextStyle(
                                                color: Color(
                                                    Utils.hexStringToHexInt(
                                                        '77ACA2')),
                                                fontFamily: 'Poppins Regular',
                                                fontSize: width * 0.02),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                /*TODO---pass from here*/

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      var description = "";
                                      widget.slotDetail!.service!
                                          .forEach((element) {
                                        description = description +
                                            "," +
                                            "${element.name.toString() + " " + element.price.toString()}";
                                        print(description);
                                      });
                                      //TODO--checkout screen
                                      openCheckout(
                                        widget.slotDetail!.shopName.toString(),
                                        description,
                                      );
                                    });
                                  },
                                  child: Container(
                                    width: width * 0.3,
                                    height: height * 0.08,
                                    margin: EdgeInsets.only(right: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Color(
                                            Utils.hexStringToHexInt('77ACA2'))),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Pay now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins Regular',
                                                fontSize: width * 0.03),
                                          ),
                                          Text(
                                            'Save ₹ ${(applycouponPrice + applycoin)}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins Regular',
                                                fontSize: width * 0.02),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
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

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(shopname, description) async {
    var options = {
      'key': 'rzp_test_XyJKvJNHhYN1ax',
      'amount': total_price,
      'name': '${widget.slotDetail!.shopName}',
      'description': '${description}',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print(options);
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    print("${response.paymentId} " + " SDF SDF SDF SDF ");
    bookServiceOnline("${response.paymentId}",applycoin,applycouponCode);
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void bookService(coin, coupon) {
    salonControlller.bookserVice(
        widget.slotDetail!.id.toString(),
         "",
        "3",
        resultList.join(","),
       selectDate,
       slotSelected,
        selectDay,
        "",
        "$total_price",
        "Offline",
        "",
        "",
        ""
       );
  }

  void bookServiceOnline(transactionID,coin, coupon) {
    salonControlller.bookserVice(
        widget.slotDetail!.id.toString(),
        "",
        "3",
        resultList.join(","),
        selectDate,
        slotSelected,
        selectDay,
        "",
        "${int.parse(total_price.toString()) - (applycouponPrice + applycoin)}",
        "Online",
        transactionID,
        coin,
        coupon
    );
  }
}
