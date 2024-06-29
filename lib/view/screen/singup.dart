// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/core/utilti/size_config.dart';
import 'package:homeservice/generated/l10n.dart';
import 'package:homeservice/view/screen/login.dart';
import 'package:http/http.dart';
import '../../core/controller.dart';
import '../../data/datasource/static/list_signup.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  Future<List> fetchservices() async {
    final response = await get(Uri.parse('http://10.0.2.2:5000/service'));
    List resbody = jsonDecode(response.body);
    return resbody;
  }
@override
  // void dispose() {
  //   firstnameCotrlr.dispose();
  //   secondnameCntrlr.dispose();
  //   emailCotrlr.dispose();
  //   passwordCotrlr.dispose();
  //   phoneCotrlr.dispose();
  //   addressContr.dispose();
  //   serviceTypeContr.dispose();
  //   cityContr.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    // Reset all text controllers
    fullNameCotrlr.clear();
    firstnameCotrlr.clear();
    secondnameCntrlr.clear();
    emailCotrlr.clear();
    passwordCotrlr.clear();
    phoneCotrlr.clear();
    cityContr.clear();
    userContr.clear();
    serviceTypeContr.clear();
    addressContr.clear();
    s = S.current.PleaseChoose;
    city = S.current.PleaseChoose;
    yourService = S.current.PleaseChoose;
    dateValue = null;
    serviceid = null;
  }
  @override
  Widget build(BuildContext context) {
    // String _emailErrorText;

    // void _validateEmail(String value) {
    //   if (value.isEmpty) {
    //     setState(() {
    //       _emailErrorText = 'Email is required';
    //     });
    //   } else if (!GetUtils.isEmail(value)) {
    //     setState(() {
    //       _emailErrorText = 'Enter a valid email address';
    //     });
    //   } else {
    //     setState(() {
    //       _emailErrorText = '';
    //     });
    //   }
    // }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                child: Column(
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
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        //first name
                        FieldSignup(
                          d: RegExp("[a-zA-Z\u0600-\u06FF]"),
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
                          d: RegExp("[a-zA-Z\u0600-\u06FF]"),
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
                          d: RegExp(r'.*'),
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
                          d: RegExp("[0-9]"),
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
                          d: RegExp(r'.*'),
                          controller: passwordCotrlr,
                          nameField: "  ${S.of(context).password}",
                          obscureText: true,
                          keyboradType: TextInputType.visiblePassword,
                          validator: (val) {
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 9,
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
                              //print(s);
                            },
                            decoration: InputDecoration(
                              labelText: (S.of(context).createaccountaAs),
                              labelStyle: TextStyle(
                                color: blackColor,
                                fontFamily: 'Cairo',
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: greyColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: mainColor)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30),
                              //     borderSide: BorderSide(color: mainColor)),
                              // enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30),
                              //     borderSide: BorderSide(color: greyColor)),
                              // floatingLabelBehavior:OutlineInputBorder( borderSide: BorderSide(color: mainColor))
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        //btn serviceType
                        S.of(context).serviceProvider == s
                            ? SizedBox(
                                width: 296,
                                height: 64,
                                child: FutureBuilder(
                                    future: fetchservices(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                              color: mainColor),
                                        );
                                      }
                                      List<String> services = [
                                        (S.of(context).PleaseChoose)
                                      ];
                                      for (var i = 0;
                                          i < snapshot.data!.length;
                                          i++) {
                                        services.add(snapshot.data![i]
                                                ['servcie_name']
                                            .toString());
                                      }
                                      return DropdownButtonFormField(
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
                                        },
                                        decoration: InputDecoration(
                                          labelText: S.of(context).serviceType,
                                          labelStyle: TextStyle(
                                            color: blackColor,
                                            fontFamily: 'Cairo',
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide:
                                                  BorderSide(color: mainColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide:
                                                  BorderSide(color: mainColor)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                        ),
                                      );
                                    }))
                            : Container(),
                        const SizedBox(
                          height: 9,
                        ),
                        SizedBox(
                            width: 296,
                            height: 64,
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (city == S.of(context).PleaseChoose) {
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
                                labelStyle: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Cairo',
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: mainColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: mainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: greyColor)),
                              ),
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        FieldSignup(
                          d: RegExp(r'.*'),
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
                          height: 0,
                        ),
                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: mainColor,
                                fixedSize: const Size(359.0, 58.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0))),
                            onPressed: () {
                              singup(context, 0, formKey);
                            },
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
                                  color: mainColor, fontFamily: "Cairo"),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            )),
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
      this.maxLength = 70,
      this.enabled = true,
      required this.d});
  final String? Function(String? value) validator;
  final TextEditingController controller;
  final String nameField;
  final bool obscureText;
  final keyboradType;
  int maxLength;
  RegExp d;
  var enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.defultsize,
      height: 58,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: TextFormField(
        enabled: enabled,
        inputFormatters: [FilteringTextInputFormatter.allow(d)],
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboradType,
        maxLength: maxLength,
        cursorColor: blackColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                  color: !Get.isDarkMode
                      ? Colors.black
                      : const Color.fromARGB(230, 255, 255, 255),
                  fontFamily: 'Cairo',
                  fontSize: 13)),
        ),
        validator: validator,
      ),
    );
  }
}
