// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/core/utilti/size_config.dart';
import 'package:homeservice/generated/l10n.dart';
import 'package:homeservice/view/screen/OTP.dart';
import 'package:homeservice/view/screen/login.dart';
import 'package:http/http.dart';
import '../../data/datasource/static/list_signup.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final firstnameCotrlr = TextEditingController();
  final secondnameCntrlr = TextEditingController();
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
  Future<void> _singup() async {
    String fname = firstnameCotrlr.text.trim();
    String lname = secondnameCntrlr.text.trim();
    String email = emailCotrlr.text.trim();
    String password = passwordCotrlr.text.trim();
    String city = cityContr.text.trim();
    String address = addressContr.text.trim();
    String phoneNumber = phoneCotrlr.text.trim();
    if (formKey.currentState!.validate()) {
      print(userContr.text);
      try {
        if (userContr.text == S.of(context).customer) {
          print("custommert");
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
                    "email": email
                  }));
          if (response.statusCode == 201) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('تمت عملية انشاء الحساب',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
            ));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        //  OTP(
                        //   email: email, currentPage: "signup",

                        // ),
                        forgetOTP(
                          email: email,
                          currentPage: 'signup',
                        )));
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
        } else {
          print("provideeeeeeeeeer");
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
                    "email": email,
                    "serviceid": '$serviceid'
                  }));
          if (response.statusCode == 201) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('تمت عملية انشاء الحساب',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
            ));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        forgetOTP(
                          email: email,
                          currentPage: 'signup',
                        )));
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
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error occurred, please try again.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          S.current.errorSignup,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    firstnameCotrlr.dispose();
    secondnameCntrlr.dispose();
    emailCotrlr.dispose();
    passwordCotrlr.dispose();
    phoneCotrlr.dispose();
    super.dispose();
  }

  Future<List> fetchservices() async {
    print("inside getX");
    final response = await get(Uri.parse('http://10.0.2.2:5000/service'));
    print("inside getX2");
    List resbody = jsonDecode(response.body);
    print(resbody);
    return resbody;
  }

  @override
  Widget build(BuildContext context) {
    String _emailErrorText;

    void _validateEmail(String value) {
      if (value.isEmpty) {
        setState(() {
          _emailErrorText = 'Email is required';
        });
      } else if (!GetUtils.isEmail(value)) {
        setState(() {
          _emailErrorText = 'Enter a valid email address';
        });
      } else {
        setState(() {
          _emailErrorText = '';
        });
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: fetchservices(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: mainColor),
                      );
                    }
                    List<String> services = ['${S.of(context).PleaseChoose}'];
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      print(snapshot.data![i]["servcie_name"]);
                      services
                          .add(snapshot.data![i]['servcie_name'].toString());
                      // services.add(snapshot.data![i]["service_name"]);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            S.of(context).SingUp,
                            // 'Register A New Acount',
                            style: TextStyle(
                                fontSize: 25,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo"),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              children: [
                                //first name
                                FieldSignup(
                                  controller: firstnameCotrlr,
                                  nameField: "  ${S.of(context).firstname}",
                                  obscureText: false,
                                  keyboradType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty &&
                                        !(value.contains(RegExp(r'^[0-9]')))) {
                                      return S.of(context).erroeFirstName;
                                    }
                                    return null;
                                  },
                                ),
                                //second name
                                FieldSignup(
                                  controller: secondnameCntrlr,
                                  nameField: "  ${S.of(context).secondname}",
                                  obscureText: false,
                                  keyboradType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).errorSecondName;
                                    }
                                    return null;
                                  },
                                ),
                                //email
                                FieldSignup(
                                  controller: emailCotrlr,
                                  nameField: "  ${S.of(context).Email}",
                                  obscureText: false,
                                  keyboradType: TextInputType.text,
                                  validator: (value) {
                                    if (!GetUtils.isEmail(value!)) {
                                      return S.of(context).errorEmail;
                                    }
                                    return null;
                                  },
                                ),
                                //phone
                                FieldSignup(
                                  maxLength: 10,
                                  controller: phoneCotrlr,
                                  nameField: "  ${S.of(context).phoneNumber}",
                                  obscureText: false,
                                  keyboradType: TextInputType.number,
                                  validator: (value) {
                                    if (value.toString().length != 10) {
                                      return S.of(context).errorPhone;
                                    }

                                    return null;
                                  },
                                ),
                                //pass
                                FieldSignup(
                                  controller: passwordCotrlr,
                                  nameField: "  ${S.of(context).password}",
                                  obscureText: true,
                                  keyboradType: TextInputType.visiblePassword,
                                  validator: (val) {},
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                //btn userType
                                SizedBox(
                                  width: 296,
                                  height: 64,
                                  child: DropdownButtonFormField(
                                    validator: (value) {
                                      if (s == S.of(context).PleaseChoose) {
                                        return S.of(context).errorUserType;
                                      }
                                      return null;
                                    },
                                    value: s,
                                    items: userType
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        s = value!;
                                      });
                                      userContr.text = value!;
                                      print(s);
                                    },
                                    decoration: InputDecoration(
                                      labelText:
                                          (S.of(context).createaccountaAs),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: mainColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: greyColor)),
                                      // floatingLabelBehavior:OutlineInputBorder( borderSide: BorderSide(color: mainColor))
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //btn serviceType
                                S.of(context).serviceProvider == s
                                    ? SizedBox(
                                        width: 296,
                                        height: 64,
                                        child: DropdownButtonFormField(
                                          validator: (value) {
                                            if (yourService ==
                                                S.of(context).PleaseChoose) {
                                              return S
                                                  .of(context)
                                                  .errorServiceType;
                                            }
                                            return null;
                                          },
                                          value: yourService,
                                          items: services
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e,
                                                        style: const TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 16)),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            yourService = value;
                                            serviceTypeContr.text = value!;
                                            serviceid =
                                                services.indexOf(value) + 1;
                                            // snapshot.data![1]['service'];
                                            print(serviceid);
                                          },
                                          decoration: InputDecoration(
                                            labelText:
                                                S.of(context).serviceType,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mainColor)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: greyColor)),
                                          ),
                                        ))
                                    : Container(),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 296,
                                    height: 64,
                                    child: DropdownButtonFormField(
                                      validator: (value) {
                                        if (city ==
                                            S.of(context).PleaseChoose) {
                                          return S.of(context).errorCity;
                                        }
                                        return null;
                                      },
                                      value: city,
                                      items: cities
                                          .map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        city = value!;
                                        cityContr.text = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: S.of(context).city,
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: mainColor)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: greyColor)),
                                      ),
                                    )),
                                FieldSignup(
                                  controller: addressContr,
                                  nameField: "  ${S.of(context).address}",
                                  obscureText: false,
                                  keyboradType: TextInputType.text,
                                  validator: (value) {
                                    if (value! == "" || value.length < 4) {
                                      return S.of(context).errorAddress;
                                    }
                                    return null;
                                  },
                                  maxLength: 50,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Center(
                                  child:
                                      //  Datepicker()
                                      TextButton(
                                    style: TextButton.styleFrom(
                                        // backgroundColor: Colors.blue[900],
                                        backgroundColor: mainColor,
                                        fixedSize: const Size(359.0, 58.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0))),
                                    onPressed: _singup,
                                    child: Text(
                                      S.of(context).register,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "Cairo"),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(const login());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).alreadyhaveaccount,
                                  style: const TextStyle(fontFamily: "Cairo"),
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(() => const login());
                                    },
                                    child: Text(
                                      " ${S.of(context).login}",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontFamily: "Cairo"),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

//Fields Signup
class FieldSignup extends StatelessWidget {
  FieldSignup(
      {super.key,
      required this.controller,
      required this.nameField,
      required this.obscureText,
      this.keyboradType,
      required this.validator,
      this.maxLength = 70});
  final String? Function(String? value) validator;
  final TextEditingController controller;
  final String nameField;
  final bool obscureText;
  final keyboradType;
  int maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.defultsize,
      height: 060,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboradType,
        maxLength: maxLength,
        cursorColor: blackColor,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: mainColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: mainColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: greyColor)),
          label: Text(nameField,
              style: TextStyle(
                  color: blackColor, fontFamily: 'Cairo', fontSize: 13)),
        ),
        validator: validator,
      ),
    );
  }
}
