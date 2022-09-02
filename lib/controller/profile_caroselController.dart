import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/model/AddCouponPojo.dart';
import 'package:kolacur_admin/model/AdminServicePojo.dart';
import 'package:kolacur_admin/model/CouponPojo.dart';
import 'package:kolacur_admin/model/DeleteCoupon.dart';
import 'package:kolacur_admin/model/FeedbackBojo.dart';
import 'package:kolacur_admin/model/ShopProfileePojo.dart';

import '../model/ShopServicePojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class ProfileCOntroller extends GetxController {
  var adminServicePojo = AdminServicePojo().obs;
  var shopproflePojo = ShopProfileePojo().obs;
  var couponList = CouponPojo().obs;
  var couponDeletePojo = DeleteCoupon().obs;
  var addCouponPojo = AddCouponPojo().obs;
  var shopService = ShopServicePojo().obs;
  var feedback = FeedbackBojo().obs;
  var lodaer = true;
  final box = GetStorage();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getShopProfile(box.read('session'));
  }

  void getAdminService(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.ADMIN_SERVICE);
      print(response);
      //   CommonDialog.hideLoading();
      adminServicePojo.value = adminServicePojoFromJson(response);
      getShopService(box.read('session'));

      update();
      if (adminServicePojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());

        //   lodaer = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      //CommonDialog.hideLoading();
    }
  }

  void getCouponList() async {
    Map map;
    map = {"session_id": box.read('session')};
    try {
      //  CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.COUPON_LIST);

      print(response);
      // CommonDialog.hideLoading();
      couponList.value = couponPojoFromJson(response);
      getFeedback();
      update();

      if (couponList.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }

  void removeCoupon(coupon_id, context) async {
    Map map;
    map = {
      "session_id": box.read('session'),
      "coupon_id": coupon_id.toString()
    };
    try {
      final response =
          await APICall().registerUrse(map, AppConstant.DELETE_COUPON);
      print(response);

      couponDeletePojo.value = deleteCouponFromJson(response);
      if (couponDeletePojo.value.status != 200) {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        // lodaer = false;
        CommonDialog.showsnackbar("${couponDeletePojo.value.message}");
        getCouponList1();
        update();
        //getCouponList();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }

  //session_id:IkqpU2Die0T9OCwAgJ6ns5fleMvBepe6
  // sub_service_id:1,2

  void removeService(sub_service_id, context) async {
    Map map;
    map = {
      "session_id": box.read('session'),
      "sub_service_id": sub_service_id.toString()
    };
    try {
      final response =
          await APICall().registerUrse(map, AppConstant.DELETE_ADD_SERVICE);
      print(response);

      couponDeletePojo.value = deleteCouponFromJson(response);
      if (couponDeletePojo.value.status != 200) {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        // lodaer = false;
        CommonDialog.showsnackbar("${couponDeletePojo.value.message}");
        update();
        getShopService(box.read('session'));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }

  void getCouponList1() async {
    Map map;
    map = {"session_id": box.read('session')};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.COUPON_LIST);
      print("CODE RUNNING HERE");
      print(response);
      // CommonDialog.hideLoading();

      couponList.value = couponPojoFromJson(response);
      //couponList.value.staffDetail=couponPojoFromJson(response).staffDetail;
      print("I M HERE");

      update();

      if (couponList.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());

      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }

  void getFeedback() async {
    Map map;
    map = {"session_id": box.read('session')};
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_FEEDBACK);
      print("CODE RUNNING HERE");
      print(response);
      // CommonDialog.hideLoading();
      feedback.value = feedbackBojoFromJson(response);
      print("I M HERE");
      lodaer = false;
      update();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }

  void getShopProfile(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      lodaer = true;
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.SHOP_PROFILE);
      print(response);

      shopproflePojo.value = shopProfileePojoFromJson(response);
      getAdminService(box.read('session'));
      update();
      if (shopproflePojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      print("SDF SDF SDF SDF SDF SDF SD FDS F SDFDSFDSFSD $error");
      //lodaer = false;
    }
    CommonDialog.hideLoading();
  }

  void getUpdatedShopProfile(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.SHOP_PROFILE);
      print(response);

      shopproflePojo.value = shopProfileePojoFromJson(response);
      update();
      if (shopproflePojo.value.message == "No Data found") {
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
      print("SDF SDF SDF SDF SDF SDF SD FDS F SDFDSFDSFSD $error");
      //lodaer = false;
    }
    // CommonDialog.hideLoading();
  }

  void addCoupon(price, name) async {
    Map map;
    map = {
      "session_id": box.read('session'),
      "coupon_name": name,
      "price": price
    };
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      // lodaer=true;
      final response =
          await APICall().registerUrse(map, AppConstant.ADD_COUPON);
      print(response);

      addCouponPojo.value = addCouponPojoFromJson(response);
      update();
      print(adminServicePojo.value.message);
      if (adminServicePojo.value.message == "Coupon added successfully") {
        // update();
        //lodaer = false;
        // CommonDialog.hideLoading();
      } else {
        // Get.to(const VerifyOtpPage());
        print("SDF SDF SDF ");
        //CommonDialog.hideLoading();
        CommonDialog.showsnackbar("Something error.");
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

  void getShopService(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.SHOP_SERVICE);
      print(response);
      //  CommonDialog.hideLoading();
      shopService.value = shopServicePojoFromJson(response);
      getCouponList();
      update();
      if (shopService.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());

        //  lodaer = false;

      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }

  void getUpdatedShopService(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.SHOP_SERVICE);
      print(response);
      //  CommonDialog.hideLoading();
      shopService.value = shopServicePojoFromJson(response);
      update();
      if (shopService.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        update();
        //  lodaer = false;

      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // CommonDialog.hideLoading();
    }
  }
}
