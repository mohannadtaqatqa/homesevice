import 'package:flutter/material.dart';
class Cover extends StatelessWidget {
  const Cover({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 420,
      height: 200,
      child: Image.asset(img),
    );
  }
}