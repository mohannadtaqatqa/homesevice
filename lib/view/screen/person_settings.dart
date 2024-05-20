import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/user_controller.dart';
import 'package:homeservice/core/utilti/size_config.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utilti/Color.dart';
import '../../generated/l10n.dart';

class Mysetting extends StatefulWidget {
  const Mysetting({
    super.key,
  });
  @override
  State<Mysetting> createState() => _MysettingState();
}

class _MysettingState extends State<Mysetting> {
  UserController userController = Get.put(UserController());
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataSharedPreferences();
  }

  fetchDataSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    firstNameController.text = prefs.getString('firstName') ?? '';
    lastNameController.text = prefs.getString('lastName') ?? '';
    phoneNumberController.text = prefs.getString('phone') ?? '';
    cityController.text = prefs.getString('city') ?? '';
    addressController.text = prefs.getString('address') ?? '';

    if (firstNameController.text == '' ) {
      firstNameController.text = userController.userFirstName.toString();
    }

    if (lastNameController.text == '' ) {
      lastNameController.text = userController.userLastName.toString();
    }
    if (cityController.text == '' ) {
      cityController.text = userController.userCity.toString();
    }
    if (addressController.text == '' ) {
      addressController.text = userController.userAddress.toString();
    }
    if (phoneNumberController.text == '' ) {
      phoneNumberController.text = userController.userPhone.toString();
    }
  }

  saveDataSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('phone', phoneNumberController.text);
    await prefs.setString('city', cityController.text);
    await prefs.setString('address', addressController.text);

  
          final response =    await post(Uri.parse('http://10.0.2.2:5000/updateinfo'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    "userID": userController.id.toString(),
                    "fname": firstNameController.text,
                    "lname": lastNameController.text,
                    "city": cityController.text,
                    "phone": phoneNumberController.text,
                    "address": cityController.text,
                    "userType": userController.userType.toString(),
                  }));
                  print("${firstNameController.text} ${lastNameController.text} ${phoneNumberController.text} ${cityController.text} ${addressController.text} id ${userController.id} type ${userController.userType}");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text("الصورة"),
                Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: greyColor,
                    ),
                    TextButton(onPressed: () {}, child: Text("تحميل صورة"))
                  ],
                ),
              ]),
              SizedBox(
                height: SizeConfig.screenhight! * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(S.of(context).firstname,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: SizeConfig.defultsize)),
                  Container(
                    height: SizeConfig.screenhight! * 0.06,
                    width: SizeConfig.screenwidth! * 0.4,
                    child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            firstNameController.text =
                                userController.userFirstName.toString();
                          }
                          firstNameController.text = value;
                        },
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: '${userController.userFirstName}',
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenhight! * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(S.of(context).secondname,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: SizeConfig.defultsize)),
                  SizedBox(
                    height: SizeConfig.screenhight! * 0.06,
                    width: SizeConfig.screenwidth! * 0.4,
                    child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            lastNameController.text =
                                userController.userLastName.toString();
                          }
                          lastNameController.text = value;
                        },
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: '${userController.userLastName}',
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenhight! * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    S.of(context).city,
                    style: TextStyle(
                        fontFamily: 'Cairo', fontSize: SizeConfig.defultsize),
                  ),
                  SizedBox(
                    height: SizeConfig.screenhight! * 0.06,
                    width: SizeConfig.screenwidth! * 0.4,
                    child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            cityController.text =
                                userController.userCity.toString();
                          }
                          cityController.text = value;
                        },
                        controller: cityController,
                        decoration: InputDecoration(
                          hintText: '${userController.userCity}',
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenhight! * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(S.of(context).address,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: SizeConfig.defultsize)),
                  SizedBox(
                    height: SizeConfig.screenhight! * 0.06,
                    width: SizeConfig.screenwidth! * 0.4,
                    child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            addressController.text =
                                userController.userAddress.toString();
                          }
                          addressController.text = value;
                        },
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: '${userController.userAddress}',
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenhight! * 0.02,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainColor),
                  foregroundColor: MaterialStateProperty.all(whiteColor),
                  fixedSize: MaterialStateProperty.all(const Size(200, 50)),),
                  onPressed: saveDataSharedPreferences,
                  child: Text("حفظ التغييرات",style: TextStyle(fontSize: SizeConfig.defultsize),),),
                  
            ],
          ),
        ),
      ),
    );
  }
}


////////////////////////
///
///
///
///
///
///
