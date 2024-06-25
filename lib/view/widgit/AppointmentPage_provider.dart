import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/view/widgit/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String? userId;
String? userType;

class AppointmentPage_provider extends StatelessWidget {
  const AppointmentPage_provider({super.key});

  Future<List<Map<String, dynamic>>> fetchAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId')!;
      userType = prefs.getString('userType')!;
      final response = await http.get(
          Uri.parse('http://10.0.2.2:5000/GETAppointment/provider/$userId'));
      if (response.statusCode == 200) {
        final List resBody = jsonDecode(response.body);
        return resBody.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to fetch appointments: ${response.statusCode}');
      }
    } catch (error) {
      // after will do this
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) =>
            FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchAppointments(),
          builder: (context, snapshot) {
            // if (snapshot.hasError) {
            //   return Center(
            //     child: Text(
            //       'Error fetching appointments: ${snapshot.error}',
            //       style: TextStyle(color: Colors.red),
            //     ),
            //   );
            // }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: mainColor,));
            }

            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/img 404.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Text('You don\'t have any appointments yet.',
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              final appointments = snapshot.data!;
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return Appointment(
                    userType: userType!,
                    customerId: '',
                    providerId: "$userId",
                    fname: appointments[index]['customer_fname'],
                    lname: appointments[index]['customer_lname'],
                    city: appointments[index]['city'],
                    address: appointments[index]['address'],
                    des: appointments[index]['description'],
                    date: DateTime.tryParse(appointments[index]['date'])!,
                    phone: appointments[index]['phone_num'],
                    servname: appointments[index]['servcie_name'], 
                  );
                },
              );
            }

            return Center(
              child: Column(
                children: [
                  Image.asset(
                    'images/img 404.png',
                    width: 400,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text('You don\'t have any appointments yet.',
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            );
            //const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
