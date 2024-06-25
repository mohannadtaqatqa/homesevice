
import 'package:get/get.dart';
import 'package:homeservice/core/function/auth_with.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Authviewmodel());
  }
  
}