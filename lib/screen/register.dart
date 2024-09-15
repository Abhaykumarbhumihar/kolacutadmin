import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:kolacur_admin/screen/registertwo.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   TextEditingController emailcontroller,
      _namecontroller,
      _websitecontroller,
      _addresscontroller,
      _passwordcontroller;
  var imageFile;
  var latitude = 0.0;
  var longitude = 0.0;

  // Initial Selected Value
  final list = ["Unisex", "Male", "Female"];
  var selectSalong = "unisex";

  // List of items in our dropdown menu
  var items = ['Male', 'Female'];
  var dropdown;
  var showselectGender = "";
   GooglePlace googlePlace;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
   Position _currentPosition;
  String _currentAddress = "";
  bool _isLoading = true;

  List<AutocompletePrediction> predictions = [];

  List<DropdownMenuItem<String>> _createList() {
    return list
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        if (kDebugMode) {
          print(_currentPosition);
        }
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  void getDetils(String placeId) async {
    var result = await this.googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        var detailsResult = result.result;
        print(detailsResult.name);
        print(detailsResult.formattedAddress);
        print(detailsResult.adrAddress);
        print(detailsResult.scope);
        print(detailsResult.name);
        _currentAddress = detailsResult.name;

        //print(detailsResult.geometry!.location!.lat);
        //print( detailsResult.geometry!.location!.lat);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    String apiKey = "AIzaSyAIFnj6QxWUHPj3M086GFxMBPJrR6NePE8";
    googlePlace = GooglePlace(apiKey);
    super.initState();

    emailcontroller = TextEditingController();
    _namecontroller = TextEditingController();
    _websitecontroller = TextEditingController();
    _addresscontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/svgicons/dottedbackground.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.04,
              ),
              const Center(
                child: Text(
                  'Kolacut',
                  style: TextStyle(fontFamily: 'Poppins Regular'),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  _showImageChooser(context);
                },
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(width * 0.04),
                  child: Container(
                    width: width * 0.6,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                        borderRadius: BorderRadius.circular(width * 0.04)),
                    child: Center(
                        child: imageFile == null
                            ? Image.asset(
                                'images/svgicons/uploadpn.png',
                                width: width * 0.06,
                                height: height * 0.06,
                              )
                            : Material(
                                borderRadius:
                                    BorderRadius.circular(width * 0.4),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.04)),
                                  child: Image.file(
                                    imageFile,
                                    fit: BoxFit.cover,
                                    width: width * 0.6,
                                    height: height * 0.2,
                                  ),
                                ),
                              )),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text("Upload pictures",
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
              Utils().titleTextsemibold('Register Now', context),
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: Text(
                  'Please enter the details below to continue',
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
                margin:
                    EdgeInsets.only(left: width * 0.08, right: width * 0.08),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: width - 5,
                      height: height * 0.1 - height * 0.04,
                      padding: const EdgeInsets.only(left: 6),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _namecontroller,
                          decoration: InputDecoration(
                              hintText: 'Name of the Salon',
                              hintStyle: TextStyle(
                                  color:
                                      Color(Utils.hexStringToHexInt('A4A4A4')),
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
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(4)),
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
                                  color:
                                      Color(Utils.hexStringToHexInt('A4A4A4')),
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
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _websitecontroller,
                          decoration: InputDecoration(
                              hintText: 'Website',
                              hintStyle: TextStyle(
                                  color:
                                      Color(Utils.hexStringToHexInt('A4A4A4')),
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              border: InputBorder.none)),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            bool showSublist =
                                false; // Declare your variable outside the builder

                            bool showmainList = true;
                            var mainlistPosition = 0;
                            var bntname = "Add";
                            return AlertDialog(
                              title: Text("Search your location"),
                              content: StatefulBuilder(
                                // You need this, notice the parameters below:
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Container(
                                    width: width,
                                    height: height * 0.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: "Search",
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              setState(() {
                                                autoCompleteSearch(value);
                                              });
                                            } else {
                                              if (predictions.length > 0 &&
                                                  mounted) {
                                                setState(() {
                                                  predictions = [];
                                                });
                                              }
                                            }
                                          },
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: 0.5,
                                            maxHeight: height * 0.3,
                                          ),
                                          child: ListView.builder(
                                            itemCount: predictions.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: const CircleAvatar(
                                                  child: Icon(
                                                    Icons.pin_drop,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                title: Text(
                                                  predictions[index]
                                                      .description
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    debugPrint(
                                                        predictions[index]
                                                            .placeId);
                                                    getDetils(predictions[index]
                                                        .placeId);
                                                    Navigator.pop(context);
                                                  });
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) => DetailsPage(
                                                  //       placeId: predictions[index].placeId.toString(),
                                                  //       googlePlace: googlePlace, key: null,
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                              );
                                            },
                                          ),
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
                          children: [
                            Text(
                              "${_currentAddress==""?"Address":_currentAddress}",
                              style: TextStyle(
                                  color:
                                  _currentAddress==""? Color(Utils.hexStringToHexInt('A4A4A4')):Colors.black,
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
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
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                controller: _passwordcontroller,
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('A4A4A4')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                    border: InputBorder.none)),
                          ),
                          const SizedBox(width: 10.0),
                          // const Icon(Icons.settings),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: width - 5,
                                      height: height * 0.1 - height * 0.04,
                                      margin: const EdgeInsets.only(top: 6),
                                      padding: const EdgeInsets.only(left: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(4)),
                                        color: Color(
                                            Utils.hexStringToHexInt('F4F4F4')),
                                      ),
                                      child: DropdownButton(
                                        icon: const Icon(null),
                                        hint: Text(
                                          "${showselectGender == "" ? "Unisex" : showselectGender}",
                                          style: TextStyle(
                                              color: Color(
                                                  Utils.hexStringToHexInt(
                                                      'A4A4A4')),
                                              fontFamily: 'Poppins Regular',
                                              fontSize: width * 0.03),
                                        ),
                                        items: _createList(),
                                        onChanged: (value) {
                                          setState(() {
                                            showselectGender = value.toString();
                                            if (value == "Male") {
                                              selectSalong = "unisex";
                                              print(selectSalong);
                                            } else if (value == "Female") {
                                              selectSalong = "unisex";
                                              print(selectSalong);
                                            }
                                          });
                                        },
                                      ),

                                      // TextField(
                                      //     style: TextStyle(
                                      //       color: Colors.black,
                                      //     ),
                                      //     controller: emailcontroller,
                                      //     decoration: InputDecoration(
                                      //         hintText: 'Gender',
                                      //         hintStyle: TextStyle(
                                      //             color: Color(
                                      //                 Utils.hexStringToHexInt('A4A4A4')),
                                      //             fontFamily: 'Poppins Regular',
                                      //             fontSize: width * 0.05),
                                      //         border: InputBorder.none,
                                      //         suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)),
                                      // ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Container(
                                  //     width: width - 5,
                                  //     height: height * 0.1 - height * 0.04,
                                  //     margin: const EdgeInsets.only(top: 6),
                                  //     padding: const EdgeInsets.only(left: 6),
                                  //     decoration: const BoxDecoration(
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.circular(4)),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: height * 0.02,
                                right: 6,
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.grey,
                                  size: 24,
                                ))
                          ],
                        ),
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
                  if (validate()) {
                    var email = emailcontroller.text.toString();
                    var name = _namecontroller.text.toString();
                    var website = _websitecontroller.text.toString();

                    var passowrd = _passwordcontroller.text.toString();

                    Get.to(const RegisterPageTwo(), arguments: [
                      imageFile as File,
                      email + "",
                      name + "",
                      website + "",
                      _currentAddress + "",
                      passowrd,
                      longitude,
                      latitude
                    ]);
                  }
                },
                child: Container(
                  width: width * 0.5,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.08),
                      color: Color(Utils.hexStringToHexInt('46D0D9'))),
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
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    ));
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
          width: MediaQuery.of(context).size.width,
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


              TextButton.icon(
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
              TextButton.icon(
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

  bool validate() {
    var email = emailcontroller.text.toString();
    var name = _namecontroller.text.toString();
    var website = _websitecontroller.text.toString();
    var passowrd = _passwordcontroller.text.toString();
    if (name == "") {
      CommonDialog.showsnackbar("Please enter name.");
      return false;
    } else if (email == "" || email == null) {
      CommonDialog.showsnackbar("Please enter email");
      return false;
    } else if (!isEmail(email)) {
      CommonDialog.showsnackbar("Please enter valid email ");
      return false;
    } else if (website == "" || website == null) {
      CommonDialog.showsnackbar("Please enter website url. ");
      return false;
    } else if (imageFile == null) {
      CommonDialog.showsnackbar("Please choose image.");
      return false;
    } else if (_currentAddress == "") {
      CommonDialog.showsnackbar("Please enter address");
     return false;
    } else if (passowrd == "") {
      CommonDialog.showsnackbar("Please enter password");
     return false;
    }
    return true;
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
