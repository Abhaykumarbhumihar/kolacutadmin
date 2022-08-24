import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import '../model/LoginOtp.dart';
import '../model/RegisterPojo.dart';
import '../model/VerifyOtp.dart';
import '../screen/homebottombar.dart';
import '../screen/verifyOtp.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class AuthControlller extends GetxController {
  var veryfiOtp = VerifyOtp().obs;
  var loginPojo = LoginOtp().obs;
  var registerPojo = RegisterPojo().obs;
  var box = GetStorage();
  var message = "";
  var phoneno = "";

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

  void login(phone) async {
    Map map;
    map = {"phone": phone};
    phoneno = phone;
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.SEND_OTP);
      CommonDialog.hideLoading();
      print("SDF SDF SDF DF ");
      print(response);
      final body = json.decode(response);

      if (body['status'] == 400) {
        CommonDialog.showsnackbar("No user found");
      } else {


        loginPojo.value = loginOtpFromJson(response);

        CommonDialog.showsnackbar(loginPojo.value.otp.toString());
        Get.to(const VerifyOtpPage(), arguments: phoneno);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void verifyOtp(otp) async {
    Map map;
    print(phoneno);
    String? fcm_token = await FirebaseMessaging.instance.getToken();

    map = {
      "phone": phoneno,
      "otp": otp,
      "device_type": "android",
      "device_token": fcm_token
    };
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.VERIFY_OTP);
      print(response);
      print("SDF SDF SDF SDF SDF ");
      CommonDialog.hideLoading();
      final body = json.decode(response);
      if (body['status'] == 400) {
        CommonDialog.showsnackbar("Wrong OTP");
      } else {
        registerPojo.value = registerPojoFromJson(response);
        CommonDialog.showsnackbar(registerPojo.value.message);
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('session', registerPojo.value.data!.token.toString());
        await prefs.setString('name', registerPojo.value.data!.name.toString());
        await prefs.setString('email', registerPojo.value.data!.email.toString());
        await prefs.setString('phoneno', registerPojo.value.data!.phone.toString());
        await prefs.setString('image', registerPojo.value.data!.profileImage.toString());
        box.write('session', registerPojo.value.data?.token);
        Get.off(MainPage());
      }

      //  Get.to(VerifyOtpPage());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void registerUser(
      image, name, email, dob, gender, phone, device_type, device_token,context) async {
    CommonDialog.showLoading(title: "Please waitt...");
    final response = await APICall().registerUserMulti(
        image, name, email, dob, gender, phone, device_type, device_token);
    print("jjhjkjjhkjkhkjhkhkhkjjkhkhkkhhkjkjjk");

    Navigator.pop(context);
    if(response!=null){
      final body = json.decode(response);
      if(body["status"]==200){
        CommonDialog.showsnackbar(body["message"]);
        Navigator.pop(context);
      }else{
        CommonDialog.showsnackbar(body["message"]);

      }

    }

    // if (response != "null") {
    //   registerPojo.value = registerPojoFromJson(response);
    //   CommonDialog.showsnackbar(registerPojo.value.message ?? "");
    // }
  }
}
