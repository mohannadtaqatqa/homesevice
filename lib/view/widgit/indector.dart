
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/Color.dart';
class CostomIndicator extends StatelessWidget {
  const CostomIndicator({super.key, required this.dotsindex});
final double? dotsindex ;
  @override
  Widget build(BuildContext context) {
    return  DotsIndicator(
      dotsCount: 3,
      position:dotsindex!.toInt() ,


          decorator: DotsDecorator(color: Colors.transparent,activeColor: mainColor,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color:Colors.blueAccent)) ),
        );

  }
}
