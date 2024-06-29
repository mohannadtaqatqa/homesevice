import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/l10n.dart';
import '../widgit/mybookingcard.dart';

class Request extends StatelessWidget {
  const Request({super.key});

  Future<List<Map<String, dynamic>>> fetchRequests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int userId = int.parse(prefs.getString('userId')!);
      final response =
          await get(Uri.parse('http://10.0.2.2:5000/request/user/$userId'));
      if (response.statusCode == 200) {
        final List<dynamic> resBody = jsonDecode(response.body);
        // if (resBody is! List) {
        //   throw Exception('Invalid data format: Expected a list');
        // }
        return resBody.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to fetch requests: ${response.statusCode}');
      }
    } catch (error) {
      //leater on
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
          future: fetchRequests(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amberAccent,
                ),
              );
            }

            if (snapshot.hasData) {
              final requests = snapshot.data!;
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  String dateString = requests[index]['date_request'];
                  DateTime originalDate = DateTime.parse(dateString);
                  DateTime date = originalDate.add(const Duration(days: 1));
                  DateTime newDate2 = DateTime.tryParse(requests[index]['newdate'])!.add(const Duration(days: 1));
                  return cardBoking(
                    // Extract request details from the map
                    requestid: requests[index]['service_requestid'],
                    name1: requests[index]['provider_fname'],
                    name2: requests[index]['provider_lname'],
                    phone: requests[index]['provider_phone'],
                    servicename: requests[index]['servcie_name'],
                    datereq: date.toIso8601String(),
                    descrbtion: requests[index]['description'],
                    city: requests[index]['city'],
                    address: requests[index]['address'],
                    status: requests[index]['status'],
                    newDate: newDate2.toIso8601String(),
                    statustext: requests[index]['disblaystats'],
                  );
                },
              );
            }

            return Center(
                child: Column(
              children: [
                Image.asset(
                  'images/img 404.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(S.of(context).norequest),
              ],
            ));
          },
        ),
      ),
    );
  }
}
