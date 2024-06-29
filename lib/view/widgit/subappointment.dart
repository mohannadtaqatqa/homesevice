//subappointment
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utilti/color.dart';

String? userId;
String? userType;



  Future<List<Map<String, dynamic>>> fetchAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      userId = prefs.getString('userId')!;
      userType = prefs.getString('userType')!;
      //print(userId);
      final response = await http
          .get(Uri.parse('http://10.0.2.2:5000/appointment/user/$userId'));
      if (response.statusCode == 200) {
        final List resBody = jsonDecode(response.body);
        //print("========>$resBody");
        return resBody.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to fetch appointments: ${response.statusCode}');
      }
    } catch (error) {
      // after will do this
      rethrow;
    }
  }

  Widget appointments = SizedBox(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Map<String, dynamic>> appointments = snapshot.data!;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Card(
                  child: ListTile(
                    title: Text(appointment['service']),
                    subtitle: Text(appointment['date']),
                  ),

                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator(color: mainColor,));
          }
        },
      ),
      );
