// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/details_provider.dart';
import 'package:homeservice/view/screen/acc_rej.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request_provider extends StatefulWidget {
  const Request_provider({Key? key});

  @override
  State<Request_provider> createState() => _provider_listState();
}

Future<List<Map<String, dynamic>>> fetchRequests_provider() async {
  try {
     final prefs = await SharedPreferences.getInstance();
      int userId = int.parse(prefs.getString('userId')!);
    final response =
        await get(Uri.parse('http://10.0.2.2:5000/GetRequestProvider/$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> resBody = jsonDecode(response.body);
      if (resBody is! List) {
        throw Exception('Invalid data format: Expected a list');
      }
      return resBody.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch requests: ${response.statusCode}');
    }
  } catch (error) {
    //leater on
    rethrow;
  }
}

class _provider_listState extends State<Request_provider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('مقدمي الخدمات '),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   elevation: 0,
      //   // automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //         icon: Icon(Icons.arrow_back_ios))
      //   ],
      // ),
      body: FutureBuilder<List<dynamic>>(
          future: fetchRequests_provider(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: mainColor,));
            }
            if (snapshot.hasData) {
              final requests = snapshot.data!;
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Container(
                      width: 250,
                      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      padding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(26, 153, 206, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person,
                              size: 64,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${snapshot.data![index]['customer_fname']} ${snapshot.data![index]['customer_lname']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text("${snapshot.data![index]['phone_num']}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: 15,),
                                  Text("${snapshot.data![index]['disblaystats']}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ]),
                            const Spacer(),
                            // Icon(Icons.arrow_forward_ios,
                            //     size: 30, color: Colors.white),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => const accept_reject(),
                                      arguments:
                                          //  List
                                          detailsp(
                                        id: requests[index]
                                            ['service_requestid'],
                                        fname: requests[index]
                                            ['customer_fname'],
                                        lname: requests[index]
                                            ['customer_lname'],
                                        city: requests[index]['city'],
                                        location: requests[index]['address'],
                                        phone: requests[index]['phone_num'],
                                        servicen: requests[index]
                                            ['servcie_name'],
                                        date: requests[index]['date_request'],
                                        description: requests[index]
                                            ['description'],
                                            status: requests[index]
                                            ['status']
                                      ));
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 30, color: Colors.white))
                          ])));
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
                Text('You don\'t have any requests yet.',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ));
          }),
    );
  }
}