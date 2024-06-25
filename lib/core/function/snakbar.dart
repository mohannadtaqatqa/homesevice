import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';

class Snackbar {
  final String message;
  final BuildContext context;
  final Color backgroundColor;
  final Color textColor;

  Snackbar({
    required this.message,
    required this.context,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) {
    showSnackBar();
  }

  void showSnackBar() {
    FloatingSnackBar(
      context:context,
      message: message,
      // textColor: textColor,
      textStyle:  TextStyle(fontSize: 18,fontFamily: 'Cairo',color: textColor),
      duration: const Duration(milliseconds: 4000),
      backgroundColor: backgroundColor,
    );
  }
}
