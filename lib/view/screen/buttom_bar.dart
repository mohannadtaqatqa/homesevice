import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/view/screen/appointment.dart';
import 'package:homeservice/view/screen/home.dart';
import 'package:homeservice/view/screen/notification_page.dart' as no;
import 'package:homeservice/view/screen/settings_app.dart';
class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<Widget> pageWidget = [
    const HomePage(),
    const Appointement(),
    const no.Notification(),
    const Account(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items;
    items = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month_outlined,
          ),
          label: 'الحجوزات'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.notifications), label: 'اشعارات'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الحساب'),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          selectedItemColor: mainColor,
          unselectedItemColor: Get.isDarkMode ? Colors.white70  : const Color(0xAA8C8787),
          elevation: 10,
          // showSelectedLabels: true,
          showUnselectedLabels: true,
          // selectedFontSize: 14,
          // unselectedFontSize: 12,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            //print(index);
          },
        ),
        body: pageWidget[selectedIndex]);
  }
}