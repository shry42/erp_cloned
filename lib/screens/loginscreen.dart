import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/login_controller.dart';
import 'package:erp_copy/widget/menu_widget/hidden_main_page_drawer.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();

TextEditingController passController = TextEditingController();

final loginController c = Get.put(loginController());

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool isChecked = false;

class _LoginScreenState extends State<LoginScreen> {
  bool isRTL(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              Container(
                child: Image.asset(
                  'assets/images/gegadyne_logo.png',
                  height: 50,
                ),
              ),
              Container(child: Image.asset('assets/images/loginImage.png')),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: emailController,
                  onChanged: (value) {
                    AppController.setEmailID(emailController.text);
                    c.userName.value = emailController.text;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Username',
                      labelStyle:
                          GoogleFonts.kameron(textStyle: const TextStyle()),
                      hintText: 'username'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Please enter a valid userName';
                    }
                    return null;
                  },
                ),
              ),

              //Password

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: passController,
                  onChanged: (value) {
                    c.password.value = passController.text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Password',
                    labelStyle:
                        GoogleFonts.kameron(textStyle: const TextStyle()),
                    hintText: 'Enter secure password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              //checkBox

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                          value: isChecked,
                          onChanged: (bool) {
                            setState(() {
                              isChecked = true;
                            });
                          }),
                    ),
                    Text('Remember me',
                        style: GoogleFonts.kameron(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 105, 106, 108)))),
                    const Spacer(),
                    Text('Forgot Password ?',
                        // style: TextStyle(color: Color.fromARGB(255, 7, 138, 198)),
                        style: GoogleFonts.kameron(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 57, 139, 206)))),
                    const SizedBox(width: 12),
                  ],
                ),
              ),

              //ElevatedButton

              SizedBox(
                width: 140,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // side: MaterialStateProperty.all<BorderSide>(
                    //   const BorderSide(color: Colors.black, width: 2),
                    // ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await c.loginUser();
                      if (AppController.message != null) {
                        Get.defaultDialog(
                          title: "Unauthorized!",
                          middleText: "${AppController.message}",
                          textConfirm: "OK",
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            AppController.setmessage(null);
                            Get.back(); // Close the dialog
                          },
                        );
                        return;
                      } else {
                        await Get.offAll(const HiddenDrawer(),
                            transition: Transition.rightToLeft);

                        return;
                      }
                    } else {
                      toast('Please fill credentials correctly');
                    }
                  },
                  child: Text('Login',
                      style: GoogleFonts.kameron(
                          textStyle: const TextStyle(fontSize: 18))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
