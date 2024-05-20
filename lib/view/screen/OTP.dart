// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:homeservice/view/screen/change_settings/change_email.dart';
import 'package:homeservice/view/screen/login.dart';
import 'package:homeservice/view/screen/reset_pass.dart';
import 'package:http/http.dart';
import '../../core/controller.dart';
import '../../core/utilti/Color.dart';
import '../../generated/l10n.dart';

// class OTP extends StatelessWidget {
//   const OTP({
//     // super.key,
//     required this.email,
//     required this.currentPage,
//   });
//   final email;
//   final currentPage;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(S.of(context).enterCode,
//                 textAlign: TextAlign.center,
//                 style:
//                     const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 Text(
//                   S.of(context).sendOTP,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 Text(
//                   email,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextFieldOTP(
//                   controller: item1,
//                   first: true,
//                   last: false,
//                 ),
//                 TextFieldOTP(
//                   controller: item2,
//                   first: false,
//                   last: false,
//                 ),
//                 TextFieldOTP(
//                   controller: item3,
//                   first: false,
//                   last: false,
//                 ),
//                 TextFieldOTP(
//                   controller: item4,
//                   first: false,
//                   last: false,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: mainColor,
//                     foregroundColor: whiteColor,
//                     fixedSize: const Size(200, 50)),
//                 onPressed: () async {
//                   String code = '';

//                   if (item1.text.isNotEmpty &&
//                       item2.text.isNotEmpty &&
//                       item3.text.isNotEmpty &&
//                       item4.text.isNotEmpty) {
//                     code = item1.text + item2.text + item3.text + item4.text;
//                   }
//                   try {
//                     final response = await post(
//                         Uri.parse('http://10.0.2.2:5000/signup/user/verify'),
//                         headers: <String, String>{
//                           'Content-Type': 'application/json; charset=UTF-8',
//                         },
//                         body: jsonEncode(<String, String>{
//                           "verifycode": code,
//                           "email": email
//                         }));
//                     print(response.statusCode);
//                     if (response.statusCode == 200) {
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text('تمت عملية انشاء الحساب',
//                             style: TextStyle(color: Colors.white)),
//                         backgroundColor: Colors.green,
//                       ));
//                       if (currentPage == 'signup') {
//                         Get.to(() => const Welcome());
//                       } else if (currentPage == "forgetPassPage") {
//                         Get.to(() => ResetPassword(email: email,));
//                       } else {
//                         print("errorOTp");
//                       }
//                     } else {
//                       final Map<String, dynamic> responseData =
//                           json.decode(response.body);
//                       final String errorMessage = responseData['error'];
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text(
//                           errorMessage,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor: Colors.red,
//                       ));
//                     }
//                     // Get.to(login());
//                   } catch (e) {
//                     print("Error: $e");
//                   }

//                   // var resp = await post(
//                   //     Uri.parse('http://10.0.2.2:5000/signup/user/y'),
//                   //     body: jsonEncode(<String, String>{
//                   //       "verifycode": code,
//                   //       "email": "email.toString()"
//                   //     }));
//                   // print(resp.body);
//                   // print("code $code");
//                 },
//                 child: const Text(
//                   "تاكيد",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 )),
//           ],
//         ),
//       )),
//     );
//   }
// }

class forgetOTP extends StatelessWidget {
  const forgetOTP({
    super.key,
    required this.email,
    required this.currentPage,
  });
  final String email;
  final String currentPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).enterCode,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            Wrap(
              children: [
                Text(
                  S.of(context).sendOTP,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [TextFieldOTP(
                      controller: item1,
                      first: true,
                      last: false,
                    ),TextFieldOTP(
                      controller: item2,
                      first: false,
                      last: false,
                    ),  TextFieldOTP(
                      controller: item3,
                      first: false,
                      last: false,
                    ),
                    TextFieldOTP(
                      controller: item4,
                      first: false,
                      last: true,
                    ),
                  
                    
                    
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: whiteColor,
                    fixedSize: const Size(200, 50)),
                onPressed: () async {
                  String code = '';

                  if (item1.text.isNotEmpty &&
                      item2.text.isNotEmpty &&
                      item3.text.isNotEmpty &&
                      item4.text.isNotEmpty) {
                    code = item1.text + item2.text + item3.text + item4.text;

                    print(code);
                    print(currentPage);
                  }
                  if (currentPage == 'signup' || currentPage == "LoginPage") {
                    try {
                      final response = await post(
                          Uri.parse('http://10.0.2.2:5000/signup/verify/email'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            "email": email,
                            "verifycode": code

                          }));
                      print(response.statusCode);
                      if (response.statusCode == 404) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "يجب ادخال رمز صالح",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('تمت عملية تأكيد الحساب',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ));
                        Get.to(() => const login());
                      } else {
                        final Map<String, dynamic> responseData =
                            json.decode(response.body);
                        final String errorMessage = responseData['error'];
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      // Get.to(login());
                    } catch (e) {
                      print(e);
                    }
                  } else if (currentPage == "confirmationEmail") {
                    try {
                      final response = await post(
                          Uri.parse(
                              'http://10.0.2.2:5000/signup/user/verify_pass'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            "verifycode": code,
                            "email": email
                          }));
                      print(response.statusCode);
                      if (response.statusCode == 404) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "يجب ادخال رمز صالح",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('تمت عملية انشاء الحساب',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ));
                        Get.to(() => const ResetPassword() );
                      } else {
                        final Map<String, dynamic> responseData =
                            json.decode(response.body);
                        final String errorMessage = responseData['error'];
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      // Get.to(login());
                    } catch (e) {
                      print(e);
                    }
                  }
                  else if(currentPage == "changeEmail"){

                      try {
                      final response = await post(
                          Uri.parse(
                              'http://10.0.2.2:5000/change_email'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            "verifycode": code,
                            "email": email
                          }));
                      print(response.statusCode);
                      if (response.statusCode == 404) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "يجب ادخال رمز صالح",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('تمت عملية انشاء الحساب',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ));
                        Get.to(() => const ChangeEmail() );
                      } else {
                        final Map<String, dynamic> responseData =
                            json.decode(response.body);
                        final String errorMessage = responseData['error'];
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      // Get.to(login());
                    } catch (e) {
                      print(e);
                    }

                  }
                },
                child:  Text(
                  S.of(context).confirm,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      )),
    );
  }
}

class TextFieldOTP extends StatelessWidget {
  TextFieldOTP({
    super.key,
    required this.first,
    required this.last,
    required this.controller,
  });
  bool first;
  bool last;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(20, 20, 20, 20),
          border: Border.all(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onChanged: (value) {
          controller.text = value;
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30),
        decoration: InputDecoration(
            border: InputBorder.none,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height / 7,
                maxWidth: MediaQuery.sizeOf(context).width / 8)),
      ),
    );
  }
}
