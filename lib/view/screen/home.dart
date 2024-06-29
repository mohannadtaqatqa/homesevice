import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/user_controller.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/data/model/provider_page.dart';
import 'package:homeservice/view/screen/appint_user.dart';
import 'package:homeservice/view/widgit/ADV.dart';
import 'package:http/http.dart';
import '../../generated/l10n.dart';
import '../widgit/show_more.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserController userController = Get.put(UserController());
  
  Future<List> fetchservices() async {
    final response = await get(Uri.parse('http://10.0.2.2:5000/service'));
    List resbody = jsonDecode(response.body);
    return resbody;
  }

  Future<List<dynamic>> fetchAppointmentsToday() async {
    final response = await get(Uri.parse(
        'http://10.0.2.2:5000/getAppointmentsForToday/${userController.id}'));
    var resbody = jsonDecode(response.body);
    List<dynamic> appointments = resbody['appointments'];
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "  ${S.of(context).welcome} ${userController.userFirstName} 💁‍♂️",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Advertisements(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  ${S.of(context).Services}",
                    style: const TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  InkWell(
                    onTap: () => Get.to(() => const All_service()),
                    child:  Text(
                      S.of(context).showmore,
                      style:const TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 16,
                        color: Colors.amberAccent,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              FutureBuilder<List>(
                future: fetchservices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: mainColor),
                    );
                  }
                  return GridView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 0.75,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      List<dynamic> bufferDynamic =
                          snapshot.data![index]["service_icon"]["data"] is List
                              ? snapshot.data![index]["service_icon"]["data"]
                              : snapshot.data![index]["service_icon"]["data"] is String
                                  ? jsonDecode(snapshot.data![index]["service_icon"]["data"])
                                  : [
                                      snapshot.data![index]["service_icon"]["data"]
                                    ];
                      List<int> bufferInt =
                          bufferDynamic.map((e) => e as int).toList();
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => provider_list(
                              serviceID: snapshot.data![index]['servcie_id'],
                            ),
                            arguments: snapshot.data![index]['servcie_id'],
                          );
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          width: 25,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Get.isDarkMode
                                    ? const Color.fromARGB(255, 76, 76, 76)
                                    : const Color.fromARGB(0, 238, 238, 238),
                                Get.isDarkMode
                                    ?const Color.fromARGB(255, 155, 149, 149)
                                    :const Color.fromARGB(0, 238, 238, 238),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:  [
                              BoxShadow(
                                color: Get.isDarkMode ? Colors.black : const Color.fromARGB(255, 177, 168, 168),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:const Offset(0, 5),
                              ),
                              BoxShadow(
                                color: Get.isDarkMode ? Colors.grey.withOpacity(0.5) : const Color.fromARGB(255, 254, 253, 253),
                                offset: const Offset(-5, 0),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Image.memory(
                                Uint8List.fromList(bufferInt),
                                height: 38,
                                width: 80,
                              ),
                            const  SizedBox(height: 10, width: 50),
                              Text(
                                snapshot.data?[index]['servcie_name'],
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              FutureBuilder<List<dynamic>>(
                future: fetchAppointmentsToday(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    List<dynamic> appointments = snapshot.data ?? [];
                    return Column(
                      children: appointments.map((appointment) {
                        return Column(
                          children: [
                             Row(
                              children: [
                                Text("\t\t\t\t\t\t\t${S.of(context).appointoday}",style:const TextStyle(fontFamily: 'Cairo',fontSize: 14,),)
                              ],
                            ),
                            InkWell(
                              onTap: () => Get.to(() => const AppointmentPage()),
                              child: Container(
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
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text(
                                    '${appointment['provider_fname']} ${appointment['provider_lname']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  subtitle: Text(
                                    appointment['servcie_name'],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.alarm,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}




/*
Future<List> fetchservices() async {
    //print("inside getX");

    final response = await get(Uri.parse('http://10.0.2.2:3000/services'));
    //print("inside getX2");
    List resbody = jsonDecode(response.body);
    //print(resbody);
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
