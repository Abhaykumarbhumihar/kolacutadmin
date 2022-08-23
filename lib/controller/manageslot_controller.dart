import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class ManageSlotController extends GetxController {
  RxInt currentValue=3.obs;

  RxInt updateCurrentValue(value){
    currentValue=value;
    update();
    return currentValue;
  }



  void addSlot(session_id, slot_type, slot_duration, slot_days, opening_time,
      closing_time) async {
    Map map;
    //session_id:HlHA4Dvok3nUKG5MOwtiLgxc5eHzahMz
    // slot_type:Same Everyday
    // slot_duration:60 min.
    // slot_days[]:Monday,Tuesday,Wednesday,Thursday,Friday,Saturday
    // opening_time:8:00 AM
    // closing_time:7:00 PM
    map = {
      "session_id": session_id,
      "slot_type": slot_type,
      "slot_duration": slot_duration,
      "slot_days[]": slot_days,
      "opening_time": opening_time,
      "closing_time": closing_time
    };

    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.ADD_SLOT);
      print(response);
      CommonDialog.hideLoading();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }
}
