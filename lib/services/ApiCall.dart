import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../utils/appconstant.dart';

class APICall {
  final apiBaseUri = "http://bltechno.atwebpages.com/index.php/Dashboard";

  Future<String> registerUrse(Map map, url) async {
    var apiUrl = Uri.parse(AppConstant.BASE_URL + url);
    print(apiUrl);
    print(map);
    final response = await http.post(
      apiUrl,
      body: map,
    );

print(response);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else {
      return "null";
    }
  }
  Future<String> registerUrseWithoutbody( url,days) async {
    var apiUrl = Uri.parse(AppConstant.BASE_URL+url+"?filter="+days);
    print(apiUrl);
    final response = await http.get(
      apiUrl,
    );

    print(response);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else {
      return "null";
    }
  }

  Future<String> AddEmployee(experience, session_id, name, email, address,
      skills, password, phone_number, image) async {
    print("IN API FILE");
    print(skills);

    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstant.BASE_URL + AppConstant.ADD_EMPLOYEE));
    // var fileContent = file.readAsBytesSync();
    // var fileContentBase64 = base64.encode(fileContent);

    request.files.add(http.MultipartFile.fromBytes(
        'image', image.readAsBytesSync(),
        filename: image.path.split("/").last));

    request.fields['experience'] = experience + " years Experience";
    request.fields['skills[]'] = skills;
    request.fields['session_id'] = session_id;
    request.fields['address'] = address;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['phone_number'] = "" + phone_number;

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

  Future<String> registerUserMulti(
      shop_name,
      email,
      shop_type,
      address,
      latitude,
      longitude,
      owner_name,
      owner_email,
      age,
      owner_phone_no,
      device_type,
      device_token,
      password,
      logo,
      owner_profile_image,
      adhaar_card_file) async {
    print("IN API FILE");
    print(logo);
    print(owner_profile_image);
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstant.BASE_URL + AppConstant.REGISTER));
    // var fileContent = file.readAsBytesSync();
    // var fileContentBase64 = base64.encode(fileContent);

    request.files.add(http.MultipartFile.fromBytes(
        'logo', logo.readAsBytesSync(),
        filename: logo.path.split("/").last));

    request.files.add(http.MultipartFile.fromBytes(
        'owner_profile_image', owner_profile_image.readAsBytesSync(),
        filename: owner_profile_image.path.split("/").last));
    request.fields['adhaar_card_file'] = adhaar_card_file;
    request.fields['shop_name'] = shop_name;
    request.fields['email'] = email;
    request.fields['shop_type'] = "" + shop_type;
    request.fields['address'] = address;
    request.fields['adhaar_card_file'] = adhaar_card_file;
    print(adhaar_card_file + "SDFSDFD");
    request.fields['address'] = address;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['owner_name'] = owner_name;
    request.fields['owner_email'] = owner_email;
    request.fields['age'] = "" + age;
    request.fields['owner_phone_no'] = owner_phone_no;
    request.fields['device_type'] = device_type;
    request.fields['device_token'] = device_token;
    request.fields['password'] = password;
    print(request.fields);
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

  Future<String> uploadshopimages(List<XFile> logo, session_id) async {
    print(logo.length);
    print("IN API FILE");

    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConstant.BASE_URL + AppConstant.UPDTE_SHOP));

    request.fields['session_id'] = session_id;

    for(int i = 0; i < logo.length; i++){
      request.fields['shop_image[$i]'] = '${logo[i]}';
    }


    print(request);
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("SDF DSF SDF SDF SDF ");
   // print(response);
    final body = json.decode(response.body);
    print(body);
    print("Result: ${response.statusCode}");
    if (response.statusCode == 400) {
      print(response);
      print("SFSDFSDFDSFSDFSDFSDFSDFSDF");
      return "null";
    }
    else {
      print("HI I AM HERE");
      return response.body;
    }
  }
}

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? session = prefs.getString('session');
  runApp(MyApp(session: session));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.session}) : super(key: key);
  final String? session;


  @override

  Widget build(BuildContext context) {
    print(session);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: session == null ? const LoginPage() : const HomeBottomBar(),
    );
  }
}

*/
