import 'package:flutter/material.dart';
import 'package:homeservice/data/model/provider_page.dart';

class providerlist extends StatelessWidget {
  const providerlist({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: SafeArea(
        child: provider_list()),
    );
  }
}