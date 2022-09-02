import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kolacur_admin/controller/manage_staff_controller.dart';

import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../controller/auth_controller.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _RegisterPageState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class _RegisterPageState extends State<AddEmployee> {
  ManageStaffController profileController = Get.put(ManageStaffController());
  late TextEditingController emailcontroller,
      _nameController,
      _dobController,
      _phonecontroller,
      _addressController,
      _skillController,
      _passwordController,
  _experienceController;
  String date = "";
  late Map<String, bool> values;

  String dropdownvalue = 'Male';
  final list = ['Male', 'Female'];
  final list1 = [
    {'Male', false},
    {'fMale', false}
  ];
  var skilllist = "";
  var imageFile;
  DateTime selectedDate = DateTime.now();
  var genderSelect = "";
  var dob = "";
  var dropdown;
  var showselectGender = "";

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

  static List<Animal> _animals = [
    Animal(id: 1, name: "Haircut"),
    Animal(id: 2, name: "Facewash"),
    Animal(id: 3, name: "Blow Dry"),
    Animal(id: 4, name: "Body Wave"),
    Animal(id: 5, name: "Bridal Trial"),
    Animal(id: 6, name: "Bridal Makeup"),
    Animal(id: 7, name: "Nail Paint"),
  ];
  List<Animal> _selectedAnimals2 = [];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailcontroller = TextEditingController();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _phonecontroller = TextEditingController();
    _addressController = TextEditingController();
    _skillController = TextEditingController();
    _passwordController = TextEditingController();
    _experienceController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              ///////
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
                                      fit: BoxFit.contain)),
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
                                  fit: BoxFit.fill)),
                          child: Center(
                            child: SvgPicture.asset(
                              'images/svgicons/adddd.svg',
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
              Text("Add employee \nprofile Photo",
                  style: TextStyle(
                    color: Color(Utils.hexStringToHexInt('77ACA2')),
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins Medium',
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: height * 0.1,
              ),
              Utils().titleTextsemibold('Add Employee', context),
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: Text(
                  'Please enter the details below to add \nemployee',
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
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: 'Name',
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
                            const BorderRadius.all(Radius.circular(4)),
                        color: Color(Utils.hexStringToHexInt('F4F4F4')),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _phonecontroller,
                          decoration: InputDecoration(
                              hintText: 'Phone',
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
                          controller: _addressController,
                          decoration: InputDecoration(
                              hintText: 'Address',
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
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
                          controller: _experienceController,
                          decoration: InputDecoration(
                              hintText: 'Experience',
                              hintStyle: TextStyle(
                                  color:
                                  Color(Utils.hexStringToHexInt('A4A4A4')),
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.03),
                              border: InputBorder.none)),
                    ),
                    //  builhhd(context),
                    GestureDetector(
                      onTap: () {
                        //Get.bottomSheet();
                      },
                      child: Container(
                        width: width - 5,
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color: Color(Utils.hexStringToHexInt('F4F4F4')),
                        ),
                        child: Column(
                          children: <Widget>[
                            MultiSelectBottomSheetField(
                              initialChildSize: 0.4,
                              listType: MultiSelectListType.CHIP,
                              searchable: false,
                              buttonText: Text("Select Skills"),
                              title: Text("Skills.."),
                              items: _items,
                              onConfirm: (values) {
                                setState(() {
                                  skilllist = "";
                                  List<String> list = [];
                                  values.forEach((element) {
                                    var a = element as Animal;
                                    list.add(a.name);
                                  });
                                  // print(list.join(","));
                                  skilllist = list.join(",");
                                  print(skilllist);
                                });
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                onTap: (value) {
                                  setState(() {
                                    _selectedAnimals2.remove(value);
                                  });
                                },
                              ),
                            ),
                            skilllist == "" || skilllist.isEmpty
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Select skills",
                                      style: TextStyle(color: Colors.black54),
                                    ))
                                : Container(),
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
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: 'Password',
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
                // session_id,
                //       name,
                //       email,
                //       address,
                //       skills,
                //       password,
                //       phone_number,
                //       image
                onTap: () {
                  var exp=_experienceController.text.toString()+"";
                  var name=_nameController.text.toString()+"";
                  var email=emailcontroller.text.toString()+"";
                  var address=_addressController.text.toString()+"";
                  var pass=_passwordController.text.toString()+"";
                  var phone=_phonecontroller.text.toString()+"";
                  if(exp==""||name==""||email==""||address==""||pass==""||phone==""||skilllist==""){
                    CommonDialog.showsnackbar("All fileds are mandatory");
                  }else{
                    profileController.appEmployee(
                        _experienceController.text.toString()+"",
                        _nameController.text.toString() + "",
                        emailcontroller.text.toString() + "",
                        _addressController.text.toString() + "",
                        skilllist + "",
                        _passwordController.text.toString() + "",
                        _phonecontroller.text.toString() + "",
                        imageFile);
                  }

                },
                child: Container(
                  width: width * 0.5,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.08),
                      color: Color(Utils.hexStringToHexInt('77ACA2'))),
                  child: Center(
                    child: Text(
                      'Add Employee..',
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
            ],
          ),
        ),
      ),
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
        Navigator.of(context).maybePop();
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != "") {
      setState(() {
        var outputFormat = DateFormat('yyyy-MM-dd');
        dob = outputFormat.format(selected);
      });
    } else {
      print(selected);
    }
  }

  bool validate() {
    var email = emailcontroller.text.toString();
    var name = _nameController.text.toString();
    var phone = _phonecontroller.text.toString();
    if (name == "") {
      CommonDialog.showsnackbar("Please enter name.");
      return false;
    } else if (email == "" || email == null) {
      CommonDialog.showsnackbar("Please enter email");
      return false;
    } else if (!isEmail(email)) {
      CommonDialog.showsnackbar("Please enter valid email ");
      return false;
    } else if (phone == "" || phone == null) {
      CommonDialog.showsnackbar("Please enter phone no. ");
      return false;
    } else if (!GetUtils.isPhoneNumber(emailcontroller.text.toString())) {
      CommonDialog.showsnackbar("Please enter valid mobile no");
    } else if (imageFile == null) {
      CommonDialog.showsnackbar("Please choose image.");
      return false;
    } else if (dob == "") {
      CommonDialog.showsnackbar("Please select dob.");
      return false;
    } else if (showselectGender == "") {
      CommonDialog.showsnackbar("Please select gender.");
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
