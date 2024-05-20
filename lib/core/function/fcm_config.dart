// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

requestPermissionNotification() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

fcmconfig() async {
  await FirebaseMessaging.onMessageOpenedApp.listen((notification) {
    print("Notification ====>");
    print(notification.notification!.title);
    print(notification.notification!.body);
    // FlutterRingtonePlayer().playNotification();
    Get.snackbar(
      notification.notification!.title!,
      notification.notification!.body!,
    );
    // refreshPageNotification(notification);
  });
}

// refreshPageNotification(data) async {
//   print(data['pageid']);
//   print(data['pagename']);
//   print(Get.currentRoute);
// }
