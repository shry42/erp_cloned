import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/user_model.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginController extends GetxController {
  RxString userName = ''.obs;
  RxString password = ''.obs;
  String token = "";
  String role = "";
  User? user;

  Future<void> loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // throw Exception();
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/loginUserWithOTP'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "empCode": userName.value,
        "otp": password.value,
      }),
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      String message = result['message'];
      AppController.setmessage(message);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      user = User.fromJson(result['userDetails']);
      AppController.setmessage(null);
      AppController.setUsername(user?.fullName);
      await prefs.setString('userName', '${user?.fullName}');
      AppController.setEmailID(user?.emailId);
      await prefs.setString('email', '${user?.emailId}');

      AppController.setMobileNumber(user?.mobileNumber);
      await prefs.setString('mobNo', '${user?.mobileNumber}');

      // // List userValue = result['userDeatils'];
      // // emailId.value = userValue[0]['emailId'];

      token = result['token'];
      // print('******$token');
      AppController.setaccessToken(token);
      await prefs.setString('token', token);

      // role = user!.role;
      // AppController.setRole(role);
      // // Get.offAll(UserDetailsScreen());
    }
  }

  // void logout() {
  //   user = null;
  //   token = "";
  //   emailId.value = "";
  //   password.value = "";
  //   role = "";
  //   AppController.setaccessToken("");
  //   AppController.setRole("");
  // }

  // void resetControllers() {
  //   Get.reset();
  // }
}
