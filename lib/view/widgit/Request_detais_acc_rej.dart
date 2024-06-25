import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/DateUtil.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/details_provider.dart';
import 'package:homeservice/view/widgit/cover.dart';
import 'package:homeservice/view/widgit/personalimage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

class Request_detais_acc_rej extends StatefulWidget {
  const Request_detais_acc_rej({super.key});

  @override
  State<Request_detais_acc_rej> createState() => _provider_detailsState();
}

class _provider_detailsState extends State<Request_detais_acc_rej> {
  //final id = Get.arguments;
  final data = Get.arguments as detailsp;
  
  final TextEditingController DescriptionController = TextEditingController();
  final TextEditingController DateController = TextEditingController();
  Future<void> _newDate() async {
    final String description = DescriptionController.text.trim();

    if (DateController.text == '' ||
        DateController.text == "0000-00-00 00:00:00.000") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('يرجى اختيار تاريخ الحجز',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    } else {
      try {print("id: ${data.id!} suggest appointment");

        await post(Uri.parse('http://10.0.2.2:5000/SugestNewDate/${data.id}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "newdate": DateUtil.formatDate(DateController.text),
              "desc": DescriptionController.text
            }));
            print(" ================================== date: ${DateController.text} description: ${DescriptionController.text}");
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error occurred, please try again.')));
      }
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content:
      //       Text('تم اقتراح موعد اخر  ', style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.green,
      // ));
    }
  }

  Future<void> _accept(int? id) async {
    final res =await post(Uri.parse('http://10.0.2.2:5000/approverequest/$id'));
      if(res.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حجز الخدمة بنجاح"), backgroundColor: Colors.green,));
    }
    else if(res.statusCode == 400){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("هذا الموعد محجوز لمستخدم اخر اما ترفض الطلب او اعادة اقتراح موعد"), backgroundColor: Colors.red,));
    }
  }

  Future<void> _reject(int? id) async {
    await post(Uri.parse('http://10.0.2.2:5000/rejectrequest/$id'));
  }

  DateTime? dateValue;
  final formatter = DateFormat.yMd();

  // void initState() {
  //   super.initState();
  //   fetchProviderDet(id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:   Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              const Stack(clipBehavior: Clip.none, children: <Widget>[
                cover(img: 'images/backgroundImg-removebg-preview.png'),
                Positioned(
                  bottom: -50,
                  left: 130,
                  child: imagep(image: 'images/main-Image.png'),
                ),
              ]),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  '${data.fname!} ${data.lname}',
                  style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Icon(color: mainColor,
                    Icons.work,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(" الخدمة المطلوبة: ${data.servicen!}",style: const TextStyle(  fontFamily: 'Cairo',),),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
               Icon(color: mainColor,
                    Icons.location_city,
                    size: 30,
                  ), const SizedBox(
                    width: 15,
                  ),
                     Text('${data.city!} - ${data.location!}',style: const TextStyle(  fontFamily: 'Cairo',),),
                  
                  
          
                  // Row(
                  //   children: [
                  //     Icon(color: mainColor,
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
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Icon(color: mainColor,
                    Icons.phone_android_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(data.phone!,style: const TextStyle(  fontFamily: 'Cairo',),),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Icon(color: mainColor,
                    Icons.calendar_month_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(DateUtil.formatDate(data.date!),style: const TextStyle(  fontFamily: 'Cairo',),),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Icon(color: mainColor,
                    Icons.description_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(child: Text(data.description!,maxLines: null,softWrap: true,style: const TextStyle(  fontFamily: 'Cairo',),)),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (data.status == 0)
                    ElevatedButton(
                      onPressed: () {
                        _accept(data.id);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // Set text color
                      ),
                      child: Text(S.of(context).approved,style: const TextStyle(  fontFamily: 'Cairo',),),
                    ),
                  if (data.status == 0)
                    ElevatedButton(
                      onPressed: () {
                        _reject(data.id);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red, // Set text color
                      ),
                      child: Text(S.of(context).reject,style: const TextStyle(  fontFamily: 'Cairo',),),
                    ),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (data.status == 0)
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: ElevatedButton(
                          onPressed: () {
                            DateTime? dateValue;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Center(
                                    child: Text(S.of(context).suggestednew)),
                                content: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                final DateTime now =
                                                    DateTime.now();
                                                final DateTime firstDate =
                                                    DateTime(now.year, now.month,
                                                        now.day);
                                                final DateTime lastDate =
                                                    DateTime(
                                                  now.year + 3,
                                                );
                                                final datepicker =
                                                    await showDatePicker(
                                                        initialDate: now,
                                                        context: context,
                                                        firstDate: firstDate,
                                                        lastDate: lastDate);
                                                if (datepicker != null) {
                                                  setState(() {
                                                    dateValue = datepicker;
                                                    DateController.text =
                                                        datepicker.toString();
                                                  });
                                                }
                                              },
                                              icon:  Icon(color: mainColor,
                                                  Icons.calendar_month_outlined)),
                                          Text(dateValue == null
                                              ? "date"
                                              : formatter.format(dateValue!)),
                                        ],
                                      ),
                                       TextField(
                                        controller: DescriptionController,
                                        keyboardType: TextInputType.text,
                                        decoration:
                                            InputDecoration(labelText: "وصف"),
                                      )
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      print("done"),
                                      _newDate(),
                                      Navigator.pop(context, 'OK'),
                                      Get.back()
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.amber, // Set text color
                          ),
                          child: Text(S.of(context).suggestednew,style: const TextStyle(  fontFamily: 'Cairo',),),
                        ),
                      )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
