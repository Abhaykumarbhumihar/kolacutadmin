import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/controller/BookingController.dart';
import 'package:untitled/model/MyBookingPojo.dart';
import 'package:untitled/screen/sidenavigation.dart';
import 'package:untitled/utils/CommomDialog.dart';
import 'package:untitled/utils/Utils.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({Key? key}) : super(key: key);

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  BookingController bookingController = Get.put(BookingController());
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  late SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    List<SlotDetail> _element = [];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //       wishListControlller.getWishList();
    //     });
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffolKey,
      drawer: SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            scaffolKey.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Your bookings',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins Medium',
              fontSize: width * 0.04),
        ),
      ),
      body: GetBuilder<BookingController>(builder: (bookingController) {
        if (bookingController.lodaer) {
          return Container();
        } else {
          for (var i = 0;
          i < bookingController.bookingPojo.value.slotDetail!.length;
          i++) {
            _element.add(bookingController.bookingPojo.value.slotDetail![i]);
          }
          return RefreshIndicator(
            onRefresh: () async {
              bookingController.getBookingList();
            },
            child: ListView(
              children: <Widget>[
                Container(
                  width: width,
                  height: height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: TableCalendar(
                              focusedDay: DateTime.now(),
                              firstDay: DateTime(2022),
                              lastDay: DateTime(2060),
                              onPageChanged: (DateTime date) {
                                //
                              },
                              onFormatChanged: (format) {
                                //
                              },
                              onDaySelected: (selectedTime, focusedTime) {
                                //
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (ctx, day, focusedDay) {
                                  int index = 0;
                                  for (var leaveEvent = 0;
                                  leaveEvent <
                                      bookingController.bookingPojo.value
                                          .slotDetail!.length;
                                  leaveEvent++) {
                                    index++;
                                    final DateTime event = bookingController
                                        .bookingPojo
                                        .value
                                        .slotDetail![leaveEvent]
                                        .date!;
                                    if (day.day == event.day &&
                                        day.month == event.month &&
                                        day.year == event.year) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Material(
                                          elevation: 6.0,
                                          borderRadius:
                                          BorderRadius.circular(6.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Center(
                                                    child: Text('${day.day}'),
                                                  ),
                                                ),
                                                Container(
                                                  width: 15,
                                                  height: 6,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        6.0),
                                                    color: Colors.orange,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: width,
                          height: height * 0.3,
                          child: StickyGroupedListView<SlotDetail, DateTime>(
                            elements: _element,
                            order: StickyGroupedListOrder.ASC,
                            groupBy: (SlotDetail element) => DateTime(
                              element.date!.year,
                              element.date!.month,
                              element.date!.day,
                            ),
                            groupComparator:
                                (DateTime value1, DateTime value2) =>
                                value2.compareTo(value1),
                            itemComparator:
                                (SlotDetail element1, SlotDetail element2) =>
                                element1.date!.compareTo(element2.date!),
                            floatingHeader: true,
                            groupSeparatorBuilder: _getGroupSeparator,
                            itemBuilder: _getItem,
                          ),
                        ),
                        // SizedBox(
                        //   height: height * 0.02,
                        // ),
                        // Divider(
                        //   height: 2,
                        //   color: Colors.grey,
                        // ),
                        // SizedBox(
                        //   height: height * 0.02,
                        // ),
                        // Center(
                        //   child: Text(
                        //     'Today',
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: width * 0.04,
                        //         fontFamily: 'Poppins Semibold'),
                        //   ),
                        // ),
                        // Container(
                        //   width: width,
                        //   padding: EdgeInsets.all(width * 0.03),
                        //   margin: EdgeInsets.all(width * 0.03),
                        //   decoration: BoxDecoration(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(width * 0.02)),
                        //       border: Border.all(color: Colors.black26, width: 2)),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Row(
                        //         children: <Widget>[
                        //           IntrinsicHeight(
                        //             child: Row(
                        //               children: <Widget>[
                        //                 Text(
                        //                   '11:00',
                        //                   style: TextStyle(
                        //                       color: Color(
                        //                           Utils.hexStringToHexInt('26578C')),
                        //                       fontFamily: 'Poppins Semibold',
                        //                       fontSize: width * 0.04),
                        //                 ),
                        //                 SizedBox(
                        //                   width: width * 0.02,
                        //                 ),
                        //                 Container(
                        //                   width: 1,
                        //                   height: height * 0.06,
                        //                   color: Colors.black,
                        //                   padding:
                        //                       EdgeInsets.only(left: 12, right: 12),
                        //                 ),
                        //                 SizedBox(
                        //                   width: width * 0.02,
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Text(
                        //                 'Femina Beauty Salon',
                        //                 style: TextStyle(
                        //                     color: Colors.black,
                        //                     fontSize: width * 0.03,
                        //                     fontFamily: 'Poppins Regular'),
                        //               ),
                        //               Text('Galleria, Ghaziabad',
                        //                   style: TextStyle(
                        //                       fontSize: width * 0.02,
                        //                       fontFamily: 'Poppins Regular',
                        //                       color: Color(
                        //                           Utils.hexStringToHexInt('6B6868'))),
                        //                   textAlign: TextAlign.center),
                        //             ],
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   width: width,
                        //   padding: EdgeInsets.all(width * 0.03),
                        //   margin: EdgeInsets.all(width * 0.03),
                        //   decoration: BoxDecoration(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(width * 0.02)),
                        //       border: Border.all(color: Colors.black26, width: 2)),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Row(
                        //         children: <Widget>[
                        //           IntrinsicHeight(
                        //             child: Row(
                        //               children: <Widget>[
                        //                 Text(
                        //                   '11:00',
                        //                   style: TextStyle(
                        //                       color: Color(
                        //                           Utils.hexStringToHexInt('26578C')),
                        //                       fontFamily: 'Poppins Semibold',
                        //                       fontSize: width * 0.04),
                        //                 ),
                        //                 SizedBox(
                        //                   width: width * 0.02,
                        //                 ),
                        //                 Container(
                        //                   width: 1,
                        //                   height: height * 0.06,
                        //                   color: Colors.black,
                        //                   padding:
                        //                       EdgeInsets.only(left: 12, right: 12),
                        //                 ),
                        //                 SizedBox(
                        //                   width: width * 0.02,
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Text(
                        //                 'Femina Beauty Salon',
                        //                 style: TextStyle(
                        //                     color: Colors.black,
                        //                     fontSize: width * 0.03,
                        //                     fontFamily: 'Poppins Regular'),
                        //               ),
                        //               Text('Galleria, Ghaziabad',
                        //                   style: TextStyle(
                        //                       fontSize: width * 0.02,
                        //                       fontFamily: 'Poppins Regular',
                        //                       color: Color(
                        //                           Utils.hexStringToHexInt('6B6868'))),
                        //                   textAlign: TextAlign.center),
                        //             ],
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _getGroupSeparator(SlotDetail element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.blue[300]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${element.date!.day}- ${element.date!.month}- ${element.date!.year}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(context, SlotDetail slotDetail) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            List<Service> tempArray = [];
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Order detail of ${slotDetail.bookingId}"),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                      ))
                ],
              ),
              content: StatefulBuilder(
                // You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                      width: width,
                      height: height * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                "${slotDetail.userName}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "BookingID",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                "${slotDetail.bookingId}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Booking Date",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                  "${slotDetail.date!.day}-${slotDetail.date!.month}-${slotDetail.date!.year}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      color: Color(
                                          Utils.hexStringToHexInt('C4C4C4')),
                                      fontSize: width * 0.03)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Transaction",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                "${slotDetail.transactionId}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                            ],
                          ),
                          LimitedBox(
                            maxHeight: height * 0.3,
                            child: ListView.builder(
                                itemCount: slotDetail.service!.length,
                                itemBuilder: (context, position) {
                                  return Container(
                                    height: height * 0.03,
                                    margin: EdgeInsets.only(left: 4, right: 4),
                                    child: Container(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${slotDetail.service![position].name}",
                                                style: TextStyle(fontSize: 8.0),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${slotDetail.service![position].price}",
                                            style: TextStyle(fontSize: 8.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ));
                },
              ),
            );
          },
        );
      },
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.03),
        margin: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(width * 0.02)),
            border: Border.all(color: Colors.black26, width: 2)),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '11:00',
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('26578C')),
                            fontFamily: 'Poppins Semibold',
                            fontSize: width * 0.04),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Container(
                        width: 1,
                        height: height * 0.06,
                        color: Colors.black,
                        padding: EdgeInsets.only(left: 12, right: 12),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${slotDetail.shopName}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.03,
                          fontFamily: 'Poppins Regular'),
                    ),
                    Text('${slotDetail.bookingId}',
                        style: TextStyle(
                            fontSize: width * 0.02,
                            fontFamily: 'Poppins Regular',
                            color: Color(Utils.hexStringToHexInt('6B6868'))),
                        textAlign: TextAlign.center),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}