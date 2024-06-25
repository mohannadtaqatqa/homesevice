// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/details_provider.dart';
import 'package:homeservice/view/widgit/datePicker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n.dart';

class provider_details extends StatefulWidget {
  const provider_details({super.key, this.serviceID});
  final serviceID;
  @override
  State<provider_details> createState() => _provider_detailsState();
}

class _provider_detailsState extends State<provider_details> {
  final TextEditingController DescriptionController = TextEditingController();
  final TextEditingController DateController = TextEditingController();

  //final id = Get.arguments;
  final data = Get.arguments as detailsp;
  // void initState() {
  //   super.initState();
  //   fetchProviderDet(id);
  // }
   void _launchPhone(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);
  }

  void _launchWhatsApp(String number) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: number,
    );
    await launchUrl(whatsappUri);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        height: 200,
        child: Stack(children: [
          Positioned(
              child: Container(
            height: 150,
            color: const Color(0XAAEDE7E7),
          )),
          Positioned(
              top: 90,
              right: 50,
              left: 50,
              child: CircleAvatar(
                radius: 55,
                child: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.width * 0.1,
                ),
              )),
        ]),
      ),
      const SizedBox(
        height: 30,
      ),
      Center(
        child: Text(
          '${data.fname!} ${data.lname}',
          style: const TextStyle(
              fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        // flex: 1,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("  ${S.of(context).Information}",style: const TextStyle(  fontFamily: 'Cairo',),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 15,
                    ),
                     Icon(
                      color: mainColor,
                      Icons.work,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('${data.servicen!}',style: const TextStyle(  fontFamily: 'Cairo',),),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                     Icon(
                      color: mainColor,
                      Icons.location_city,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('${data.city!} - ${data.location!}',style: const TextStyle(  fontFamily: 'Cairo',),),
                  ],
                ),
                SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15, 
                        ),Icon(
                          color: mainColor,
                            Icons.rate_review_outlined,
                            size: 30,
                          ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('${data.rating}',style: const TextStyle(  fontFamily: 'Cairo',),)
                      ],
                    ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                     Icon(
                      color: mainColor,
                      Icons.phone_android_outlined,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("${data.phone!}",style: const TextStyle(  fontFamily: 'Cairo',),),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  "  ${S.of(context).Contact}",
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _launchWhatsApp(data.phone!),
                      child: Image.asset(
                        "images/whatsConcat.png",
                        
                        color: Color.fromARGB(255, 84, 247, 89),
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _launchPhone(data.phone!),
                      child: Icon(
                        Icons.phone,
                        size: 40,
                        color: !Get.isDarkMode? greyColor: whiteColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "  ${S.of(context).AppointmentBooking}",
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Datepicker(
                        data: data,
                        serviceID: widget.serviceID,
                      ),
                    ),
                  ],
                ),
                // Center(
                //     child: ElevatedButton(
                //         onPressed: _booking,
                //         style: ButtonStyle(
                //             // side: MaterialStateBorderSide.resolveWith((states) =>BorderSide( OutlineInputBorder(borderSide: BorderSide.none))),
                //             backgroundColor:
                //                 MaterialStateProperty.all(mainColor),
                //             foregroundColor:
                //                 MaterialStateProperty.all(whiteColor)),
                //         child: Text(S.of(context).reservation)))
              ]),
        ),
      ),
    ]));
  }
}
