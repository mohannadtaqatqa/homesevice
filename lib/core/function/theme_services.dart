// //GETx Theme
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class ThemeServices {
//   final GetStorage _box = GetStorage();
//   final _key = 'isDarkMode';

//   _saveThemeToPrefs(bool isDarkMode) =>
//     _box.write(_key, isDarkMode);

//   bool _loadThemeFromPrefs() =>
//      _box.read<bool>(_key) ?? false;

//   ThemeMode get theme => _loadThemeFromPrefs() ? ThemeMode.dark : ThemeMode.light;
//   void switchTheme() {
//     Get.changeThemeMode(_loadThemeFromPrefs() ? ThemeMode.dark : ThemeMode.light);
//     _saveThemeToPrefs(!_loadThemeFromPrefs());
//   }
//   // static saveThemeData(bool isDark) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setBool('isDark', isDark);
//   //   Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
//   // }
// }
