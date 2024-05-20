//  import 'package:flutter/cupertino.dart';

// class SizeConfig{

//   static double? screenwidth;
//   static double? screenhight;
//   static double? defultsize;
//   static Orientation? orientation;
//   void init(BuildContext context){
//     screenwidth =MediaQuery.of(context).size.width;
//     screenhight=MediaQuery.of(context).size.height!;
//     orientation=MediaQuery.of(context).orientation!;

//     defultsize=orientation==Orientation.landscape
//     ? screenhight! *.7
//         :screenwidth!*.7;
//     print('this is defult size:$defultsize');

//   }
//  }
 import 'package:flutter/cupertino.dart';

class SizeConfig{

  static double? screenwidth;
  static double? screenhight;
  static double? defultsize;
  static Orientation? orientation;
  void init(BuildContext context){
    screenwidth =MediaQuery.of(context).size.width;
    screenhight=MediaQuery.of(context).size.height;
    orientation=MediaQuery.of(context).orientation;

    defultsize=orientation==Orientation.landscape
    ? screenhight! *.048
        :screenwidth!*.048;
    print('this is defult size:$defultsize');

  }
 }