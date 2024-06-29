import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/view/screen/lang.dart';
import 'package:homeservice/view/screen/login.dart';
import 'package:homeservice/view/screen/singup.dart';
import 'package:homeservice/view/widgit/registerBy.dart';

import '../../generated/l10n.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double localeHight = constraints.maxHeight;
          double localeWidth = constraints.maxWidth;
          return SizedBox(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('images/login.jpg'),
                      //image: AssetImage('images\lo'),
                      height: localeHight * 0.3,
                      width: localeWidth * 0.5,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).welcome,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                    SizedBox(
                      height: localeHight * .01,
                      // height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      S.of(context).welcomeIn,
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          // backgroundColor: Colors.blue[900],
                          backgroundColor: mainColor,
                          fixedSize: const Size(200.0, 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))),
                      onPressed: () {
                        Get.to(() => const login());
                        // (Navigator.pushNamed(context, "/login"));
                      },
                      child: Container(
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 20.0,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 0,
                      shadowColor: blackColor,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.black,

                            // backgroundColor: Colors.blue[900],
                            backgroundColor: whiteColor,
                            fixedSize: const Size(200.0, 50.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0))),
                        onPressed: () {
                          (Get.to(() => const Register()));
                        },
                        child: Container(
                          child: Text(
                            S.of(context).SingUp,
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 20.0,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Text(S.of(context).createaccountWith,style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const RegisterBy(),
                    ),
                    const Language()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
