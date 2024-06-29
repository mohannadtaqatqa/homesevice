import 'package:get/get.dart';

class Updatedate extends GetxController {
  RxString selectedDate = ''.obs;

  void changeDate(String date) {
    selectedDate.value = date;
    update();
  }
}