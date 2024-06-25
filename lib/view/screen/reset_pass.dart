import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/user_controller.dart';
import 'package:homeservice/view/screen/login.dart';
import 'package:http/http.dart';
import '../../core/utilti/Color.dart';
import '../../generated/l10n.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});


  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController controllerNewPass = TextEditingController();
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: mainColor,
                  border: Border.all(color: mainColor),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Text(
                S.of(context).resetPassword,
                style: TextStyle(
                    fontSize: 30,
                    color: whiteColor,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            Container(
              width: 260,
              height: 060,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: controllerNewPass,
                obscureText: true,
                keyboardType: TextInputType.text,
                maxLength: 50,
                cursorColor: blackColor,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: mainColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: mainColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: greyColor)),
                  label: Text(S.of(context).Newpassword,
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Cairo',
                          fontSize: 13)),
                ),
                validator: (value) {},
              ),
            ),
            Container(
              width: 260,
              height: 060,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                maxLength: 50,
                cursorColor: blackColor,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: mainColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: mainColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: greyColor)),
                  label: Text(S.of(context).ConfirmNewPassword,
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Cairo',
                          fontSize: 13)),
                ),
                validator: (value) {
                  controllerNewPass.text == value
                      ? null
                      : "Passwords don't match";
                  return null;
                },
              ),
            ),
            const SizedBox(height: 22,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: whiteColor ,
                backgroundColor: mainColor ,
                textStyle: const TextStyle( fontSize: 20, fontFamily: 'Cairo'),
              ),
                onPressed: () async {
                  try {
                    final response = await post(
                        Uri.parse('http://10.0.2.2:5000/signup/user/resetpass'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          "email": userController.userEmail.value,
                          "password": controllerNewPass.text
                        }));
                    print(response.statusCode);
                    if (response.statusCode == 404) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "يجب ادخال رمز صالح",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("تم تغيير كلمة المرور بنجاح",
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
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(S.of(context).confirm))
          ]),
        ),
      ),
    );
  }
}
