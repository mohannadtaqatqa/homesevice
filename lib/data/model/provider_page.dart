import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/data/model/details_provider.dart';
import 'package:homeservice/view/screen/details_d.dart';
import 'package:http/http.dart';
import '../../generated/l10n.dart';

class provider_list extends StatefulWidget {
  const provider_list({Key? key, this.serviceID});
  final serviceID;
  @override
  State<provider_list> createState() => _provider_listState();
}

Future<List<dynamic>> fetchservices() async {
  final response = await get(Uri.parse(
      'http://10.0.2.2:5000/serviceprovider/details/${Get.arguments}'));
  //print("inside getX2");
  //print(response.body);
  List resbody = jsonDecode(response.body);
  return resbody;
}

class _provider_listState extends State<provider_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).serviceProvider),
        // backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: fetchservices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: mainColor),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
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
                                    '${snapshot.data![index]['provider_fname']} ${snapshot.data![index]['provider_lname']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(snapshot.data![index]['provider_phone'],
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
                                  Get.to(
                                      () => ProviderDetails(
                                          serviceID: widget.serviceID),
                                      arguments:
                                          //  List
                                          detailsp(
                                        id: snapshot.data![index]
                                            ['provider_id'],
                                        fname: snapshot.data![index]
                                            ['provider_fname'],
                                        lname: snapshot.data![index]
                                            ['provider_lname'],
                                        city: snapshot.data![index]['city'],
                                        location: snapshot.data![index]
                                            ['address'],
                                        phone: snapshot.data![index]
                                            ['provider_phone'],
                                        servicen: snapshot.data![index]
                                            ['servcie_name'],
                                        rating: snapshot.data![index]['rating'],
                                      ));
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 30, color: Colors.white))
                          ])));
            }
            return Center(
              child: Text(S.of(context).noProvider,style: TextStyle(color: !Get.isDarkMode? Colors.black:const Color.fromARGB(230, 255, 255, 255),fontSize: 20,fontFamily: 'Cairo'),),
            );
          }),
    );
  }
}
