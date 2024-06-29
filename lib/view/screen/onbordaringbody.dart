import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/view/screen/onnordingscreen.dart';
import 'package:homeservice/view/screen/welcome.dart';
import 'package:homeservice/view/widgit/custom_btn.dart';
import 'package:homeservice/view/widgit/indector.dart';

class BodyBording extends StatefulWidget {
  const BodyBording({super.key});

  @override
  State<BodyBording> createState() => _BodyBordingState();
}

class _BodyBordingState extends State<BodyBording> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(children: [
          onBording(
            pageController: pageController,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              //SizeConfig.defultsize! * 18,
              child: CostomIndicator(
                dotsindex:
                    pageController!.hasClients ? pageController?.page : 0,
              )),
          Visibility(
            visible: pageController!.hasClients
                ? (pageController?.page == 0 ? true : false)
                : false,
            //طول ما هي على الصفر خليها مبينة

            child: const Positioned(
              right: 32,
              top: 30,
              //  top: SizeConfig.defultsize! * 5,
              child: Text(
                'تخطى',
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            //  bottom: SizeConfig.defultsize! * 10,
            //   left: SizeConfig.defultsize! * 10,
            //  right: SizeConfig.defultsize! * 10,
            child: CostumButton(
                onTap: () {
                  if (pageController!.page! < 2) {
                    pageController?.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  } else {
                    Get.to(() => const Welcome());
                  }
                },
                text: pageController!.hasClients
                    ? (pageController?.page == 2 ? 'هيا نبدأ' : 'التالي ')
                    : 'التالي '),
          ),
        ]));
  }
}
/*pageController!.hasClients
                    ? (pageController?.page == 2 ? 'Get Started' : 'Next')
                    : 'Next')*/