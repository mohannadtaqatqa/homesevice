import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utilti/Color.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String selectedLang = 'ar';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
              // backgroundColor: Colors.blue[900],
              backgroundColor: mainColor,
              fixedSize: const Size(110.0, 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0))),
          onPressed: () {
            ;
          },
          child: Container(
            child: DropdownButton(
              items: const [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'ar',
                  child: Text('العربية'),
                ),
              ],
              onChanged: (value) async {
                setState(() {
                  selectedLang = value!;
                });
                shareLocal(value.toString());
                Get.updateLocale(Locale(selectedLang));
              },
              value: selectedLang,
            ),
          ),
        ),
      ],
    );
  }
}

shareLocal(String lang) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("lang", lang);
}
