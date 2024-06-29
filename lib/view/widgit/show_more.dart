import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/data/model/provider_page.dart';
import 'package:http/http.dart' as http;

import '../../generated/l10n.dart';

class All_service extends StatefulWidget {
  const All_service({super.key});

  @override
  State<All_service> createState() => _All_serviceState();
}

class _All_serviceState extends State<All_service> {
  Future<List<dynamic>> fetchServices() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/service'));
      if (response.statusCode == 200) {
        List<dynamic> resbody = jsonDecode(response.body);
        return resbody;
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Failed to load services: $e');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).servicesinapp,
            style:const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 25,
            )),
      ),
      body: FutureBuilder<List>(
          future: fetchServices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: mainColor),
              );
            }
            // else if (!snapshot.hasData){
            //   return Center(
            //     child: Column(
            //       children: [
            //         Image.asset(
            //           'images/img 404.png',
            //           width: 400,
            //           height: 200,
            //         ),
            //         const SizedBox(height: 20),
            //         Text('You don\'t have any appointments yet.',
            //             style: Theme.of(context).textTheme.headline6),
            //       ],
            //     ),
            //   );
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 0.75),
                itemCount: 14, //snapshot.data!.length
                itemBuilder: (context, index) {
                  List<dynamic> bufferDynamic = snapshot.data![index]
                          ["service_icon"]["data"] is List
                      ? snapshot.data![index]["service_icon"]["data"]
                      : snapshot.data![index]["service_icon"]["data"] is String
                          ? jsonDecode(
                              snapshot.data![index]["service_icon"]["data"])
                          : [snapshot.data![index]["service_icon"]["data"]];
                  List<int> bufferInt =
                      bufferDynamic.map((e) => e as int).toList();
                  return InkWell(
                    onTap: () {
                      Get.to(
                          () => provider_list(
                              serviceID: snapshot.data![index]['servcie_id']),
                          arguments: snapshot.data![index]['servcie_id']);
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      width: 25,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 177, 168, 168),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Color.fromARGB(255, 254, 253, 253),
                              offset: Offset(-5, 0),
                            )
                          ]),
                      child: Column(
                        children: [
                          Image.memory(
                            Uint8List.fromList(bufferInt),
                            height: 38,
                            width: 80,
                          ),
                        const  SizedBox(height: 10),
                        const  SizedBox(
                            width: 50,
                          ),
                          Text(
                            snapshot.data?[index]['servcie_name'],
                            style: const TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
