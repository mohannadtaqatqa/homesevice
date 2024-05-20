// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:homeservice/view/screen/onbordaringbody.dart';
// import 'package:homeservice/view/screen/onnordingscreen.dart';

// class SpalshScreen extends StatefulWidget {
//   const SpalshScreen({super.key});

//   @override
//   State<SpalshScreen> createState() => _SpalshScreenState();
// }

// class _SpalshScreenState extends State<SpalshScreen> {
//   void initState() {
//     super.initState();
//     goNextview();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(children: [
//         Container(
//           padding: EdgeInsets.all(12),
//           margin: EdgeInsets.only(top: 50),
//           child: Image.asset('images/splashlogo.jpeg'),
//         ),
//         Text(
//           'يَمعَلِم ',
//           style: TextStyle(fontSize: 35),
//         )
//       ]),
//     );
//   }
// }

// void goNextview() {
//   Future.delayed(
//       Duration(
//         seconds: 3,
//       ), () {
//     Get.to(() => BodyBording());
//   });
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/view/screen/onbordaringbody.dart';
import 'package:lottie/lottie.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  void initState() {
    super.initState();
    goNextview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 50),
          child: Lottie.asset('images/slashscreen.json'),
        ),
        const Text(
          'مَنزِلي ',
          style: TextStyle(fontSize: 35),
        )
      ]),
    );
  }
}

void goNextview() {
  Future.delayed(
      const Duration(
        seconds: 3,
      ), () {
    Get.to(() => const BodyBording());
  });
}