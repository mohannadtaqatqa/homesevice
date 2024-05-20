// import 'package:flutter/material.dart';
// import 'package:homeservice/core/utilti/Color.dart';
// import 'package:homeservice/core/utilti/size_config.dart';

// class CostumButton extends StatefulWidget {
//   const CostumButton({super.key,@required this.text,this.onTap});
//    final String? text;
//      final VoidCallback? onTap;

//   @override
//   State<CostumButton> createState() => _CostumButtonState();
// }

// class _CostumButtonState extends State<CostumButton> {
// @override
//   Widget build(BuildContext context) {

//     return GestureDetector(
//       onTap:widget.onTap ,
//       child: Container(

//         decoration: BoxDecoration(

//           borderRadius: BorderRadius.circular(8),
//           color: mainColor,

//         ),
//         height: 50,
//         width: SizeConfig.screenwidth,
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text('${widget.text}',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
//         ),

//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/core/utilti/size_config.dart';

class CostumButton extends StatefulWidget {
  const CostumButton({super.key,@required this.text,this.onTap});
   final String? text;
     final VoidCallback? onTap;

  @override
  State<CostumButton> createState() => _CostumButtonState();
}

class _CostumButtonState extends State<CostumButton> {
@override
  Widget build(BuildContext context) {

    var container = Container(

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(8),
          color: mainColor,

        ),
        height: 50.0,
       width: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('${widget.text}',textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontSize: 20),),
        ),

      );
    return GestureDetector(
      onTap:widget.onTap ,
      child: container,
    );
  }
}