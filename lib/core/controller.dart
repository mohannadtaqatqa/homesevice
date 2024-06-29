import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/snakbar.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../view/screen/OTP.dart';
import '../view/screen/buttom_bar.dart';
import '../view/screen/navbar_provider.dart';
import 'function/user_controller.dart';

TextEditingController item1 = TextEditingController();
TextEditingController item2 = TextEditingController();
TextEditingController item3 = TextEditingController();
TextEditingController item4 = TextEditingController();

final fullNameCotrlr = TextEditingController();
      List<String> names = fullNameCotrlr.text.split(" ");
final firstnameCotrlr = TextEditingController(text: names[0]);
final secondnameCntrlr = TextEditingController(text: names.length > 1 ? names.sublist(1).join(" ") : "");

  // String fullName = userCredential.user!.displayName!;
  //     String firstName = names[0];
  //     String lastName = names.length > 1 ? names.sublist(1).join(" ") : "";

final emailCotrlr = TextEditingController();
final passwordCotrlr = TextEditingController();
final phoneCotrlr = TextEditingController();
final cityContr = TextEditingController();
final userContr = TextEditingController();
final serviceTypeContr = TextEditingController();
final addressContr = TextEditingController();
String s = S.current.PleaseChoose;
String city = S.current.PleaseChoose;
String? yourService = S.current.PleaseChoose;
DateTime? dateValue;
int? serviceid;



Future<void> singup(BuildContext context, int currentpage, formKey) async {
  String fname = firstnameCotrlr.text.trim();
  String lname = secondnameCntrlr.text.trim();
  String email = emailCotrlr.text.trim();
  String password = passwordCotrlr.text.trim();
  String city = cityContr.text.trim();
  String address = addressContr.text.trim();
  String phoneNumber = phoneCotrlr.text.trim();
  if (formKey.currentState!.validate()) {
        // if (currentpage == 0) {
    try {
      if (userContr.text == S.current.customer) {
        final response =
            await post(Uri.parse('http://10.0.2.2:5000/signup/user'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, String>{
                  "fname": fname,
                  "lastname": lname,
                  "phone": phoneNumber,
                  "city": city,
                  "address": address,
                  "pass": password,
                  "email": currentpage == 0 ? email : emailCotrlr.text,
                  "verify": currentpage == 1 ? "1" : "0"
                }));
        if (response.statusCode == 201) {
          // Snackbar(
          //     message: 'تمت عملية انشاء الحساب',
          //     context: context,
          //     backgroundColor: Colors.green,
          //     textColor: Colors.white);
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('تمت عملية انشاء الحساب',
          //       style: TextStyle(color: Colors.white)),
          //   backgroundColor: Colors.green,
          // ));
        if  (currentpage == 0 )
          {Get.to(()=>
                      //  OTP(
                      //   email: email, currentPage: "signup",

                      // ),
                      ForgetOTP(
                        email: email,
                        currentPage: 'signup',
                      ));}
  else {
        final respo = await post(Uri.parse("http://10.0.2.2:5000/logingoogle"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "email": email,
            }));
        if (respo.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(respo.body);
          responseData['token'] = JwtDecoder.decode(responseData['token']);
          // if (responseData['message'] == "Login successful") {
          final String userType = responseData['token']['userType'].toString();
          final String userEmail = responseData['token']['email'].toString();
          final String userId = responseData['token']['userId'].toString();
          final String firstName = responseData['token']['fname'].toString();
          final String lastName = responseData['token']['lname'].toString();
          final String city = responseData['token']['city'].toString();
          final String address = responseData['token']['address'].toString();
          final String phone = responseData['token']['phone'].toString();
          final String isValid = responseData['token']['isvalid'].toString();
          final prefs = await SharedPreferences.getInstance();
          // ارسال اشعار اذا تمت الموافقة على الطلب
          prefs.setString("userEmail", userEmail);
          prefs.setString("firstName", firstName);
          prefs.setString("lastName", lastName);
          prefs.setString("userId", userId);
          prefs.setString("userType", userType);
          prefs.setString("city", city);
          prefs.setString("address", address);
          prefs.setString("phone", phone);
          // final prefs = await SharedPreferences.getInstance();
          Map<String, String> userData = {
            'userId': prefs.getString('userId')!,
            'userType': prefs.getString('userType')!,
            'firstName': prefs.getString('firstName')!,
            'lastName': prefs.getString('lastName')!,
            'phone': prefs.getString('phone')!,
            'email': prefs.getString('userEmail')!,
            'city': prefs.getString('city')!,
            'address': prefs.getString('address')!,
          };
          // Get.to()

          UserController userController = Get.put(UserController());
          userController.setData(userData);

          if (isValid == "0") {
            if (userType == "0") {
              FirebaseMessaging.instance.subscribeToTopic("ok$userId");
              FirebaseMessaging.instance.subscribeToTopic("reject$userId");
              FirebaseMessaging.instance.subscribeToTopic("suggest$userId");
              FirebaseMessaging.instance.subscribeToTopic("cancel$userId");
              Get.to(() => const Navbar());
            } else if (userType == "1") {
              prefs.setString(
                  "status", responseData['token']['status'].toString());
              FirebaseMessaging.instance.subscribeToTopic("booking$userId");
              FirebaseMessaging.instance.subscribeToTopic("rating$userId");
              FirebaseMessaging.instance.subscribeToTopic("remider$userId");
              FirebaseMessaging.instance.subscribeToTopic("cancel$userId");
              prefs.setString(
                "rating",
                responseData['token']['rating'].toString(),
              );
              prefs.setString(
                "count",
                responseData['token']['count'].toString(),
              );
              // prefs.setString("providerId", responseData['token'][''].toString());
              Get.to(() => const Navbar_Provider());
            }
          }
        }
}


        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          final String errorMessage = responseData['error'];
          Snackbar(
            message: errorMessage,
            context: context,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //     errorMessage,
          //     style: const TextStyle(color: Colors.white),
          //   ),
          //   backgroundColor: Colors.red,
          // ));
        }
      } else {
        final response =
            await post(Uri.parse('http://10.0.2.2:5000/signup/provider'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, String>{
                  "fname": fname,
                  "lastname": lname,
                  "phone": phoneNumber,
                  "city": city,
                  "address": address,
                  "pass": password,
                  "email": currentpage == 0 ? email : emailCotrlr.text,
                  "verify": currentpage == 1 ? "1" : "0",
                  "serviceid": '$serviceid'
                }));
        if (response.statusCode == 201) {
          // Snackbar(
          //   message: 'تمت عملية انشاء الحساب',
          //   context: context,
          //   backgroundColor: Colors.green,
          //   textColor: Colors.white,
          // );

          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('تمت عملية انشاء الحساب',
          //       style: TextStyle(color: Colors.white)),
          //   backgroundColor: Colors.green,
          // ));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForgetOTP(
                        email: email,
                        currentPage: 'signup',
                      )));
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          final String errorMessage = responseData['error'];
          Snackbar(
            message: errorMessage,
            context: context,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );

          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //     errorMessage,
          //     style: const TextStyle(color: Colors.white),
          //   ),
          //   backgroundColor: Colors.red,
          // ));
        }
      }
    } catch (e) {
      Snackbar(
        message: S.current.errorOccured,
        context: context,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
        
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Error occurred, please try again.')));
    }
  } else {
    Snackbar(
      message: S.current.fillAll,
      context: context,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(
    // S.current.errorSignup,
    //     style: const TextStyle(color: Colors.white),
    //   ),
    //   backgroundColor: Colors.red,
    // ));
  }
}
