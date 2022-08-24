import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/CommomDialog.dart';


class MainController extends GetxController {
  //  todo--notes *******
  //todo  jb bhi controller access krte hai to UI wale file me controller ka
  //todo  instance create krna hota hai

  userLogin() {
    print("LOgin user");
    CommonDialog.showLoading();
    Future.delayed(Duration(milliseconds: 3000), () {
      CommonDialog.hideLoading();
      //TODO --- For routing using Get use Get.to(pass here page name)   Get.to se
      //back krne pe pichhle page pe aayega
       //  Get.to(VerifyOtp());

      //TODO----Get.off(Screen name)--ye last page pe nhi bhejega
      //Get.off(HomeScreen());
    });
  }






  /*TODO---default titile hai agr method call krte time
     pass krenge to o dikhega nhi to loading dikhega*/





//  TODO--API PART

// List<Product>productData=[];
//   Map productDetails={}.obs;
//  TODO---IMPORTANT NOTE:::::::::::::: ::::::   IMPORTANT NOTE ::::::::   IMPORTANT NOTE ::::::::     :::::::
/*TODO----Get ka koi bhi Features use krte hai to Main me
    materialapp ki jgh  GetMaterialApp return krana pdta hai nhi to error dega
    Null check operator used on a null value*/

}
