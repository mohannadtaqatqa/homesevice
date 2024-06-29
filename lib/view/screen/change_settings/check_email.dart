import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeservice/core/function/snakbar.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/generated/l10n.dart';
import 'package:homeservice/view/screen/OTP.dart';
import 'package:http/http.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({super.key});

  @override
  State<CheckEmail> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<CheckEmail> {
  TextEditingController emailOTP = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        // color: Colors.grey[300],
        padding: const EdgeInsets.all(10.0),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "images/otp.png",
                  height: 200,
                  width: 400,
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.of(context).EnterPhoneNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                    Text(
                      S.of(context).sendCode,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 700,
                      height: 200,
                      color: Colors.white,
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 800,
                                height: 070,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      value = emailOTP.text;
                                    });
                                  },
                                  style: const TextStyle(fontSize: 22),
                                  textAlign: TextAlign.left,
                                  controller: emailOTP,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    // suffixIcon: emailOTP.text.length >= 5
                                    //     ? Container(
                                    //         margin: const EdgeInsets.symmetric(
                                    //             horizontal: 7),
                                    //         decoration: const BoxDecoration(
                                    //             shape: BoxShape.circle,
                                    //             color: Colors.green),
                                    //         child: const Icon(
                                    //           Icons.done,
                                    //           color: Color.fromARGB(
                                    //               255, 242, 245, 242),
                                    //         ),
                                    //       )
                                    //     : null,
                                    border: OutlineInputBorder(
                                        gapPadding: 50,
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: mainColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: mainColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: greyColor)),
                                    label: Text(S.of(context).Email,
                                        style: TextStyle(
                                            color: blackColor,
                                            fontFamily: 'Cairo',
                                            fontSize: 13)),
                                  ),
                                  inputFormatters: const <TextInputFormatter>[
                                    // for below version 2 use this
                                    // FilteringTextInputFormatter.allow(
                                    //     RegExp(r'[0-9]')),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (phone) {
                                    // if (emailOTP.text.length != 10) {
                                    //   return S.of(context).errorPhone;
                                    // }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
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
                                            "email": emailOTP.text,
                                          }));
                                      //print(response.statusCode);
                                      if (response.statusCode == 200) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ForgetOTP(
                                                  email: emailOTP.text,
                                                  currentPage:
                                                      "confirmationEmail"),
                                            ));
                                        //print("done");
                                      }
                                      if (response.statusCode == 404) {
                                        //print("not done");
                                        Snackbar(
                                            message: S.of(context).errorEmail,
                                            context: context,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white);
                                      }
                                    } catch (e) {
                                      //print("Error: $e");
                                      Snackbar(
                                          message: S.of(context).errorOccured,
                                          context: context,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white);
                                    }
                                  },
                                  child: Text(
                                    S.of(context).send,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ]),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      )),
    );
  }
}
