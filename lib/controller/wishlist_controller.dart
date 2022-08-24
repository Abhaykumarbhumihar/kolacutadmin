import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/WishlistPojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class WishListController extends GetxController {
  var wihlistlpojo = WishlistPojo().obs;
  final box = GetStorage();
  var lodaer = true;
  var shopId = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    //session_id
    super.onReady();
    print("SDLKFJKLSDFJDSprofile");
    print(box.read('session'));
    if(box.read('session')!=null){
      getWishList();
    }

  }

  void getWishList() async {
    Map map;
    map = {"session_id": box.read('session')};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.WISHLIST);
      print(response);
      if (wihlistlpojo.value.message == "No Data found") {
        print(response);
        CommonDialog.hideLoading();
        CommonDialog.showsnackbar("No Data found");
      } else {
        CommonDialog.hideLoading();
        wihlistlpojo.value = wishlistPojoFromJson(response);
        update();
        lodaer = false;
      }
    } catch (error) {
      print(error);
      CommonDialog.hideLoading();
    }
  }
}
