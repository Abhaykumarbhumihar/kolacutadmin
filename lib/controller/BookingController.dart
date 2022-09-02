import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/model/AcceptBookigPojo.dart';
import 'package:kolacur_admin/model/AllBookingPojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class BookingController extends GetxController {
  var bookingPojo = AllBookingPojoo().obs;
  var acceptBookingPojo = AcceptBookigPojo().obs;
  final box = GetStorage();
  var lodaer = true;
  var shopId = "".obs;
  List<SlotDetail>? slotDetail = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void filterWithDate(selectedDate) {
    if (bookingPojo.value.slotDetail!.isNotEmpty) {
      slotDetail = [];
      for (var i = 0; i < bookingPojo.value.slotDetail!.length; i++) {
        print(bookingPojo.value.slotDetail![i].date.toString());
        if (bookingPojo.value.slotDetail![i].date!.compareTo(selectedDate) ==
            0) {
          slotDetail!.add(bookingPojo.value.slotDetail![i]);
        } else {}
      }
      update();
      print(" <><><><><><><><><><><><><>");
      print(slotDetail!.length.toString() + " <><><><><><><><><><><><><>");
    }
  }

  void filterEmplist(text) {
    if (text.toString().trim() == "") {
      update();
      slotDetail = bookingPojo.value.slotDetail!;
      update();
    } else {
      var newList = bookingPojo.value.slotDetail!
          .where((t) => t.bookingId!.toString().contains(text))
          .toList();

      slotDetail = [
        ...{...newList}
      ];

      update();
    }
  }

  void clearDateFilter() {
    slotDetail = bookingPojo.value.slotDetail!;
    update();
  }

  void filterStatus(selectedDate) {
    slotDetail = [];
    update();
    if (selectedDate == "All") {
      slotDetail = bookingPojo.value.slotDetail!;
      update();
    } else {
      var newlist = bookingPojo.value.slotDetail!
          .where((x) => x.status
              .toString()
              .toLowerCase()
              .contains(selectedDate.toLowerCase()))
          .toList();
      slotDetail = newlist;
      update();
    }

    update();
    print("here pring ${selectedDate}");
  }

  @override
  void onReady() {
    //session_id
    super.onReady();
    print("SDLKFJKLSDFJDSprofile");
    print(box.read('session'));
    getBookingList();
  }

  void getBookingList() async {
    Map map;
    map = {"session_id": box.read('session')};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_ALL_BOOKING);
      print(response);
      if (bookingPojo.value.message == "No Data found") {
        //   print(response);
        CommonDialog.hideLoading();
        CommonDialog.showsnackbar("No Data found");
      } else {
        CommonDialog.hideLoading();
        bookingPojo.value = allBookingPojoFromJson(response);
        slotDetail = bookingPojo.value.slotDetail;
        update();
        lodaer = false;
      }
    } catch (error) {
      print(error);
      CommonDialog.hideLoading();
    }
  }

  void acceptBooking(bookingId) async {
    Map map;
    map = {
      "session_id": box.read('session'),
      "booking_id": bookingId.toString()
    };
    print("API HIT HIT HIT HIT");
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.ACCEPT_BOOKING);
      print(response);
      // CommonDialog.hideLoading();
      final body = json.decode(response);
      // lodaer = false;
      if (body['message'] == "Booking has been accepted successfully.") {
        lodaer = false;
        CommonDialog.showsnackbar(body['message']);
        slotDetail!.clear();
        bookingPojo.value.slotDetail!.clear();
        getUpdatedBookingList();
        update();
      } else {
        CommonDialog.showsnackbar(
            "Please try again,or contact to kolacut admin");
      }
      update();
    } catch (error) {
      print(error);
      // CommonDialog.hideLoading();
    }
  }

  void getUpdatedBookingList() async {
    lodaer = false;
    slotDetail!.clear();
    bookingPojo.value.slotDetail!.clear();
    update();
    Map map;
    map = {"session_id": box.read('session')};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_ALL_BOOKING);
      print(response);
      update();
      // Navigator.pop(context);
      if (bookingPojo.value.message == "No Data found") {
        //   print(response);

        CommonDialog.showsnackbar("No Data found");
      } else {
        bookingPojo.value = allBookingPojoFromJson(response);
        slotDetail = [];
        slotDetail = bookingPojo.value.slotDetail;
        lodaer = false;
        update();
      }
      update();
    } catch (error) {
      print(error);
    }
  }
}
