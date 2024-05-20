import 'package:flutter/material.dart';

class imagep extends StatelessWidget {
  const imagep({super.key, required this.image});
final String image ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
      backgroundColor: Colors.black26,
        backgroundImage: AssetImage('${image}') ,
        radius: 60,
      ),
    );
  }
}