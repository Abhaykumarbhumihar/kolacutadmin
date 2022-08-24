import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/AdminCouponPojo.dart';
import '../model/AdminServicePojo.dart';
import '../model/CartListPojo.dart';
import '../model/CoinPojo.dart';
import '../model/ShopLIstPojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var shopListPojo = ShopLIstPojo().obs;
  List<StaffDetail> data = [];
  var serviceList = AdminServicePojo().obs;
  var adminCouponList = AdminCouponPojo().obs;
  var coinPojo = CoinPojo().obs;
  final box = GetStorage();
  var lodaer = true;
  var sessiooo = "".obs;
  late SharedPreferences sharedPreferences;
  var cartListPjo = CartListPojo().obs;
  int coin = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    //session_id
    super.onReady();
    getShopList();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      try{
        var _testValue = sharedPreferences.getString("session");
        // print(sharedPreferences.getString("session"));


        if (_testValue != null) {
          //getServiceList(_testValue);
          getAdminCouponList(_testValue);
          getCoin(_testValue);
          // getCartList(_testValue);
        }
      }catch(e){}
    });

    //  getShopList("TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm");
    //  getServiceList("TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm");
  }

  void getServiceList(session_id) async {
    Map map;
    map = {"session_id": "$session_id"};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      lodaer = true;
      final response =
          await APICall().registerUrse(map, AppConstant.SERVICE_LIST);
      print(response);
      print("kjkjkljljlkjlkljkljkljhjgyuyyghgh");
      if (serviceList.value.message == "No Data found") {
        //   CommonDialog.hideLoading();
        //  CommonDialog.showsnackbar("No Data found");
      } else {
        //  CommonDialog.hideLoading();
        serviceList.value = adminServicePojoFromJson(response);

        update();
        //  lodaer = false;
      }
    } catch (error) {
      //CommonDialog.hideLoading();
    }
  }

  void getAdminCouponList(session_id) async {
    Map map;
    map = {"session_id": "$session_id"};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      lodaer = true;
      final response =
          await APICall().getMethod(map, AppConstant.ADMIN_COUPON_LIST);
      print(response);
      print("ADMIN COUPON ");
      if (adminCouponList.value.message == "No Data found") {
        //   CommonDialog.hideLoading();
        //  CommonDialog.showsnackbar("No Data found");
      } else {
        //  CommonDialog.hideLoading();
        adminCouponList.value = adminCouponPojoFromJson(response);

        update();
        //lodaer = false;
      }
    } catch (error) {
      //CommonDialog.hideLoading();
    }
  }

  void getCoin(session_id) async {
    Map map;
    map = {"session_id": "$session_id"};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      // lodaer=true;
      final response = await APICall().registerUrse(map, AppConstant.COIN);
      print(response);
      print("COIND data ");
      if (coinPojo.value.message == "No Data found") {
        //   CommonDialog.hideLoading();
        //  CommonDialog.showsnackbar("No Data found");
      } else {
        //  CommonDialog.hideLoading();
        coinPojo.value = coinPojoFromJson(response);
        if (coinPojo.value.coin != null) {
          coin = coinPojo.value.coin!;
          //myInteger.value
          update();
        }
        update();
        lodaer = false;
      }
    } catch (error) {
      //CommonDialog.hideLoading();
    }
  }

  void getShopList() async {
    Map map;
    map = {"session_id": "session_id"};
    try {
   CommonDialog.showLoading(title: "Please waitt...");
      lodaer = true;
      final response = await APICall().postWithoutBody(AppConstant.SHOP_LIST);

      //print(response);
      if (shopListPojo.value.message == "No Data found") {
        CommonDialog.hideLoading();
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.back();
        CommonDialog.hideLoading();
        shopListPojo.value = shopLIstPojoFromJson(response);
        data = shopListPojo.value.staffDetail!;
        lodaer = false;
        update();
      }
    } catch (error) {
      lodaer = false;
      CommonDialog.hideLoading();
    }
  }

  void getCartList(session_id) async {
    lodaer = true;
    Map map;
    map = {"session_id": session_id};
    try {
      // CommonDialog.showLoading(title: "Please waitt...");

      final response =
          await APICall().registerUrse(map, AppConstant.GET_CART_LIST);
      Get.back();
      //print(response);
      if (cartListPjo.value.message == "No Data found") {
        CommonDialog.hideLoading();
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.back();
        cartListPjo.value = cartListPojoFromJson(response);
        lodaer = false;
        update();
      }
    } catch (error) {
      lodaer = false;
      CommonDialog.hideLoading();
    }
  }

  void removeFromCart(session_id, cart_id) async {
    Map map;
    map = {"session_id": session_id, "cart_id": cart_id};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      lodaer = true;
      final response =
          await APICall().registerUrse(map, AppConstant.DELTE_CART);

      //print(response);

    } catch (error) {
      lodaer = false;
      CommonDialog.hideLoading();
    }
  }

  /*TODO--home screen filter*/

  void filterEmplist(text) {
    if (text.toString().trim() == "") {
      data = shopListPojo.value.staffDetail!;
      update();
    } else {
      var da = shopListPojo.value.staffDetail!
          .where((m) => m.service!
              .where((s) =>
                  s.serviceTitle!.toLowerCase().contains(text.toString().tr))
              .isNotEmpty)
          .toList();
      data = da;
      update();
    }
  }
}
