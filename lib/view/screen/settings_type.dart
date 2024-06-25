import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/view/screen/change_settings/change_email.dart';
import 'package:homeservice/view/screen/change_settings/change_pass.dart';
import 'package:homeservice/view/screen/lang.dart';
import 'package:homeservice/view/screen/person_settings.dart';

class SettingType extends StatelessWidget {
  const SettingType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "الإعدادات الخاصة",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 50),
              // ElevatedButton(onPressed: () {Get.to(()=> Mysetting(address: data['address']!, firstName: data['firstName']!, lastName: data['lastName']!, email: data['email']!, phoneNumber: data['phone']!, city: data['city']!,));}, child: const Text("الاعدادات الشخصية",style: TextStyle(fontSize: 20),),style: ButtonStyle(
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Mysetting());
                },
                child: Text(
                  "الاعدادات الشخصية",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    foregroundColor: MaterialStateProperty.all(whiteColor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
              ),

              // backgroundColor: MaterialStateProperty.all(mainColor),fo   regroundColor: MaterialStateProperty.all(whiteColor),fixedSize: MaterialStateProperty.all(const Size(200, 50))),),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {Get.to(()=>ChangeEmail());},
                child: const Text(
                  "تغيير البريد الالكتروني",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    foregroundColor: MaterialStateProperty.all(whiteColor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(()=>ChangePassword() );
                },
                child: const Text(
                  "تغيير كلمة المرور",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    foregroundColor: MaterialStateProperty.all(whiteColor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
              ),
              SizedBox(height: 20),
              Language()
            ],
          ),
        ),
      ),
    );
  }
}
