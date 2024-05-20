

import 'package:flutter/material.dart';

class RegisterBy extends StatelessWidget {
  const RegisterBy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {},
            icon:Image.asset("images/google.png")),
        IconButton(
            onPressed: () {},
            icon: Image.asset("images/apple.png")),
        IconButton(
            onPressed: () {},
            icon: Image.asset("images/faceIMG.png")),
      ],
    );
  }
}
