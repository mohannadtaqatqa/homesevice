import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/color.dart';

class DividerOR extends StatelessWidget {
  const DividerOR({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                child: const Divider(
                  color: Colors.black,
                ))),
        Text(
          'OR',
          style:
              TextStyle(color: mainColor, fontSize: 20, fontFamily: 'Merienda'),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                child: const Divider(
                  color: Colors.black,
                )))
      ],
    );
  }
}
