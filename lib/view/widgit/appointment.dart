import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/rating.dart';
import 'package:homeservice/generated/l10n.dart';
import 'package:homeservice/view/widgit/AppointmentPage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/function/DateUtil.dart';

// Future<String?>? getUserType() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('userType');
//
// }

class Appointment extends StatefulWidget {
  final String userType;
  final String customerId;
  final String providerId;
  final String fname;
  final String lname;
  final String address;
  final String city;
  final String des;
  final DateTime date;
  final String servname;
  final String phone;

  const Appointment({
    super.key,
    required this.phone,
    required this.providerId,
    required this.customerId,
    required this.fname,
    required this.lname,
    required this.address,
    required this.city,
    required this.des,
    required this.date,
    required this.servname, required this.userType,
  });

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {

  @override
  Widget build(BuildContext context) {
  DateTime today = DateTime.now();
    bool condition = widget.userType == '0' && widget.date.isBefore(today) ;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        padding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  size: 64,
                  color: mainColor,
                ),
                const SizedBox(width: 30),
                Text(
                  "${widget.fname} ${widget.lname}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,fontFamily: 'Cairo',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    "${widget.city} - ${widget.address}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo', 
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${S.of(context).phoneNumber}:",
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Cairo'),
                ),
                const SizedBox(width: 20),
                Text(
                  widget.phone,
                  style: const TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Cairo'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey, height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${S.of(context).theService}:",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Cairo'),
                ),
                const SizedBox(width: 20),
                Text(
                  widget.servname,
                  style: const TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Cairo'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey, height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${S.of(context).description}:",
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Cairo'),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    widget.des,
                    style: const TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, height: 1),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${S.of(context).date}:",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Cairo'),
                ),
                const SizedBox(width: 20),
                Text(
                  DateUtil.formatDate(widget.date.toString()) ,
                  style: const TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Cairo'),
                ),
              ],
            ),
            const SizedBox(height: 10),

                condition ?
                     Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    rating(context, widget.customerId,widget.providerId);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: mainColor,
                  ),
                  child: Text(S.of(context).compulationRating,style: TextStyle(fontFamily: 'Cairo'),),
                ),
              ],
            ): Container()
                  
          ],
        ),
      ),
    );
  }
}
