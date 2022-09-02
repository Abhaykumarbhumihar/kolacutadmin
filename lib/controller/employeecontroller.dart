import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/model/EmployeeProfilePojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class EmployeeController extends GetxController {
  var employeeListPojo = EmployeeProfilePojo().obs;
  var employee_Id = "".obs;
  List<LeaveManagement>? leaveManagement = [];
  var lodaer = true;
  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getEmployeeList(box.read('session'));
  }

  void filterStatus(selectedDate) {
    leaveManagement = [];
    update();
    if (selectedDate == "All") {
      leaveManagement = employeeListPojo.value.data!.leaveManagement!;
      update();
    } else {
      var newlist = employeeListPojo.value.data!.leaveManagement!
          .where((x) => x.holidayType
          .toString()
          .toLowerCase()
          .contains(selectedDate.toLowerCase()))
          .toList();
      leaveManagement = newlist;
      update();
    }

    update();
    print("here pring ${selectedDate}");
  }

  void getEmployeeList(session_id) async {
    Map map;
    map = {"session_id": session_id, "employee_id": employee_Id.toString()};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_EMPLOYEE_PROFILE);
      print(response);
      CommonDialog.hideLoading();
      employeeListPojo.value = employeeProfilePojoFromJson(response);
      leaveManagement = employeeListPojo.value.data!.leaveManagement;
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
  void getUpdatedEmplyData()async {
    Map map;
    map = {"session_id": box.read('session'), "employee_id": employee_Id.toString()};
    try {
    //  CommonDialog.showLoading(title: "Please waitt...");
      final response =
      await APICall().registerUrse(map, AppConstant.GET_EMPLOYEE_PROFILE);
      print(response);
    //  CommonDialog.hideLoading();
      employeeListPojo.value = employeeProfilePojoFromJson(response);
      update();
      if (employeeListPojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        update();
       // lodaer = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }
  //session_id:XKWzIHxATfaHdqQotkxWWW7V3ddeYHdp
  // status:0
  // employee_id:1
  void enabeDesable(status,context) async {
    Map map;
    map = {"session_id": box.read('session'), "status": status.toString(),
      "employee_id":employee_Id.toString()
    };
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
      await APICall().registerUrse(map, AppConstant.ENABLE_DESABLE);
      print(response);

      Navigator.pop(context);
      getUpdatedEmplyData();
      update();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }
}
