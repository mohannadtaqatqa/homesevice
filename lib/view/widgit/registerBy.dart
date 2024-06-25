import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/function/auth_with.dart';

class RegisterBy extends GetWidget<Authviewmodel> {
  const RegisterBy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: () {controller.googleSignInMethod();},icon: Image.asset("images/google.png")),
        IconButton(onPressed: () {}, icon: Image.asset("images/apple.png")),
        IconButton(
            onPressed: () {
              controller.facebookLogin();
              print(" facebook"); 
            },
            icon: Image.asset("images/faceIMG.png")),
      ],
    );
  }
}
