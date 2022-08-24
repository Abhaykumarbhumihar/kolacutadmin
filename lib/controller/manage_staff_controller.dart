import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/model/EmployeeList.dart';
import 'package:kolacur_admin/model/LoginPojo.dart';
import 'package:kolacur_admin/model/RegisterPojo.dart';
import 'package:kolacur_admin/screen/homebottombar.dart';

import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class ManageStaffController extends GetxController {
  var registerPojo = RegisterPojo().obs;
  final List<String> data = [];
  List<StaffDetail>? staffDetail = [];
  var employeeListPojo = EmployeeList().obs;
  var loginPojo = LoginPojo().obs;
  var message = "";
  var phoneno = "";
  var lodaer = true;
  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void filterStatus(selectedDate) {
    if (selectedDate == "All") {
      staffDetail = employeeListPojo.value.staffDetail!;
      update();
    } else {
      var newlist = employeeListPojo.value.staffDetail!
          .where((x) => x.isDuty
              .toString()
              .toLowerCase()
              .contains(selectedDate.toLowerCase()))
          .toList();
      staffDetail = newlist;
      update();
    }

    update();
    print("here pring ${selectedDate}");

  }

  void filterEmplist(text) {
    print(text);
    if (text.toString().trim() == "") {
      staffDetail = employeeListPojo.value.staffDetail!;
      update();
    } else {
      var newList = employeeListPojo.value.staffDetail!
          .where((t) => t.name!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      staffDetail = newList;
      update();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getEmployeeList(box.read('session'));
  }

  void getEmployeeList(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_EMPLOYEE_LIST);
      print(response);
      CommonDialog.hideLoading();
      employeeListPojo.value = employeeListFromJson(response);
      if (employeeListPojo.value.staffDetail!.isNotEmpty) {
        staffDetail = employeeListPojo.value.staffDetail!;
      }

      if (employeeListPojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        update();
        lodaer = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void getUpdatedEmployeeList(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_EMPLOYEE_LIST);
      print(response);
      CommonDialog.hideLoading();
      employeeListPojo.value = employeeListFromJson(response);
      if (employeeListPojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        update();
        lodaer = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void appEmployee(experience, name, email, address, skills, password,
      phone_number, image) async {
    data.add("Hair cut");
    data.add("Hair color");
    data.add("Nail cut");
    data.add("Nail Paint cut");
    CommonDialog.showLoading(title: "Please waitt...");
    final response = await APICall().AddEmployee(
        experience,
        box.read('session'),
        name,
        email,
        address,
        skills,
        password,
        phone_number,
        image);
    print("jjhjkjjhkjkhkjhkhkhkjjkhkhkkhhkjkjjk");
    CommonDialog.hideLoading();
    if (response != "null") {
      Get.back();
      lodaer = false;
      getUpdatedEmployeeList(box.read('session'));
      update();
    }
  }
}
