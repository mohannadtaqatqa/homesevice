// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/details_provider.dart';
import 'package:homeservice/view/widgit/datePicker.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homeservice/core/function/DateUtil.dart';
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

  Future<void> _booking() async {
    final String description = DescriptionController.text.trim();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString("userId");
    print(id);
    print(description);
    print(widget.serviceID);
    print(DateController.text);
    print(DateUtil.formatDate(DateController.text));
    print(data.id);
    if (DateController.text == '' ||
        DateController.text == "0000-00-00 00:00:00.000") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('يرجى اختيار تاريخ الحجز',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    } else {
      try {
        await post(Uri.parse('http://10.0.2.2:5000/booking'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "serviceid": "${widget.serviceID}",
              "providerid": data.id.toString(),
              "customerid": id.toString(),
              "date": DateController.text,
              "description": description
            }));
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error occurred, please try again.')));
      }
      Navigator.pop(context);
      Navigator.pop(context);
      FirebaseMessaging.instance.subscribeToTopic("booking");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('تم حجز الخدمة',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ));
    }
  }

  // void initState() {
  //   super.initState();
  //   fetchProviderDet(id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      // const Stack(clipBehavior: Clip.none, children: <Widget>[
      //   // cover(img: 'img'),
      //   // Positioned(
      //   //   bottom: -50,
      //   //   left: 130,
      //   //   child: imagep(image: 'images/Vector.png'),
      //   // ),
      // ]),

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
                Text("  ${S.of(context).Information}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 15,
                    ),
                    const Icon(
                      Icons.work,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('${data.servicen!}'),
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
                    const Icon(
                      Icons.location_city,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('${data.city!} - ${data.location!}'),

                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.rate_review_outlined,
                    //       size: 30,
                    //     ),
                    //     SizedBox(
                    //       width: 15,
                    //     ),
                    //     Text('${snapshot.data?.rating}')
                    //   ],
                    // )
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
                    const Icon(
                      Icons.phone_android_outlined,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("${data.phone!}"),
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
                    Image.asset(
                      "images/whatsConcat.png",
                      color: Colors.green,
                      fit: BoxFit.cover,
                    ),
                    Icon(
                      Icons.phone,
                      size: 40,
                      color: greyColor,
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
                        selectedDateController: DateController,
                        DescriptionController: DescriptionController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: _booking,
                        style: ButtonStyle(
                            // side: MaterialStateBorderSide.resolveWith((states) =>BorderSide( OutlineInputBorder(borderSide: BorderSide.none))),
                            backgroundColor:
                                MaterialStateProperty.all(mainColor),
                            foregroundColor:
                                MaterialStateProperty.all(whiteColor)),
                        child: Text(S.of(context).reservation)))
              ]),
        ),
      ),
    ]));
  }
}
