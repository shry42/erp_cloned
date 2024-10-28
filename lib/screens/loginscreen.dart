import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/login_controller.dart';
import 'package:erp_copy/controllers/otp_controller.dart';
import 'package:erp_copy/widget/menu_widget/hidden_main_page_drawer.dart';
import 'package:erp_copy/utils/toast_notify.dart';

import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/login_controller.dart';
import 'package:erp_copy/widget/menu_widget/hidden_main_page_drawer.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//*****FOR DEVELOPMENT */

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();

TextEditingController passController = TextEditingController();

final LoginController c = Get.put(LoginController());

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
                  // onChanged: (value) {
                  //   AppController.setEmailID(emailController.text);
                  //   c.userName.value = emailController.text;
                  // },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Emp code',
                      labelStyle:
                          GoogleFonts.kameron(textStyle: const TextStyle()),
                      hintText: 'username'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Please enter employee code';
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
                  // onChanged: (value) {
                  //   c.password.value = passController.text;
                  // },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'otp',
                    labelStyle:
                        GoogleFonts.kameron(textStyle: const TextStyle()),
                    hintText: 'Enter otp',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Please enter otp';
                    }
                    return null;
                  },
                ),
              ),
              //checkBox

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Transform.scale(
              //         scale: 0.8,
              //         child: Checkbox(
              //             value: isChecked,
              //             onChanged: (bool) {
              //               setState(() {
              //                 isChecked = true;
              //               });
              //             }),
              //       ),
              // Text('Remember me',
              //     style: GoogleFonts.kameron(
              //         textStyle: const TextStyle(
              //             color: Color.fromARGB(255, 105, 106, 108)))),
              // const Spacer(),
              // Text('Forgot Password ?',
              //     // style: TextStyle(color: Color.fromARGB(255, 7, 138, 198)),
              //     style: GoogleFonts.kameron(
              //         textStyle: const TextStyle(
              //             color: Color.fromARGB(255, 57, 139, 206)))),
              // const SizedBox(width: 12),
              //     ],
              //   ),
              // ),

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
                      await c.loginUser(
                        empCode: emailController.text.toString(),
                        otp: passController.text.toString(),
                      );
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


//*****FOR LIVE */

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final LoginController _loginController = Get.put(LoginController());
//   final OtpController _otpController = Get.put(OtpController());
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool _isOtpSent = false;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleOtpRequest() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       try {
//         await _otpController.getOtp(_emailController.text);
//         setState(() {
//           _isOtpSent = true;
//           _isLoading = false;
//         });
//       } finally {
//         setState(() => _isLoading = false);
//       }
//     } else {
//       toast('Please fill credentials correctly');
//     }
//   }

//   Future<void> _handleLogin() async {
//     if (_formKey.currentState!.validate()) {
//       await _loginController.loginUser(
//         empCode: _emailController.text,
//         otp: otpController.text,
//       );

//       if (AppController.message != null) {
//         Get.defaultDialog(
//           title: "Unauthorized!",
//           middleText: AppController.message ?? "",
//           textConfirm: "OK",
//           confirmTextColor: Colors.white,
//           onConfirm: () {
//             AppController.setmessage(null);
//             Get.back();
//           },
//         );
//       } else {
//         await Get.offAll(
//           const HiddenDrawer(),
//           transition: Transition.rightToLeft,
//         );
//       }
//     } else {
//       toast('Please fill credentials correctly');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 55),
//               Image.asset(
//                 'assets/images/gegadyne_logo.png',
//                 height: 50,
//               ),
//               Image.asset('assets/images/loginImage.png'),
//               _buildEmailField(),
//               if (_isOtpSent) _buildOtpField(),
//               const SizedBox(height: 20),
//               _buildOtpButton(),
//               if (_isOtpSent) _buildLoginButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: TextFormField(
//         controller: _emailController,
//         onChanged: (value) {
//           AppController.setEmailID(value);
//           _loginController.setUserName(value);
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           labelText: 'Emp code',
//           labelStyle: GoogleFonts.kameron(),
//           hintText: 'username',
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter employee code';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildOtpField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//       child: TextFormField(
//         controller: otpController,
//         obscureText: true,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           labelText: 'OTP',
//           labelStyle: GoogleFonts.kameron(),
//           hintText: 'Enter OTP',
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter OTP';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildOtpButton() {
//     return SizedBox(
//       width: 140,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onPressed: _isLoading ? null : _handleOtpRequest,
//         child: _isLoading
//             ? const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               )
//             : Text(
//                 'Get OTP',
//                 style: GoogleFonts.kameron(fontSize: 18),
//               ),
//       ),
//     );
//   }

//   Widget _buildLoginButton() {
//     return SizedBox(
//       width: 140,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onPressed: _handleLogin,
//         child: Text(
//           'Login',
//           style: GoogleFonts.kameron(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
