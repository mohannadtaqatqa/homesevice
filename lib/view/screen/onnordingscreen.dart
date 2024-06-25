import 'package:flutter/material.dart';
import 'package:homeservice/data/datasource/static/static.dart';

class onBording extends StatelessWidget {
  const onBording({super.key, this.pageController});
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: onBordinglist.length,
        itemBuilder: (context, i) => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  onBordinglist[i].image!,
                  height: 300,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin:const EdgeInsets.symmetric(horizontal:20),
                child: Text(
                  textAlign:TextAlign.center,
                  onBordinglist[i].titel!,
                  style:const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(height: 20,),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Text(
                  onBordinglist[i].subtitle!,
                  style: const TextStyle(
                      fontSize: 15, fontFamily: 'Cairo', letterSpacing: 0),
                  textAlign: TextAlign.center,
                ),
              ),
              // SizedBox(height: ,)
            ],
          ),
        ),
      ),
    );
  }
}
