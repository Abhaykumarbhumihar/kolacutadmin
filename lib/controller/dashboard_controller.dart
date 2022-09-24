import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/model/DashboardPojo.dart';
import 'package:kolacur_admin/model/Graphpojjo.dart';
import 'package:kolacur_admin/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/NotificationPojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class DashboardController extends GetxController {
  var dashboardPojo = DashboardPojo().obs;
  final List<String> data = [];
  var lodaer = true;
  final box = GetStorage();
  var sessionId = "".obs;
  var notification = NotificationPojo().obs;
  var graphPojo = Graphpojjo().obs;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();

    var session = prefs.getString('session');
    sessionId.value = session!;
    update();
  }

  void cleanData() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('session');
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
    Future.delayed(Duration(seconds: 2), () {
      getDashboardData();
      getNotificationList();
      getChart();
    });
  }

  void getDashboardData() async {
    Map map;
    map = {"session_id": sessionId.value};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.DASHBOARD_DATA);
      print(response);
      CommonDialog.hideLoading();
      if (response != "null") {
        print("CODE IS RUNNING HERE");
        dashboardPojo.value = dashboardPojoFromJson(response);
        update();
        lodaer = false;
      } else {
        print("CODE IS RUNNING HERE");
        cleanData();
        Get.off(LoginPage());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void getNotificationList() async {
    Map map;
    map = {"session_id": sessionId.value};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      lodaer = true;
      final response =
          await APICall().registerUrse(map, AppConstant.NOTIFICAITON);
      // print(response);
      //print("kjkjkljljlkjlkljkljkljhjgyuyyghgh");
      if (notification.value.message == "No Data found") {
      } else {
        notification.value = notificationPojoFromJson(response);
        update();
          lodaer = false;
      }
    } catch (error) {
      //CommonDialog.hideLoading();
    }
  }

  void getChart() async {
    Map map;
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
      await APICall().registerUrseWithoutbody("public/api/get-data");
      print(response);
      CommonDialog.hideLoading();
      if (response != "null") {
        // print("CODE IS RUNNING HERE");
        graphPojo.value = graphpojjoFromJson(response);
        update();
        //lodaer = false;
      } else {
        print("CODE IS RUNNING HERE");
        cleanData();
        Get.off(LoginPage());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }
}
