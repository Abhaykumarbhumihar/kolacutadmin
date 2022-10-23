import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/auth_controller.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import 'package:flutter_picker/flutter_picker.dart';

class RegisterPageTwo extends StatefulWidget {
  const RegisterPageTwo({Key? key}) : super(key: key);

  @override
  State<RegisterPageTwo> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageTwo> {
  AuthControlller authControlller = Get.put(AuthControlller());
  late TextEditingController emailcontroller,
      _ownenamecontroller,
      _owncontactnocontroller,
      _adharnocontroller,
      _genderController,
      _accountnoController,
      _reenteraccountController,
      _banknameController,
      _acountholderController,
      _ifsccodeController;

  //late File shopimagefile;

  // Initial Selected Value
  String dropdownvalue = 'Male';
  final list = ["Apple", "Orange", "Kiwi", "Banana", "Grape"];

  // List of items in our dropdown menu
  var items = ['Male', 'Female'];
  var dropdown;
  var imageFile;
  var age = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailcontroller = TextEditingController();
    _ownenamecontroller = TextEditingController();
    _owncontactnocontroller = TextEditingController();
    _adharnocontroller = TextEditingController();
    _genderController = TextEditingController();

    _accountnoController = TextEditingController();
    _reenteraccountController = TextEditingController();
    _banknameController = TextEditingController();
    _acountholderController = TextEditingController();
    _ifsccodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var one = Get.arguments;
    print(one);
    File shopimagefile = one[0];
    // var shopimage = one[0].toString().substring(5);
    var shopname = one[2].toString();
    var shopEmail = one[1].toString();
    var shopWebsite = one[3].toString();
    var shopAddress = one[4].toString();
    var password = one[5].toString();
    var longitude = one[6];
    var latitude = one[7];
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
              Container(
                width: width * 0.5,
                height: height * 0.2,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: width * 0.5,
                      height: height * 0.2,
                      child: imageFile == null
                          ? Container(
                              width: width * 0.5,
                              height: height * 0.2,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/svgicons/useraddimgpng.png'),
                                      fit: BoxFit.contain)),
                            )
                          : Container(
                              width: width * 0.5,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(imageFile),
                                      fit: BoxFit.fill)),
                            ),
                    ),
                    Positioned(
                      top: height * 0.1 + height * 0.04,
                      right: width * 0.06,
                      child: GestureDetector(
                        onTap: () {
                          _showImageChooser(context);
                        },
                        child: Container(
                          width: width * 0.1,
                          height: height * 0.06,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/svgicons/addphotocircleplus.png'),
                                 )),
                          child: Center(
                            child: SvgPicture.asset(
                              'images/svgicons/adddd.svg',
                              fit: BoxFit.fill,
                              width: width * 0.02,
                              height: height * 0.02,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text("Add profile Photo",
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
                          controller: _ownenamecontroller,
                          decoration: InputDecoration(
                              hintText: 'Name of the Owner ',
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
                            const BorderRadius.all(Radius.circular(4)),
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
                              hintText: 'Email of the owner',
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
                            const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _owncontactnocontroller,
                          decoration: InputDecoration(
                              hintText: 'Contact of the owner ',
                              hintStyle: TextStyle(
                                  color:
                                      Color(Utils.hexStringToHexInt('A4A4A4')),
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              border: InputBorder.none)),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
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
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.number,
                              controller: _genderController,
                              decoration: InputDecoration(
                                hintText: 'Age',
                                hintStyle: TextStyle(
                                    color: Color(
                                        Utils.hexStringToHexInt('A4A4A4')),
                                    fontFamily: 'Poppins Regular',
                                    fontSize: width * 0.03),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          flex: 1,
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
                            child: TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                controller: _adharnocontroller,
                                decoration: InputDecoration(
                                  hintText: 'Aadhar No.',
                                  hintStyle: TextStyle(
                                      color: Color(
                                          Utils.hexStringToHexInt('A4A4A4')),
                                      fontFamily: 'Poppins Regular',
                                      fontSize: width * 0.03),
                                  border: InputBorder.none,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Bank information',
                        style: TextStyle(
                            color: Color(
                                Utils.hexStringToHexInt('A4A4A4')),
                            fontFamily: 'Poppins Regular',
                            fontSize: width * 0.03),),
                      ],
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
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _accountnoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Account no ',
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
                        const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _reenteraccountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Re enter account no ',
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
                        const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _banknameController,
                          decoration: InputDecoration(
                              hintText: 'Bank name ',
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
                        const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _acountholderController,
                          decoration: InputDecoration(
                              hintText: 'Account holder name ',
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
                        const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _ifsccodeController,
                          decoration: InputDecoration(
                              hintText: 'IFSC code ',
                              hintStyle: TextStyle(
                                  color:
                                  Color(Utils.hexStringToHexInt('A4A4A4')),
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              border: InputBorder.none)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if (validate()) {
                    var emailOwner = emailcontroller.text.toString();
                    var nameOwner = _ownenamecontroller.text.toString();
                    var ownercontact = _owncontactnocontroller.text.toString();
                    var adharno = _adharnocontroller.text.toString();
                    var accountnno= _accountnoController.text.toString();
                    var reaccountno= _reenteraccountController.text.toString();
                    var bankname= _banknameController.text.toString();
                    var accountholder= _acountholderController.text.toString();
                    var ifscode= _ifsccodeController.text.toString();
                    // shopimagefile=shopimage;
                    print(shopimagefile);
                    //  CommonDialog.showsnackbar("Hit here api");
                    authControlller.registerUser(
                        shopname,
                        shopEmail,
                        "Unisex",
                        shopAddress,
                        '78.5',
                        '8.5',
                        nameOwner,
                        emailOwner,
                        _genderController.text.toString() + "",
                        ownercontact,
                        "ANDROID",
                        "SDFSDFD",
                        password,
                        shopimagefile,
                        imageFile,
                        adharno,
                        accountnno,
                        ifscode,
                        accountholder,
                        bankname
                    );
                    //account_number,
                    //   ifsc_code,
                    //   account_name,
                    //   bank_name
                  } else {
                    // CommonDialog.showsnackbar("Hit here api");
                  }

                  //showLoaderDialog(context);
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

  showLoaderDialog(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.04)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(width * 0.06),
                    child:
                        SvgPicture.asset('images/svgicons/dialogcolosesv.svg'),
                    width: width * 0.08,
                    height: height * 0.05,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: width * 0.03),
                  child: Text(
                    'Your profile is under review.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins Medium',
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: width * 0.06),
                  child: Text(
                    'We will get back to you with updates on your \nregistered mail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(Utils.hexStringToHexInt('C4C4C4')),
                        fontFamily: 'Poppins Regular',
                        fontSize: MediaQuery.of(context).size.width * 0.03),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
              RaisedButton.icon(
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
              RaisedButton.icon(
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
      imageFile = image;
      if (image != null) {
        /*todo---this is for use image rotation stop*/
        File rotatedImage =
            await FlutterExifRotation.rotateAndSaveImage(path: image.path);

        setState(() {
          imageFile = rotatedImage;
        });
      }
      Navigator.of(context).maybePop();
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
    var name = _ownenamecontroller.text.toString();
    var ownercontact = _owncontactnocontroller.text.toString();
    var adharno = _adharnocontroller.text.toString();
   var accountnno= _accountnoController.text.toString();
   var reaccountno= _reenteraccountController.text.toString();
   var bankname= _banknameController.text.toString();
   var accountholder= _acountholderController.text.toString();
   var ifscode= _ifsccodeController.text.toString();
    if (name == "") {
      CommonDialog.showsnackbar("Please enter name.");
      return false;
    } else if (email == "" || email == null) {
      CommonDialog.showsnackbar("Please enter email");
      return false;
    } else if (!isEmail(email)) {
      CommonDialog.showsnackbar("Please enter valid email ");
      return false;
    } else if (ownercontact == "" || ownercontact == null) {
      CommonDialog.showsnackbar("Please enter contact no. ");
      return false;
    } else if (imageFile == null) {
      CommonDialog.showsnackbar("Please choose image.");
      return false;
    } else if (adharno == "") {
      CommonDialog.showsnackbar("Please enter adhar no");
      return false;
    } else if (_genderController.text.toString() == "") {
      CommonDialog.showsnackbar("Please select dob.");
      return false;
    }else if(accountnno==""){
      CommonDialog.showsnackbar("Please enter account no.");
      return false;
    }else if(reaccountno==""){
      CommonDialog.showsnackbar("Please Re-enter account no.");
      return false;
    }else if(bankname==""){
      CommonDialog.showsnackbar("Please enter bank name");
      return false;
    }else if(accountholder==""){
      CommonDialog.showsnackbar("Please enter account holder name");
      return false;
    }else if(ifscode==""){
      CommonDialog.showsnackbar("Please enter IFSC code");
      return false;
    }else if(accountnno!=reaccountno){
      CommonDialog.showsnackbar("Account no and Re-account no not mathced");
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

  showPickerNumber(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 18, end: 80),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          age = picker.getSelectedValues().toString();
          print(picker.getSelectedValues());
        }).showDialog(context);
  }
}
