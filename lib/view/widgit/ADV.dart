
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Advertisements extends StatefulWidget {
  const Advertisements({super.key});

  @override
  State<Advertisements> createState() => _AdvertisementsState();
}

class _AdvertisementsState extends State<Advertisements> {
List<ADV> adv = [
    ADV(path: 'images/bop.png'),
    ADV(path: 'images/aelia.png'),
    ADV(path: 'images/pal.jpg')
  ];
 int activindex = 1;

  Widget buildindecator() => AnimatedSmoothIndicator(
        activeIndex: activindex,
        count: adv.length,
        effect: const WormEffect(),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          CarouselSlider.builder(
              options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reaseon) =>
                      setState(() => activindex = index),
                  autoPlay: true,
                  reverse: true),
              //  scrollDirection: Axis.horizontal,
              itemCount: adv.length,
              itemBuilder: (context, i, realindex) {
                return addcard(adv[i]);
              }),
          const SizedBox(
            height: 15,
          ),
          buildindecator(),
        ],
      ),
    );
  }
}














class ADV {
  late String path;

  ADV({required this.path});
}
Widget addcard(adv) => Container(
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Image.asset(adv.path),
        ],
      ),
    );