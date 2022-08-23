import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/model/LoginPojo.dart';
import 'package:kolacur_admin/model/RegisterPojo.dart';
import 'package:kolacur_admin/screen/homebottombar.dart';
import 'package:kolacur_admin/screen/login.dart';

import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class AuthControlller extends GetxController {
  var registerPojo = RegisterPojo().obs;
  var loginPojo = LoginPojo().obs;
  var message = "";
  var phoneno = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String sendData() {
    print(message);
    return message;
  }

  String sendphone() {
    return phoneno;
  }

  void login(email, password) async {
    Map map;
    String? fcm_token = await FirebaseMessaging.instance.getToken();

    map = {
      "email": email,
      "password": password,
      "device_token": "123456",
      "device_type": "$fcm_token"
    };

    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.SEND_OTP);
      print(response);
      CommonDialog.hideLoading();
     

      loginPojo.value = loginPojoFromJson(response);
      if (loginPojo.value.message ==
          "The password must not be greater than 20 characters. ") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        box.write('session',   loginPojo.value.data?.token);
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('session', loginPojo.value.data!.token.toString());
        await prefs.setString('name', loginPojo.value.data!.name.toString());
        await prefs.setString('email', loginPojo.value.data!.email.toString());
        await prefs.setString('phoneno', loginPojo.value.data!.ownerPhoneNo.toString());
        await prefs.setString('image', loginPojo.value.data!.ownerProfileImage.toString());
        Get.to(const HomeBottomBar());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void registerUser(
      shop_name,
      email,
      shop_type,
      address,
      latitude,
      longitude,
      owner_name,
      owner_email,
      age,
      owner_phone_no,
      device_type,
      device_token,
      password,
      logo,
      owner_profile_image,
      adhaar_card_file) async {
    CommonDialog.showLoading(title: "Please waitt...");
    final response = await APICall().registerUserMulti(
        shop_name,
        email,
        shop_type,
        address,
        latitude,
        longitude,
        owner_name,
        owner_email,
        age,
        owner_phone_no,
        device_type,
        device_token,
        password,
        logo,
        owner_profile_image,
        adhaar_card_file);
    print("jjhjkjjhkjkhkjhkhkhkjjkhkhkkhhkjkjjk");
    if (response != "null") {
      CommonDialog.hideLoading();
      registerPojo.value = registerPojoFromJson(response);
      CommonDialog.showsnackbar(registerPojo.value.message);
      Get.off(LoginPage());
    } else {
      CommonDialog.showsnackbar("Somthing wrong");
    }
  }
}
