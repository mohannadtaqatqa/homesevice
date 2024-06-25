import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class Notification extends StatelessWidget {
  const Notification({super.key});

  Future<List<dynamic>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = int.parse(prefs.getString('userId')!);
    final userType = prefs.getString('userType')!;
    final response = await get(
        Uri.parse('http://10.0.2.2:5000/notification/$userId/$userType'));
    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);
      return resBody;
    } else {
      throw Exception('Failed to fetch notifications: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          S.of(context).Notifications,
          style: TextStyle(
            color: whiteColor,
            fontFamily: "Cairo",
            fontSize: deviceWidth * 0.065, // Adjust font size based on device width
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(deviceWidth * 0.02),
        child: FutureBuilder<List<dynamic>>(
          future: getNotifications(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            final notificationData = snapshot.data ?? [];
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: notificationData.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: deviceHeight * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Get.isDarkMode ? Colors.grey[800] : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:Get.isDarkMode ? Colors.grey.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                height: deviceHeight * 0.1,
                child: ListTile(
                  leading: const Icon(Icons.notifications, ),
                  title: Text(
                    notificationData[index]['notification_title'],
                    style: TextStyle(fontFamily: 'Cairo', fontSize: deviceWidth * 0.05, ),
                  ),
                  subtitle: Text(
                    notificationData[index]['notification_body'],
                    style: TextStyle(fontFamily: 'Cairo', fontSize: deviceWidth * 0.0375, ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
