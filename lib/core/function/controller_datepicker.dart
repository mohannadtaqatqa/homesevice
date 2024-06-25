import 'package:get/get.dart';

class updatedate extends GetxController {
  RxString selectedDate = ''.obs;

  void changeDate(String date) {
    selectedDate.value = date;
    update();
  }
}
