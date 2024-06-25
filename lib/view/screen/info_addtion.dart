import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeservice/view/screen/singup.dart';
import 'package:http/http.dart';

import '../../core/controller.dart';
import '../../core/utilti/Color.dart';
import '../../data/datasource/static/list_signup.dart';
import '../../generated/l10n.dart';

class InfoAddition extends StatefulWidget {
  const InfoAddition({super.key});

  @override
  State<InfoAddition> createState() => _InfoAdditionState();
}

class _InfoAdditionState extends State<InfoAddition> {
  final formKey = GlobalKey<FormState>();
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text("اكمل معلوماتك",style: TextStyle(color: whiteColor,fontFamily: 'Cairo'),),
        ),
        body: SafeArea(
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
                      services.add(snapshot.data![i]['servcie_name'].toString());
                    }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        FieldSignup(
                          enabled: false,
                          nameField: "Full Name",
                          keyboradType: TextInputType.text,
                          controller: fullNameCotrlr,
                          obscureText: false,
                          maxLength: 10,
                          d: RegExp("[a-zA-Z]"),
                          validator: (String? value) {},
                        ),
                        FieldSignup(
                          enabled: false,
                          nameField: S.of(context).Email,
                          keyboradType: TextInputType.emailAddress,
                          controller: emailCotrlr,
                          obscureText: false,
                          maxLength: 10,
                          d: RegExp("[a-zA-Z]"),
                          validator: (String? value) {},
                        ),
                        FieldSignup(
                          nameField: S.of(context).phoneNumber,
                          keyboradType: TextInputType.number,
                          controller: phoneCotrlr,
                          obscureText: false,
                          maxLength: 10,
                          d: RegExp("[0-9]"),
                          validator: (String? value) {},
                        ),
                        FieldSignup(
                          nameField: S.of(context).password,
                          keyboradType: TextInputType.text,
                          controller: passwordCotrlr,
                          obscureText: true,
                          maxLength: 10,
                          d: RegExp(r'.*'),
                          validator: (String? value) {},
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
                              labelText: (S.of(context).createaccountaAs),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: greyColor)),
                              // floatingLabelBehavior:OutlineInputBorder( borderSide: BorderSide(color: mainColor))
                            ),
                          ),
                        ),
                        //btn serviceType
                        S.of(context).serviceProvider == s
                            ? SizedBox(
                                width: 296,
                                height: 64,
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (yourService == S.of(context).PleaseChoose) {
                                      return S.of(context).errorServiceType;
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
                                    serviceid = services.indexOf(value) + 1;
                                    // snapshot.data![1]['service'];
                                    print(serviceid);
                                  },
                                  decoration: InputDecoration(
                                    labelText: S.of(context).serviceType,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: mainColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: greyColor)),
                                  ),
                                ))
                            : Container(),
                      
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: greyColor)),
                              ),
                            )),
                            SizedBox(height: 10,),
                            FieldSignup(controller: addressContr, nameField: S.of(context).address, obscureText: false, validator: (String? value) {}, d: RegExp("[a-zA-Z]"), maxLength: 10, keyboradType: TextInputType.text,),
                            SizedBox(
                              height: 20,
                            ),
                                TextButton(
                                        style: TextButton.styleFrom(
                                            // backgroundColor: Colors.blue[900],
                                            backgroundColor: mainColor,
                                            fixedSize: const Size(359.0, 58.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                        onPressed: () {
                                          singup(context, 1, formKey);
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
                      ]),
                    ),
                  );
                })));
  }
}
