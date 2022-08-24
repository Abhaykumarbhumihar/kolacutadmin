import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screen/CartOrder.dart';

import '../controller/home_controller.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import '../utils/appconstant.dart';
import 'sidenavigation.dart';

class MyCartList extends StatefulWidget {
  const MyCartList({Key? key}) : super(key: key);

  @override
  State<MyCartList> createState() => _MyCartListState();
}

class _MyCartListState extends State<MyCartList> {
  late SharedPreferences sharedPreferences;
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            key: scaffolKey,
            // drawer:  SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
            backgroundColor: Color(Utils.hexStringToHexInt('E5E5E5')),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              centerTitle: false,
              leading: InkWell(
                onTap: () {
                 Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Your Cartlist',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins Medium',
                    fontSize: width * 0.04),
              ),
              actions: <Widget>[],
            ),
            body: Get.find<HomeController>().cartListPjo != null
                ? GetBuilder<HomeController>(builder: (homeControlller) {
                    if (homeControlller.lodaer) {
                      return Container();
                    } else {
                      var data = homeControlller.cartListPjo.value;

                      return SizedBox(
                        width: width,
                        height: height,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.slotDetail!.isNotEmpty
                                ? data.slotDetail!.length
                                : null,
                            itemBuilder: (context, position) {
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                resizeDuration:
                                    const Duration(milliseconds: 200),
                                key: UniqueKey(),
                                onDismissed: (direction) async {
                                  SharedPreferences.getInstance()
                                      .then((SharedPreferences sp) async {
                                    sharedPreferences = sp;
                                    var _testValue =
                                        sharedPreferences.getString("session");
                                    Map map = {
                                      "session_id": _testValue,
                                      "cart_id": homeControlller.cartListPjo
                                          .value.slotDetail![position].id
                                          .toString()
                                    };
                                    print(map);
                                    var apiUrl = Uri.parse(
                                        AppConstant.BASE_URL +
                                            AppConstant.DELTE_CART);
                                    print(apiUrl);
                                    print(map);
                                    final response = await http.post(
                                      apiUrl,
                                      body: map,
                                    );
                                    print(response.body);
                                    final body = json.decode(response.body);
                                    CommonDialog.showsnackbar(body['message']);
                                    if (body["message"] ==
                                        "Cart deleted successfully") {
                                      setState(() {
                                        homeControlller
                                            .cartListPjo.value.slotDetail!
                                            .removeAt(position);
                                      });
                                    }
                                  });
                                  setState(() {
                                    //
                                  });

                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text('$item dismissed')));
                                },
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CartOrder(
                                                homeControlller
                                                    .cartListPjo
                                                    .value
                                                    .slotDetail![position])),
                                      );
                                    },
                                    child: Container(
                                      width: width,
                                      height: height * 0.2,
                                      margin: EdgeInsets.only(
                                          top: height * 0.001,
                                          bottom: height * 0.001),
                                      color: Colors.white,
                                      child: Card(
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                /*TODO---Saloon image*/
                                                Container(
                                                  child: Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                                left: 8),
                                                        height:
                                                            MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    0.2 -
                                                                height * 0.04,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            12),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            12)),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(data
                                                                      .slotDetail![
                                                                          position]
                                                                      .userImage
                                                                      .toString()),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ))),
                                                  ),
                                                ),
                                                Container(
                                                  child: Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(""),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.03,
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.04,
                                                              child: ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount: data
                                                                          .slotDetail![
                                                                              position]
                                                                          .service!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Container(
                                                                          margin: const EdgeInsets.only(
                                                                              left: 4,
                                                                              right: 4),
                                                                          padding:
                                                                              EdgeInsets.all(4),
                                                                          color:
                                                                              Color(Utils.hexStringToHexInt('E5E5E5')),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                margin: const EdgeInsets.only(top: 5),
                                                                                child: Center(
                                                                                  child: SvgPicture.asset(
                                                                                    'images/svgicons/tagsvg.svg',
                                                                                    fit: BoxFit.contain,
                                                                                    width: 24,
                                                                                    height: 24,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                padding: const EdgeInsets.only(right: 4),
                                                                                decoration: BoxDecoration(color: Color(Utils.hexStringToHexInt('E5E5E5'))),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  data.slotDetail![position].service![index].name.toString(),
                                                                                  style: TextStyle(fontSize: width * 0.03),
                                                                                )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: const Icon(
                                                          Icons
                                                              .keyboard_arrow_right_outlined,
                                                          size: 34,
                                                          color: Colors.blue,
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                            // /*TODO--femina text*/
                                            Positioned(
                                              top: height * 0.02,
                                              left: width * 0.3 + width * 0.03,
                                              child: Text(
                                                data.slotDetail![position]
                                                    .shopName
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                    fontFamily:
                                                        'Poppins Regular'),
                                              ),
                                            ),

                                            /*TODO---address*/
                                            Positioned(
                                              top: height * 0.05,
                                              left: width * 0.3 + width * 0.03,
                                              child: Text(
                                                data.slotDetail![position]
                                                    .userName
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(
                                                        Utils.hexStringToHexInt(
                                                            'A3A2A2')),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                    fontFamily:
                                                        'Poppins Regular'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      );
                    }
                  })
                : Container()));
  }
}
