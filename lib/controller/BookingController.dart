import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../model/MyBookingPojo.dart';
import '../model/WishlistPojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class BookingController extends GetxController {
  var bookingPojo = MyBookingPojo().obs;
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
      getBookingList();
    }
  }

  void getBookingList() async {
    Map map;
    map = {"session_id": box.read('session')};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.ALL_BOOKINGS);
     // print(response);
      if (bookingPojo.value.message == "No Data found") {
     //   print(response);
        CommonDialog.hideLoading();
        CommonDialog.showsnackbar("No Data found");
      } else {
        CommonDialog.hideLoading();
        bookingPojo.value = myBookingPojoFromJson(response);
        update();
        lodaer = false;
      }
    } catch (error) {
      print(error);
      CommonDialog.hideLoading();
    }
  }
}
