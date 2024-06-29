import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/data/model/service_mpdel.dart';

import 'package:http/http.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
    Future<List> fetchservices() async {
    //print("inside getX");

    final response = await get(Uri.parse('http://10.0.2.2:4000/service'));
    //print("inside getX2");
    List resbody = jsonDecode(response.body);
    //print(resbody);
    return resbody;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: fetchservices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          }
          // if (snapshot.data.isEmpty) {
          //   Center(
          //     child: Image.asset('name'),
          // }  );

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1/0.75),
              itemCount: 1, //snapshot.data!.length
              itemBuilder: (context, index) {
                return services_body(
                    name: snapshot.data?[index]['srv_name'],
                    icon: snapshot.data?[index]['srv_name']);
              });
        });
  }
}
// return Center(
    //     child: GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 1,
    //     childAspectRatio: 1 / 25,
    //   ),
    //   itemCount: service.length,
    //   itemBuilder: (context, index) {
    //     //print('+++++++++++++++++++========++++=++++ $service');
    //     return Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         // boxShadow:
    //       ),
    //       height: 100,
    //       width: 100,
    //       child: Column(
    //         children: [
    //           Image.asset(
    //             service[index]["srv_icon"],
    //             height: 40,
    //             width: 30,
    //           ),
    //           SizedBox(height: 5),
    //           Text(
    //             service[index]["srv_name"],
    //             style: TextStyle(
    //               fontFamily: 'Cairo',
    //               color: Colors.black,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // )
    //     //}),
    //     );