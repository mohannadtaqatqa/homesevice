import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/view/screen/change_settings/change_email.dart';
import 'package:homeservice/view/screen/change_settings/change_pass.dart';
import 'package:homeservice/view/screen/lang.dart';
import 'package:homeservice/view/screen/person_settings.dart';

import '../../generated/l10n.dart';

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
                S.of(context).settingsPrivate,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 50),
              // ElevatedButton(onPressed: () {Get.to(()=> Mysetting(address: data['address']!, firstName: data['firstName']!, lastName: data['lastName']!, email: data['email']!, phoneNumber: data['phone']!, city: data['city']!,));}, child: const Text("الاعدادات الشخصية",style: TextStyle(fontSize: 20),),style: ButtonStyle(
              ElevatedButton(
                onPressed: () {
                  Get.to(() =>const Mysetting());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    foregroundColor: MaterialStateProperty.all(whiteColor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
                child: Text(
                  S.of(context).PersonalSettings,
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              // backgroundColor: MaterialStateProperty.all(mainColor),fo   regroundColor: MaterialStateProperty.all(whiteColor),fixedSize: MaterialStateProperty.all(const Size(200, 50))),),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {Get.to(()=>const ChangeEmail());},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    foregroundColor: MaterialStateProperty.all(whiteColor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
                child:  Text(
                  S.of(context).changeEmail,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(()=>const ChangePassword() );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    foregroundColor: MaterialStateProperty.all(whiteColor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
                child:  Text(
                  S.of(context).changePass,
                  style:const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Language()
            ],
          ),
        ),
      ),
    );
  }
}
