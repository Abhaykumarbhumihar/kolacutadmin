// ignore_for_file: iterable_contains_unrelated_type

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kolacur_admin/controller/profile_caroselController.dart';
import 'package:kolacur_admin/model/ShopProfileePojo.dart';
import 'package:kolacur_admin/model/add_service.dart';
import 'package:kolacur_admin/services/ApiCall.dart';
import 'package:kolacur_admin/utils/CommomDialog.dart';
import 'package:kolacur_admin/utils/Utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../model/AdminServicePojo.dart';
import '../model/DeleteCoupon.dart';
import '../model/FeedbackBojo.dart';
import '../utils/appconstant.dart';
import 'sidenavigation.dart';

class ProfileCarose extends StatefulWidget {
  const ProfileCarose({Key? key}) : super(key: key);

  @override
  State<ProfileCarose> createState() => _HomePageState();
}

class _HomePageState extends State<ProfileCarose> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  int _current = 0;
  final CarouselController _controller = CarouselController();
  ProfileCOntroller profileController = Get.put(ProfileCOntroller());
  TextEditingController _textFieldControllerName = TextEditingController();
  TextEditingController _textFieldControllerPrice = TextEditingController();

  TextEditingController _textFieldControllerupdatedprice =
      TextEditingController();

  TextEditingController _textFieldControllerupdateAmenities =
      TextEditingController();
  TextEditingController _textFieldControllerupdateABout =
      TextEditingController();
  TextEditingController _textFieldControllermessage = TextEditingController();
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  final box = GetStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var categoryvisiblitt = true;

  void dd(BuildContext context, List<ServiceDetail>? data) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool showSublist = false; // Declare your variable outside the builder
        List<Service> tempArray = [];



        bool showmainList = true;
        var serviceId = "";
        var mainlistPosition = 0;
        var bntname = "Add";
        var serviceNmae = "";
        return AlertDialog(
          title: const Text("Choose your services"),
          content: StatefulBuilder(
            // You need this, notice the parameters below:
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: showmainList,
                    child: Flexible(
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: data!.length,
                          itemBuilder: (context, positio) {
                            return InkWell(
                              onTap: () {
                                setState(() {


                                  mainlistPosition = positio;
                                  serviceId =
                                      data[positio].serviceId.toString();

                                  if (showSublist) {
                                    showSublist = false;
                                  } else {
                                    showSublist = true;


                                  }

                                  if (showmainList) {
                                    showmainList = false;
                                  } else {
                                    showmainList = true;
                                  }
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: width,
                                    height: height * 0.1,
                                    margin: EdgeInsets.only(top: 4, bottom: 4),
                                    child: Material(
                                      elevation: 8.0,
                                      shadowColor: Colors.white,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 6.0,
                                          ),
                                          CircleAvatar(
                                            child: ClipOval(
                                              child: Image.network(
                                                data[positio]
                                                    .serviceImage
                                                    .toString(),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 25,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data[positio]
                                                .serviceTitle
                                                .toString(),
                                            style: TextStyle(fontSize: 12.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Visibility(
                      visible: showSublist,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: width,
                              child: ListView.builder(
                                  itemCount:
                                      data[mainlistPosition].services!.length,
                                  itemBuilder: (context, position) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {


                                          print(data[mainlistPosition]
                                              .services![position]
                                              .id);
                                          if (tempArray.contains(
                                              data[mainlistPosition]
                                                  .services![position])) {
                                            tempArray.remove(
                                                data[mainlistPosition]
                                                    .services![position]);
                                          } else {
                                            tempArray.add(data[mainlistPosition]
                                                .services![position]);
                                          }
                                          print(tempArray.toString());
                                        });
                                      },
                                      child: Container(
                                        height: height * 0.1,
                                        margin: EdgeInsets.only(
                                            top: 4.0, bottom: 4.0),
                                        child: Material(
                                          elevation: 8.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          shadowColor: Colors.white,
                                          child: Container(
                                            margin: EdgeInsets.all(4.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data[mainlistPosition]
                                                              .services![
                                                                  position]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 8.0),
                                                        ),
                                                        Text(
                                                          data[mainlistPosition]
                                                              .services![
                                                                  position]
                                                              .price
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 8.0),
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons
                                                          .info_outline_rounded),
                                                      onPressed: () {
                                                        //price,servicename,subservice,service
                                                        //mainlistPosition
                                                        updateService(
                                                            context,
                                                            data[mainlistPosition]
                                                                .services![
                                                                    position]
                                                                .price
                                                                .toString(),
                                                            data[mainlistPosition]
                                                                .services![
                                                                    position]
                                                                .name
                                                                .toString(),
                                                            data[mainlistPosition]
                                                                .services![
                                                                    position]
                                                                .id
                                                                .toString(),
                                                            mainlistPosition);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Icon(tempArray.contains(data[
                                                            mainlistPosition]
                                                        .services![position])
                                                    ? Icons.cancel
                                                    : Icons.add_circle_outline),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                var list = [];
                                setState(() async {
                                  print("SDF SDF SFDSF SDF SDF SDF DS");
                                  for (var i = 0; i < tempArray.length; i++) {
                                    print(tempArray[i].name);
                                    list.add(tempArray[i].id);
                                  }

                                  var stringList = list.join(",");
                                  print(stringList);
                                  Map map = {
                                    "session_id": box.read('session'),
                                    "sub_service_id": stringList.toString(),
                                    "service_id": serviceId + ""
                                  };

                                  print(map);
                                  var apiUrl = Uri.parse(AppConstant.BASE_URL +
                                      AppConstant.ADD_SERVICE);
                                  print(apiUrl);

                                  print(map);
                                  final response = await http.post(
                                    apiUrl,
                                    body: map,
                                  );
                                  tempArray.clear();
                                  mainlistPosition = 0;
                                  serviceId = "";
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      var jsonString = response.body;
                                      print(jsonString);
                                      Navigator.pop(context);
                                      profileController.getShopService(session);
                                    });
                                    //return jsonString;
                                  } else {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                    // return "null";
                                  }

                                  if (showSublist) {
                                    showSublist = false;
                                  } else {
                                    showSublist = true;
                                  }

                                  if (showmainList) {
                                    showmainList = false;
                                  } else {
                                    showmainList = true;
                                  }
                                });
                              },
                              child: Text('Add Services'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              );
            },
          ),
        );
      },
    );
  }

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {
          if (imagefiles != null) {
            imagefiles!.forEach((element) {
              print(element.path);
              profileController.shopproflePojo.value.data!.shopImage!
                  .add(ShopImage(shopImageId: 1, shopImage: element.path));
              imgList.add(element.path);
              var apicall = APICall();
              var a =
                  apicall.uploadshopimages(imagefiles!, box.read('session'));

              print("${a} KLKLKLKLKLK");
            });
          }

          // print(imagefiles.path);
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void updateService(
      BuildContext context, price, servicename, subservice, service) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var valueName = "";
        var valuePrice = "";
        return AlertDialog(
          title: Text(
            'Update Price of $servicename',
            style: TextStyle(fontSize: 8.0),
          ),
          content: Container(
            width: width,
            height: height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Kolacut price of :${servicename} is ${price} ',
                  style: TextStyle(fontSize: 8.0),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valueName = value;
                    });
                  },
                  controller: _textFieldControllerupdatedprice,
                  decoration: InputDecoration(hintText: "Price"),
                ),
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       valuePrice = value;
                //     });
                //   },
                //   controller: _textFieldControllermessage,
                //   decoration: InputDecoration(hintText: "Enter your message"),
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('OK'),
              onPressed: () async {
                //service_id:1
                // price:25
                // sub_service_id:1
                Map map = {
                  "session_id": box.read('session'),
                  "sub_service_id": subservice.toString(),
                  "service_id": service.toString(),
                  "price": _textFieldControllerupdatedprice.text.toString()
                };
                print(map);
                var apiUrl =
                    Uri.parse(AppConstant.BASE_URL + AppConstant.UPDATE_PRICE);
                print(apiUrl);
                print(map);
                final response = await http.post(
                  apiUrl,
                  body: map,
                );
                print(response.body);
                _textFieldControllerupdatedprice.clear();
                _textFieldControllermessage.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void addImages(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var valueName = "";
        var valuePrice = "";
        return AlertDialog(
          title: Text(
            "Upload images",
            style: TextStyle(fontSize: 8.0),
          ),
          content: Container(
            width: width,
            height: height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Add Images'),
                  onPressed: () {},
                ),
                imagefiles != null
                    ? Wrap(
                        children: imagefiles!.map((imageone) {
                          return Container(
                              child: Card(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.file(File(imageone.path)),
                            ),
                          ));
                        }).toList(),
                      )
                    : Container()
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  var session = "";
  late SharedPreferences sharedPreferences;

  void addCoupon(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var valueName = "";
        var valuePrice = "";
        return AlertDialog(
          title: Text('Add coupon'),
          content: Container(
            width: width,
            height: height * 0.2,
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valueName = value;
                    });
                  },
                  controller: _textFieldControllerName,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valuePrice = value;
                    });
                  },
                  controller: _textFieldControllerPrice,
                  decoration: InputDecoration(hintText: "Price"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('OK'),
              onPressed: () {
                setState(() async {
                  Map map = {
                    "session_id": box.read('session'),
                    "coupon_name": _textFieldControllerName.text.toString(),
                    "price": _textFieldControllerPrice.text.toString()
                  };

                  var apiUrl =
                      Uri.parse(AppConstant.BASE_URL + AppConstant.ADD_COUPON);
                  print(apiUrl);
                  print(map);
                  final response = await http.post(
                    apiUrl,
                    body: map,
                  );
                  if (response.statusCode == 200) {
                    setState(() {
                      var jsonString = response.body;
                      print(jsonString);
                      profileController.getCouponList1();
                      Navigator.pop(context);
                      _textFieldControllerPrice.clear();
                      _textFieldControllerName.clear();
                    });
                    //return jsonString;
                  } else {
                    setState(() {
                      Navigator.pop(context);
                      _textFieldControllerPrice.clear();
                      _textFieldControllerName.clear();
                    });
                    // return "null";
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

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
        name = _testValue!;
        email = emailValue!;
        phone = _phoneValue!;
        iamge = _imageValue!;
        session = _session!;
      });
      // will be null if never previously saved
      //  print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        width: width,
        height: height,
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
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            titleSpacing: 0,
            title: Text(
              'Profile',
              style: TextStyle(
                  fontFamily: 'Poppins Regular',
                  color: Colors.white,
                  fontSize: width * 0.04),
            ),
            // actions: <Widget>[const Icon(CupertinoIcons.bell)],
          ),
          backgroundColor: Colors.transparent,
          body: GetBuilder<ProfileCOntroller>(builder: (profileController) {
            if (profileController.lodaer) {
              return Container(
                width: width,
                height: height,
                color: Colors.white,
              );
            } else {
              var profiledata = profileController.shopproflePojo.value.data;
              var oneStar =
                  profileController.feedback.value.ratingDetail!.where((item) {
                return int.parse(item.rating!) == 1;
              });
              var twoStar =
                  profileController.feedback.value.ratingDetail!.where((item) {
                return int.parse(item.rating!) == 2;
              });
              var threeStar =
                  profileController.feedback.value.ratingDetail!.where((item) {
                return int.parse(item.rating!) == 3;
              });
              var fourStar =
                  profileController.feedback.value.ratingDetail!.where((item) {
                return int.parse(item.rating!) == 4;
              });
              var fiveStar =
                  profileController.feedback.value.ratingDetail!.where((item) {
                return int.parse(item.rating!) == 5;
              });
              final List<Widget> imageSliders = profiledata!.shopImage!
                  .map((item) => Container(
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  item.shopImage.toString().startsWith("http")
                                      ? Image.network(item.shopImage.toString(),
                                          fit: BoxFit.cover, width: 1000.0)
                                      : Image.file(
                                          File(item.shopImage.toString()),
                                          fit: BoxFit.cover,
                                          width: 1000.0),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList();
              return SizedBox(
                  width: width,
                  height: height,
                  child: ListView(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          // Container(
                          //   width: width,
                          //   height: height * 0.7,
                          //   decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //           image: AssetImage(
                          //               'images/svgicons/fullbackpn.png'),
                          //           fit: BoxFit.fill)),
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: width * 0.06),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Photo Gallery',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.03),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        openImages();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: width * 0.02),
                                        width: width * 0.2,
                                        height: height * 0.03,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.01),
                                            color: Color(
                                                Utils.hexStringToHexInt(
                                                    '#ecfafb'))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  color: Color(
                                                      Utils.hexStringToHexInt(
                                                          '46D0D9'))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                width: width,
                                height: height * 0.3,
                                color: Colors.transparent,
                                child: Stack(children: <Widget>[
                                  CarouselSlider(
                                    items: imageSliders != null
                                        ? imageSliders
                                        : null,
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        aspectRatio: 2.0,
                                        enableInfiniteScroll: true,
                                        viewportFraction: 0.8,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                  ),
                                  // Positioned(
                                  //   top: height * 0.2,
                                  //   left: width * 0.4,
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children:
                                  //         imgList.asMap().entries.map((entry) {
                                  //       return GestureDetector(
                                  //         onTap: () => _controller
                                  //             .animateToPage(entry.key),
                                  //         child: Container(
                                  //           width: 12.0,
                                  //           height: 12.0,
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 8.0, horizontal: 4.0),
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: (Theme.of(context)
                                  //                               .brightness ==
                                  //                           Brightness.dark
                                  //                       ? Colors.white
                                  //                       : Color(Utils
                                  //                           .hexStringToHexInt(
                                  //                               'FFFFFF')))
                                  //                   .withOpacity(
                                  //                       _current == entry.key
                                  //                           ? 0.9
                                  //                           : 0.4)),
                                  //         ),
                                  //       );
                                  //     }).toList(),
                                  //   ),
                                  // ),
                                ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.06, right: width * 0.06),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'About',
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: Colors.black,
                                              fontFamily: 'Poppins Regular'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            debugPrint("SDF SDF SDF SDF S DF");
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
                                                      Text(
                                                        'Update About of your shop',
                                                        style: TextStyle(
                                                            fontSize: 8.0),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(Icons
                                                            .cancel_outlined),
                                                      ),
                                                    ],
                                                  ),
                                                  content: Container(
                                                    width: 200,
                                                    height: height * 0.4,
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
                                                            height:
                                                                height * 0.3,
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
                                                              maxLines: 30,
                                                              controller:
                                                                  _textFieldControllerupdateABout,
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          "Enter here..."),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          FlatButton(
                                                            color: Colors.green,
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
                                                              var apiUrl = Uri
                                                                  .parse(AppConstant
                                                                          .BASE_URL +
                                                                      AppConstant
                                                                          .UPDTE_SHOP);
                                                              print(apiUrl);
                                                              print(map);
                                                              final response =
                                                                  await http
                                                                      .post(
                                                                apiUrl,
                                                                body: map,
                                                              );
                                                              print(response
                                                                  .body);
                                                              _textFieldControllerupdateABout
                                                                  .clear();
                                                              Navigator.pop(
                                                                  context);
                                                              profileController
                                                                  .getUpdatedShopProfile(
                                                                      box.read(
                                                                          'session'));
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
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: width * 0.02),
                                            width: width * 0.2,
                                            height: height * 0.03,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width * 0.01),
                                                color: Color(
                                                    Utils.hexStringToHexInt(
                                                        '#ecfafb'))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      fontFamily:
                                                          'Poppins Regular',
                                                      color: Color(Utils
                                                          .hexStringToHexInt(
                                                              '46D0D9'))),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    AutoSizeText(
                                      "${profiledata.description.toString() == "" ? "N/A" : profiledata.description.toString()}",
                                      style: TextStyle(
                                          fontSize: width * 0.02,
                                          color: Color(Utils.hexStringToHexInt(
                                              '#8D8D8D')),
                                          fontFamily: 'Poppins Light'),
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.06, right: width * 0.06),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Amenties',
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: Colors.black,
                                              fontFamily: 'Poppins Regular'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            debugPrint("SDF SDF SDF SDF S DF");

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
                                                      Text(
                                                        'Update Amenties of your shop',
                                                        style: TextStyle(
                                                            fontSize: 8.0),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(Icons
                                                            .cancel_outlined),
                                                      ),
                                                    ],
                                                  ),
                                                  content: Container(
                                                    width: 200,
                                                    height: height * 0.4,
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
                                                            height:
                                                                height * 0.3,
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
                                                              maxLines: 30,
                                                              controller:
                                                                  _textFieldControllerupdateAmenities,
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          "Enter here..."),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          FlatButton(
                                                            color: Colors.green,
                                                            textColor:
                                                                Colors.white,
                                                            child: Text('OK'),
                                                            onPressed:
                                                                () async {
                                                              Map map = {
                                                                "session_id":
                                                                    box.read(
                                                                        'session'),
                                                                "amenties":
                                                                    _textFieldControllerupdateAmenities
                                                                        .text
                                                                        .toString()
                                                              };
                                                              print(map);
                                                              var apiUrl = Uri
                                                                  .parse(AppConstant
                                                                          .BASE_URL +
                                                                      AppConstant
                                                                          .UPDTE_SHOP);
                                                              print(apiUrl);
                                                              print(map);
                                                              final response =
                                                                  await http
                                                                      .post(
                                                                apiUrl,
                                                                body: map,
                                                              );
                                                              print(response
                                                                  .body);
                                                              _textFieldControllerupdateAmenities
                                                                  .clear();
                                                              Navigator.pop(
                                                                  context);
                                                              profileController
                                                                  .getUpdatedShopProfile(
                                                                      box.read(
                                                                          'session'));
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
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: width * 0.02),
                                            width: width * 0.2,
                                            height: height * 0.03,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width * 0.01),
                                                color: Color(
                                                    Utils.hexStringToHexInt(
                                                        '#ecfafb'))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      fontFamily:
                                                          'Poppins Regular',
                                                      color: Color(Utils
                                                          .hexStringToHexInt(
                                                              '46D0D9'))),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    AutoSizeText(
                                      "${profiledata.amenties.toString() == "" ? "N/A" : profiledata.amenties.toString()}",
                                      style: TextStyle(
                                          fontSize: width * 0.02,
                                          color: Color(Utils.hexStringToHexInt(
                                              '#8D8D8D')),
                                          fontFamily: 'Poppins Light'),
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: width * 0.06, right: width * 0.06),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: width * 0.02),
                                        width: width * 0.2,
                                        height: height * 0.03,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                              child: SvgPicture.asset(
                                                "images/svgicons/starttt.svg",
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            Text(
                                              ' Your Rating',
                                              style: TextStyle(
                                                  fontSize: width * 0.02,
                                                  fontFamily: 'Poppins Regular',
                                                  color: Color(
                                                      Utils.hexStringToHexInt(
                                                          '46D0D9'))),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: width * 0.02),
                                        width: width * 0.2,
                                        height: height * 0.03,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.03),
                                            color: Color(
                                                Utils.hexStringToHexInt(
                                                    '#ecfafb'))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${profileController.feedback.value?.totalRating}',
                                              style: TextStyle(
                                                  fontSize: width * 0.02,
                                                  fontFamily: 'Poppins Regular',
                                                  color: Color(
                                                      Utils.hexStringToHexInt(
                                                          '46D0D9'))),
                                            ),
                                            Center(
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: width * 0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Divider(
                                color: Color(Utils.hexStringToHexInt('E6E8EA')),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: width * 0.06, right: width * 0.06),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Services Offered',
                                                style: TextStyle(
                                                    fontSize: width * 0.03,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'Poppins Regular'),
                                              ),
                                              Text(
                                                '${profileController.shopService.value.serviceDetail!.length.toString() != null ? profileController.shopService.value.serviceDetail!.length.toString() : ""} services',
                                                style: TextStyle(
                                                    fontSize: width * 0.02,
                                                    color: Color(
                                                        Utils.hexStringToHexInt(
                                                            '8D8D8D')),
                                                    fontFamily:
                                                        'Poppins Regular'),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              debugPrint(
                                                  "SDF SDF SDF SDF S DF");
                                              print(profileController
                                                  .adminServicePojo
                                                  .value
                                                  .serviceDetail!
                                                  .length);
                                              //  Get.to(AddService());
                                              dd(
                                                  context,
                                                  profileController
                                                      .adminServicePojo
                                                      .value
                                                      .serviceDetail);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: width * 0.02),
                                              width: width * 0.2,
                                              height: height * 0.03,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width * 0.01),
                                                  color: Color(
                                                      Utils.hexStringToHexInt(
                                                          '#ecfafb'))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        fontFamily:
                                                            'Poppins Regular',
                                                        color: Color(Utils
                                                            .hexStringToHexInt(
                                                                '46D0D9'))),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width,
                                        height: height * 0.1,
                                        child: ListView.builder(
                                            itemCount: profileController
                                                .shopService
                                                .value
                                                .serviceDetail!
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, position) {
                                              return InkWell(
                                                onTap: () {
                                                  var width =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;
                                                  var height =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height;
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      List<Service> tempArray =
                                                          [];

                                                      return AlertDialog(
                                                        content:
                                                            StatefulBuilder(
                                                          // You need this, notice the parameters below:
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                            return Container(
                                                              width: width,
                                                              child: Column(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        height: height *
                                                                            0.4,
                                                                        width:
                                                                            width,
                                                                        child:
                                                                            Flexible(
                                                                          child: ListView.builder(
                                                                              itemCount: profileController.shopService.value.serviceDetail![position].services!.length,
                                                                              itemBuilder: (context, positionn) {
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {});
                                                                                  },
                                                                                  child: Container(
                                                                                    height: height * 0.1,
                                                                                    margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                                                                                    child: Material(
                                                                                      elevation: 8.0,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      shadowColor: Colors.white,
                                                                                      child: Container(
                                                                                        width: width,
                                                                                        margin: EdgeInsets.all(4.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: <Widget>[
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: <Widget>[
                                                                                                Text(
                                                                                                  profileController.shopService.value.serviceDetail![position].services![positionn].name.toString(),
                                                                                                  style: TextStyle(fontSize: 8.0),
                                                                                                ),
                                                                                                Text(
                                                                                                  profileController.shopService.value.serviceDetail![position].services![positionn].price.toString(),
                                                                                                  textAlign: TextAlign.left,
                                                                                                  style: TextStyle(fontSize: 8.0),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            /*TODO---remove service*/
                                                                                            IconButton(
                                                                                                onPressed: () async {
                                                                                                  // session_id:4ysvjISDdKKEk5qtSzBamzWco6VnkDuK
                                                                                                  // sub_service_id:1,2
                                                                                                  Map map = {
                                                                                                    "session_id": box.read('session'),
                                                                                                    "sub_service_id": profileController.shopService.value.serviceDetail![position].services![positionn].id.toString(),
                                                                                                    "service_id": profileController.shopService.value.serviceDetail![position].serviceId.toString(),
                                                                                                  };

                                                                                                  print(map);
                                                                                                  var apiUrl = Uri.parse(AppConstant.BASE_URL + AppConstant.DELETE_ADD_SERVICE);
                                                                                                  print(apiUrl);
                                                                                                  print(map);

                                                                                                  final response = await http.post(
                                                                                                    apiUrl,
                                                                                                    body: map,
                                                                                                  );
                                                                                                  var data = deleteCouponFromJson(response.body);
                                                                                                  print(response.body);
                                                                                                  CommonDialog.showsnackbar(data.message);
                                                                                                  Navigator.pop(context);
                                                                                                  profileController.getUpdatedShopService(box.read('session'));
                                                                                                },
                                                                                                icon: Icon(
                                                                                                  Icons.remove_circle_outline,
                                                                                                  size: width * 0.05,
                                                                                                  color: Colors.red,
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                        ),
                                                                      ),
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
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(4),
                                                  width: width * 0.2,
                                                  height: height * 0.1,
                                                  child: Material(
                                                    elevation: 6,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            width * 0.04),
                                                    child: Container(
                                                      width: width * 0.2,
                                                      height: height * 0.1,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      width *
                                                                          0.04),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  '${profileController.shopService.value.serviceDetail![position].serviceImage.toString()}'))),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              bestoffer(context),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                width: width,
                                height: height * 0.16,
                                child: ListView.builder(
                                    itemCount: profileController
                                        .couponList.value.staffDetail?.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, position) {
                                      return Container(
                                          width: width * 0.4 + width * 0.05,
                                          height: height * 0.12,
                                          margin: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          child: Stack(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        '  ${profileController.couponList.value.staffDetail?[position].couponName}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins Regular',
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                            color:
                                                                Colors.black),
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
                                                                vertical: 2.0,
                                                                horizontal:
                                                                    10.0),
                                                        color: Color(Utils
                                                            .hexStringToHexInt(
                                                                '#46D0D9')),
                                                        child: Text(
                                                          '${profileController.couponList.value.staffDetail?[position].couponCode}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins Light',
                                                            fontSize: MediaQuery.of(
                                                                        context)
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
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                    onPressed: () {
                                                      profileController
                                                          .removeCoupon(
                                                              "${profileController.couponList.value.staffDetail?[position].id}",
                                                              context);
                                                      profileController
                                                          .couponList
                                                          .value
                                                          .staffDetail!
                                                          .clear();
                                                      //profileController.getCouponList1();
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      size: width * 0.05,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ],
                                          ));
                                    }),
                              ),
                              Divider(
                                thickness: 1,
                                color: Color(Utils.hexStringToHexInt('E6E8EA')),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.06, right: width * 0.06),
                                width: width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Feedbacks',
                                      style: TextStyle(
                                          fontSize: width * 0.03,
                                          color: Colors.black,
                                          fontFamily: 'Poppins Regular'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      'Question 1',
                                      style: TextStyle(
                                          fontSize: width * 0.02,
                                          color: Color(Utils.hexStringToHexInt(
                                              '8D8D8D')),
                                          fontFamily: 'Poppins Regular'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      'How was your experience with our Staff?',
                                      style: TextStyle(
                                          fontSize: width * 0.03,
                                          color: Colors.black,
                                          fontFamily: 'Poppins Regular'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    SizedBox(
                                      width: width,
                                      child: ListView.builder(
                                          itemCount: 1,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          //Optional
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, position) {
                                            return Container(
                                              margin: EdgeInsets.all(6),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Center(
                                                            child: Text(
                                                              '${profileController.feedback.value?.totalRating}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.04,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Poppins Regular'),
                                                            ),
                                                          ),
                                                        ),
                                                        RatingBarIndicator(
                                                          rating:
                                                              profileController
                                                                  .feedback
                                                                  .value
                                                                  .totalRating!
                                                                  .toDouble(),
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                            Icons.star,
                                                            color: Color(Utils
                                                                .hexStringToHexInt(
                                                                    '46D0D9')),
                                                          ),
                                                          itemCount: 5,
                                                          itemSize:
                                                              width * 0.03,
                                                          direction:
                                                              Axis.horizontal,
                                                        ),
                                                        Text(
                                                          '${profileController.feedback.value.ratingDetail?.length}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.02,
                                                              color: Color(Utils
                                                                  .hexStringToHexInt(
                                                                      '8D8D8D')),
                                                              fontFamily:
                                                                  'Poppins Regular'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.1),
                                                  Expanded(
                                                    flex: 3,
                                                    child: SizedBox(
                                                        width: width * 0.8,
                                                        child:
                                                            // ListView.builder(
                                                            //     itemCount: 4,
                                                            //     shrinkWrap: true,
                                                            //     physics:
                                                            //         NeverScrollableScrollPhysics(),
                                                            //     scrollDirection:
                                                            //         Axis.vertical,
                                                            //     itemBuilder: (context,
                                                            //         position) {
                                                            //       return Row(
                                                            //         children: <
                                                            //             Widget>[
                                                            //           Text(
                                                            //             '$position',
                                                            //             textAlign:
                                                            //                 TextAlign
                                                            //                     .center,
                                                            //             style: TextStyle(
                                                            //                 fontSize:
                                                            //                     width *
                                                            //                         0.02,
                                                            //                 color: Colors
                                                            //                     .black,
                                                            //                 fontFamily:
                                                            //                     'Poppins Regular'),
                                                            //           ),
                                                            //           SizedBox(
                                                            //               width: width *
                                                            //                   0.03),
                                                            //           Container(
                                                            //             margin: EdgeInsets.symmetric(
                                                            //                 vertical:
                                                            //                     height *
                                                            //                         0.003),
                                                            //             width: width *
                                                            //                 0.5,
                                                            //             height: 10,
                                                            //             child:
                                                            //                 const ClipRRect(
                                                            //               borderRadius:
                                                            //                   BorderRadius.all(
                                                            //                       Radius.circular(10)),
                                                            //               child:
                                                            //                   LinearProgressIndicator(
                                                            //                 value:
                                                            //                     0.9,
                                                            //                 valueColor: AlwaysStoppedAnimation<
                                                            //                         Color>(
                                                            //                     Colors
                                                            //                         .cyan),
                                                            //                 backgroundColor:
                                                            //                     Color(
                                                            //                         0xffD6D6D6),
                                                            //               ),
                                                            //             ),
                                                            //           )
                                                            //         ],
                                                            //       );
                                                            //     }),
                                                            Column(
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '1',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.02,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Poppins Regular'),
                                                                ),
                                                                SizedBox(
                                                                    width: width *
                                                                        0.03),
                                                                Container(
                                                                  margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          height *
                                                                              0.003),
                                                                  width: width *
                                                                      0.5,
                                                                  height: 10,
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      child: StepProgressIndicator(
                                                                        totalSteps:
                                                                            10,
                                                                        currentStep:
                                                                            oneStar!.length,
                                                                        size: 8,
                                                                        padding:
                                                                            0,
                                                                        selectedColor:
                                                                            Colors.yellow,
                                                                        unselectedColor:
                                                                            Colors.cyan,
                                                                        roundedEdges:
                                                                            Radius.circular(10),
                                                                        selectedGradientColor:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end: Alignment
                                                                              .bottomRight,
                                                                          colors: [
                                                                            Colors.cyan,
                                                                            Colors.cyanAccent
                                                                          ],
                                                                        ),
                                                                        unselectedGradientColor:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end: Alignment
                                                                              .bottomRight,
                                                                          colors: [
                                                                            Colors.grey,
                                                                            Colors.grey
                                                                          ],
                                                                        ),
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '2',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.02,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Poppins Regular'),
                                                                ),
                                                                SizedBox(
                                                                    width: width *
                                                                        0.03),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.003),
                                                                    width:
                                                                        width *
                                                                            0.5,
                                                                    height: 10,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        child: StepProgressIndicator(
                                                                          totalSteps:
                                                                              10,
                                                                          currentStep:
                                                                              twoStar!.length,
                                                                          size:
                                                                              8,
                                                                          padding:
                                                                              0,
                                                                          selectedColor:
                                                                              Colors.yellow,
                                                                          unselectedColor:
                                                                              Colors.cyan,
                                                                          roundedEdges:
                                                                              Radius.circular(10),
                                                                          selectedGradientColor:
                                                                              const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Colors.cyan,
                                                                              Colors.cyanAccent
                                                                            ],
                                                                          ),
                                                                          unselectedGradientColor:
                                                                              const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Colors.grey,
                                                                              Colors.grey
                                                                            ],
                                                                          ),
                                                                        )))
                                                              ],
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '3',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.02,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Poppins Regular'),
                                                                ),
                                                                SizedBox(
                                                                    width: width *
                                                                        0.03),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.003),
                                                                    width:
                                                                        width *
                                                                            0.5,
                                                                    height: 10,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        child: StepProgressIndicator(
                                                                          totalSteps:
                                                                              10,
                                                                          currentStep:
                                                                              threeStar!.length,
                                                                          size:
                                                                              8,
                                                                          padding:
                                                                              0,
                                                                          selectedColor:
                                                                              Colors.yellow,
                                                                          unselectedColor:
                                                                              Colors.cyan,
                                                                          roundedEdges:
                                                                              Radius.circular(10),
                                                                          selectedGradientColor:
                                                                              const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Colors.cyan,
                                                                              Colors.cyanAccent
                                                                            ],
                                                                          ),
                                                                          unselectedGradientColor:
                                                                              const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Colors.grey,
                                                                              Colors.grey
                                                                            ],
                                                                          ),
                                                                        )))
                                                              ],
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '4',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.02,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Poppins Regular'),
                                                                ),
                                                                SizedBox(
                                                                    width: width *
                                                                        0.03),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.003),
                                                                    width:
                                                                        width *
                                                                            0.5,
                                                                    height: 10,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        child: StepProgressIndicator(
                                                                          totalSteps:
                                                                              10,
                                                                          currentStep:
                                                                              fourStar!.length,
                                                                          size:
                                                                              8,
                                                                          padding:
                                                                              0,
                                                                          selectedColor:
                                                                              Colors.yellow,
                                                                          unselectedColor:
                                                                              Colors.cyan,
                                                                          roundedEdges:
                                                                              Radius.circular(10),
                                                                          selectedGradientColor:
                                                                              const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Colors.cyan,
                                                                              Colors.cyanAccent
                                                                            ],
                                                                          ),
                                                                          unselectedGradientColor:
                                                                              const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Colors.grey,
                                                                              Colors.grey
                                                                            ],
                                                                          ),
                                                                        )))
                                                              ],
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '5',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.02,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Poppins Regular'),
                                                                ),
                                                                SizedBox(
                                                                    width: width *
                                                                        0.03),
                                                                Container(
                                                                  margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          height *
                                                                              0.003),
                                                                  width: width *
                                                                      0.5,
                                                                  height: 10,
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      child: StepProgressIndicator(
                                                                        totalSteps:
                                                                            10,
                                                                        currentStep:
                                                                            fiveStar!.length,
                                                                        size: 8,
                                                                        padding:
                                                                            0,
                                                                        selectedColor:
                                                                            Colors.yellow,
                                                                        unselectedColor:
                                                                            Colors.cyan,
                                                                        roundedEdges:
                                                                            Radius.circular(10),
                                                                        selectedGradientColor:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end: Alignment
                                                                              .bottomRight,
                                                                          colors: [
                                                                            Colors.cyan,
                                                                            Colors.cyanAccent
                                                                          ],
                                                                        ),
                                                                        unselectedGradientColor:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end: Alignment
                                                                              .bottomRight,
                                                                          colors: [
                                                                            Colors.grey,
                                                                            Colors.grey
                                                                          ],
                                                                        ),
                                                                      )),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.08,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ));
            }
          }),
        ),
      ),
    );
  }

  Widget bestoffer(
    BuildContext context,
  ) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
        InkWell(
          onTap: () {
            addCoupon(context);
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
                      color: Color(Utils.hexStringToHexInt('46D0D9'))),
                )
              ],
            ),
          ),
        ),
      ],
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
