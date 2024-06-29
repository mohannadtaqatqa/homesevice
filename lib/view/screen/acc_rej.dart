import 'package:flutter/material.dart';
import 'package:homeservice/view/widgit/Request_detais_acc_rej.dart';

class accept_reject extends StatelessWidget {
  const accept_reject({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: SafeArea(
        child: RequestDetaisAccRej()),
    );
  }
}