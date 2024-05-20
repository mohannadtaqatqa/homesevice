import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/data/model/provider_page.dart';
import 'package:homeservice/view/widgit/ADV.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../widgit/show_more.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({
    super.key,
  });

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Future<List> fetchservices() async {
    print("inside getX");

    final response = await get(Uri.parse('http://10.0.2.2:5000/service'));
    print("inside getX2");
    List resbody = jsonDecode(response.body);
    print(resbody);
    return resbody;
  }

//    final SecureStorageService storageService = SecureStorageService();
//   String username='';
//    void initState() {
//     super.initState();
//     readValue(); // Read user ID on initialization
//   }
//  Future<void> readValue() async {
//      username = (await storageService.read('userName'))!;
//      setState(() {});
//   }

//
  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("firstName")!;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
            left: true,
            child: FutureBuilder(
              future: getName(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //     search(),
                            //     SizedBox(
                            //       width: 30,
                            //     ),
                            //     IconButton(
                            //         onPressed: () {},
                            //         icon: Icon(
                            //           Icons.notifications,
                            //           color: mainColor,
                            //           size: 30,
                            //         ))

                            Expanded(
                              child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  child: Text(
                                    "  ${S.of(context).welcome} ${snapshot.data} 💁‍♂️",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Flexible(child: Advertisements()),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              S.of(context).Services,
                              style: const TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(
                              width: 200,
                            ),
                            InkWell(
                              onTap: () => {Get.to(() => const All_service())},
                              child: const Text("عرض المزيد",
                                  style: TextStyle(
                                      fontFamily: 'cairo',
                                      fontSize: 18,
                                      color: Colors.amberAccent),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Flexible(
                            child: FutureBuilder<List>(
                                future: fetchservices(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: mainColor),
                                    );
                                  }
                                  return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 1 / 0.75),
                                      itemCount: 3, //snapshot.data!.length
                                      itemBuilder: (context, index) {
                                        // var image;
                                        // image = snapshot.data![index]['service_icon'];
                                        // print(image);
                                        List<dynamic> bufferDynamic = snapshot
                                                    .data![index]
                                                ["service_icon"]["data"] is List
                                            ? snapshot.data![index]
                                                ["service_icon"]["data"]
                                            : snapshot.data![index]
                                                        ["service_icon"]["data"]
                                                    is String
                                                ? jsonDecode(snapshot
                                                        .data![index]
                                                    ["service_icon"]["data"])
                                                : [
                                                    snapshot.data![index]
                                                        ["service_icon"]["data"]
                                                  ];
                                        List<int> bufferInt = bufferDynamic
                                            .map((e) => e as int)
                                            .toList();
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                                () => provider_list(
                                                    serviceID:
                                                        snapshot.data![index]
                                                            ['servcie_id']),
                                                arguments: snapshot.data![index]
                                                    ['servcie_id']);
                                          },
                                          child: Container(
                                            height: 50,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            width: 25,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 177, 168, 168),
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 5),
                                                  ),
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 254, 253, 253),
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
                                                SizedBox(height: 10,width: 50),
                                                Text(
                                                  snapshot.data?[index]
                                                      ['servcie_name'],
                                                  style: const TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                                // Image.memory(base64Decode(image))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }))
                      ],
                    );
                  }
                }
              },
            )),
      ),
    );
  }
}

/*
Future<List> fetchservices() async {
    print("inside getX");

    final response = await get(Uri.parse('http://10.0.2.2:3000/services'));
    print("inside getX2");
    List resbody = jsonDecode(response.body);
    print(resbody);
    return resbody;
  }
FutureBuilder<List>(
              future: fetchservices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: mainColor),
                  );
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 1 / 0.75),
                    itemCount: 6, //snapshot.data!.length
                    itemBuilder: (context, index) {
                      return Container(
                        height: 35,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        width: 15,
                        padding: EdgeInsets.all(12.0),
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
                            Image.asset(
                              snapshot.data?[index]['srv_name'],
                              height: 10,
                              width: 10,
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              snapshot.data?[index]['srv_name'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              })),*/
