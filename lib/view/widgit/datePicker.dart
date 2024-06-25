import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/DateUtil.dart';
import 'package:homeservice/core/function/controller_datepicker.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/details_provider.dart';
import 'package:homeservice/view/screen/buttom_bar.dart';
import 'package:homeservice/view/screen/home.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/function/snakbar.dart';

class Datepicker extends StatefulWidget {
  Datepicker(
      {super.key,
      // required this.selectedDateController,
      required detailsp this.data,
      required this.serviceID});
  final detailsp data;
  final serviceID;

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  final DescriptionController = TextEditingController();
  final selectedDateController = TextEditingController();
  DateTime? dateValue;

  Future<void> _booking() async {
    final String description = DescriptionController.text.trim();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString("userId");
    // print(id);
    // print(description);
    // print(widget.serviceID);
    // print(selectedDateController.text);
    // print(DateUtil.formatDate(selectedDateController.text));
    // print(widget.data.id);
    if (selectedDateController.text == '' ||
        selectedDateController.text == "0000-00-00 00:00:00.000") {
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
              "serviceid": widget.serviceID.toString(),
              "providerid": widget.data.id.toString(),
              "customerid": id.toString(),
              "date": selectedDateController.text,
              "description": description
            }));
      } catch (e) {
        print('Error: $e');
        Snackbar(message: e.toString(), context: context);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Error occurred, please try again.')));
      }
      Get.off( const Navbar());
      Snackbar(
          message: "تم طلب حجز الخدمة 📩",
          context: context,
          backgroundColor: whiteColor,
          textColor: blackColor);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('تم حجز الخدمة', style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.green,
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: IconButton.styleFrom(
          foregroundColor:
              !Get.isDarkMode ? Colors.blue[300] : Colors.blue[500],
          // fixedSize: const Size(173, 45),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                'اختر تاريخ الحجز',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime now = DateTime.now();
                            final DateTime firstDate =
                                DateTime(now.year, now.month, now.day);
                            final DateTime lastDate = DateTime(
                              now.year + 3,
                            );
                            final datepicker = await showDatePicker(
                              initialDate: now,
                              context: context,
                              firstDate: firstDate,
                              lastDate: lastDate,
                            );

                            if (datepicker != null) {
                              Get.find<updatedate>().changeDate("$datepicker");
                              selectedDateController.text = ("$datepicker");
                            }
                            print(" date is ${selectedDateController.text}");
                            print("${dateValue}");
                          },
                        ),
                        GetBuilder(
                          init: updatedate(),
                          builder: (controller) {
                            return Text(
                              controller.selectedDate.value.isEmpty
                                  ? "الرجاء تحديد التاريخ"
                                  : "${DateUtil.formatDate(controller.selectedDate.value)}",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: DescriptionController,
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hoverColor: mainColor,
                        labelText: "وصف",
                        labelStyle: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: mainColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'الغاء'),
                  child: Text(
                    'إلغاء',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                  ),
                  onPressed: _booking,
                  child: Text(
                    'حجز',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.calendar_month_outlined,
          size: 40,
        ));
  }
}
