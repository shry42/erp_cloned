import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/user_model.dart';
import 'package:erp_copy/services/api_service.dart';

class LoginController extends GetxController {
  final RxString _userName = ''.obs;
  User? user;

  void setUserName(String value) => _userName.value = value;

  Future<void> loginUser({
    required String empCode,
    required String otp,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('${ApiService.base}/api/loginUserWithOTP'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "empCode": empCode,
        "otp": otp,
      }),
    );

    final Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      user = User.fromJson(result['userDetails']);
      final String token = result['token'];

      // Update app controller and save to preferences
      AppController.setmessage(null);
      AppController.setUsername(user?.fullName);
      AppController.setEmailID(user?.emailId);
      AppController.setMobileNumber(user?.mobileNumber);
      AppController.setaccessToken(token);

      // Save to preferences
      await prefs.setString('userName', user?.fullName ?? '');
      await prefs.setString('email', user?.emailId ?? '');
      await prefs.setString('mobNo', user?.mobileNumber ?? '');
      await prefs.setString('token', token);
    } else {
      AppController.setmessage(result['message']);
    }
  }
}
