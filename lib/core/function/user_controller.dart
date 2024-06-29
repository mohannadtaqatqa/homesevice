import 'package:get/get.dart';

class UserController extends GetxController {
  RxString id = ''.obs;
  RxString userType = ''.obs;
  RxString userFirstName = ''.obs;
  RxString userLastName = ''.obs;
  RxString userPhone = ''.obs;
  RxString userEmail = ''.obs;
  RxString userCity = ''.obs;
  RxString userAddress = ''.obs;

  void setData(Map<String, String> userData) {
    id.value = userData['userId']!;
    userType.value = userData['userType']!;
    userFirstName.value = userData['firstName']!;
    userLastName.value = userData['lastName']!;
    userPhone.value = userData['phone']!;
    userEmail.value = userData['email']!;
    userCity.value = userData['city']!;
    userAddress.value = userData['address']!;
    //print(userData);
  }
}