import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/appconstant.dart';

class APICall {
  final apiBaseUri = "http://bltechno.atwebpages.com/index.php/Dashboard";

  Future<String> registerUrse(Map map, url) async {
    Map<String, String> mainheader = {
      "Content-type": "application/x-www-form-urlencoded",

    };
    var apiUrl = Uri.parse(AppConstant.BASE_URL + url);
    print(apiUrl);
    print(map);
    final response = await http.post(
      apiUrl,
headers: mainheader,
      body: map
    );
    if (response.statusCode == 200) {

      var jsonString = response.body;
      print(response.statusCode);
     // print(response.body);
      return jsonString;
    } else {
      return "null";
    }
  }
  Future<String> postWithoutBody(url) async {
    Map<String, String> mainheader = {
      "Content-type": "application/x-www-form-urlencoded",

    };
    var apiUrl = Uri.parse(AppConstant.BASE_URL + url);
    print(apiUrl);
    final response = await http.post(
        apiUrl,
        headers: mainheader,
    );
    if (response.statusCode == 200) {

      var jsonString = response.body;
      print(response.statusCode);
      // print(response.body);
      return jsonString;
    } else {
      return "null";
    }
  }

  Future<String> getMethod(Map map, url) async {
    Map<String, String> mainheader = {
      "Content-type": "application/x-www-form-urlencoded",

    };
    var apiUrl = Uri.parse(AppConstant.BASE_URL + url);
    print(apiUrl);
    print(map);
    final response = await http.get(
        apiUrl,
        headers: mainheader,

    );
    print("SDFDSFDFDFDF");
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(response.statusCode);
      print("SDFDSFDFDFDF");
       print(response.body);
      return jsonString;
    } else {
      return "null";
    }
  }
  Future<String> registerUserMulti(
      image, name, email, dob, gender, phone, device_type, device_token) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstant.BASE_URL + AppConstant.REGISTER));

    request.files.add(http.MultipartFile.fromBytes(
        'image', File(image.path).readAsBytesSync(),
        filename: image.path.split("/").last));

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['dob'] = "" + dob;
    request.fields['gender'] = gender;
    request.fields['device_type'] = device_type;
    request.fields['device_token'] = device_token;
    request.fields['phone'] = phone;
    print(request);
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("SDF DSF SDF SDF SDF ");
    print("Result: ${response.body}");
    if (response.statusCode == 400) {
      print(response);
      return "null";
    } else {
      return response.body;
    }
  }

  Future<String> registerUpdateProfileMulti(session,
      image, name, email, dob, gender, phone, device_type, device_token) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstant.BASE_URL + AppConstant.UPDATE_PROFILE));
if(image!=null){
  request.files.add(http.MultipartFile.fromBytes(
      'image', File(image.path).readAsBytesSync(),
      filename: image.path.split("/").last));
}

   request.fields["session_id"]=session;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['dob'] = "" + dob;
    request.fields['gender'] = gender;
    request.fields['device_type'] = device_type;
    request.fields['device_token'] = device_token;
    request.fields['phone'] = phone;
    print(request);
    http.Response response =
    await http.Response.fromStream(await request.send());
    print("SDF DSF SDF SDF SDF ");
    print("Result: ${response.body}");
    if (response.statusCode == 400) {
      print(response);
      return "null";
    } else {
      return response.body;
    }
  }
}
