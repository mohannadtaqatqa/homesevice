import 'package:flutter/material.dart';

class services_body extends StatefulWidget {
  const services_body({super.key,  required this.name,required this.icon});
  //final int ID;
  final String name;
  final String icon;

  @override
  State<services_body> createState() => _services_bodyState();
}

class _services_bodyState extends State<services_body> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // boxShadow:
      ),
      height: 100,
      width: 100,
      child: Column(
        children: [
          
          Image.asset(
            '${widget.icon}',
            height: 40,
            width: 30,
          ),
          const SizedBox(height: 5),
          Text(
            '{${widget.name}}',
            style: const TextStyle(
              fontFamily: 'Cairo',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    
  }
}