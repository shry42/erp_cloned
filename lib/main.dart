import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/widget/menu_widget/hidden_main_page_drawer.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AppController.setaccessToken('${prefs.getString('token')}');
  AppController.setUsername('${prefs.getString('userName')}');
  AppController.setEmailID('${prefs.getString('email')}');
  AppController.setMobileNumber('${prefs.getString('mobNo')}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: AppController.accessToken == "null"
          ? LoginScreen()
          : const HiddenDrawer(),
    );
  }
}
