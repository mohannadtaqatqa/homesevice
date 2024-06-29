import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/snakbar.dart';
import 'package:homeservice/core/function/user_controller.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/generated/l10n.dart';
import 'package:homeservice/view/screen/OTP.dart';
import 'package:http/http.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<ChangeEmail> {
  UserController controller = Get.put(UserController());
  TextEditingController emailOTP = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const  SizedBox(height: 22,),
                  Image.asset('images/enter-your-mail.png',width: MediaQuery.of(context).size.width*0.7,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "${S.of(context).sendCodeEmail} ${controller.userEmail}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          color: Colors.white,
                          child: Form(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor,
                                    foregroundColor: whiteColor,
                                    fixedSize: const Size(200, 50)),
                                onPressed: () async {
                                  try {
                                    final response = await post(
                                        Uri.parse(
                                            'http://10.0.2.2:5000/check_email'),
                                        headers: <String, String>{
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: jsonEncode(<String, String>{
                                          "email": "${controller.userEmail}",
                                        }));
                                    if (response.statusCode == 200) {
                                      Get.to(
                                        () => ForgetOTP(
                                            email: "${controller.userEmail}",
                                            currentPage: "changeEmail"),
                                      );
                                    }
                                    if (response.statusCode == 404) {
                                      Snackbar( message: S.of(context).errorEmail1, context: context, backgroundColor: Colors.red , textColor: Colors.white) ;
                                    }
                                  } catch (e) {
                                    Snackbar( message: S.of(context).errorOccured, context: context, backgroundColor: Colors.red , textColor: Colors.white) ;
                                  }
                                },
                                child: Text(
                                  S.of(context).send,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }
}
