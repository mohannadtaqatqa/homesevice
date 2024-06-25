import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/size_config.dart';

class cover extends StatelessWidget {
  const cover({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 420,
      height: 200,
      child: Image.asset('${img}'),
    );
  }
}