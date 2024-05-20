import 'package:flutter/material.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class HomePageProvider extends StatefulWidget {
  const HomePageProvider({super.key});

  @override
  State<HomePageProvider> createState() => _HomePageProviderState();
}

class _HomePageProviderState extends State<HomePageProvider> {
    bool switchValue = false;
  Future<void> _active(int? id) async {
    await post(Uri.parse('http://10.0.2.2:5000/updateStatusById/true/$id'));
  }

  Future<void> _dactive(int? id) async {
    await post(Uri.parse('http://10.0.2.2:5000/updateStatusById/$id'));
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    String rating = prefs.getString("rating")!;
    //  String countRequest = prefs.getString("countRequest")!;
    String userName = prefs.getString("firstName")!;
    String lastName = prefs.getString("lastName")!;
    String userID = prefs.getString('userId')!;
    String count = prefs.getString("count")!;

    return {
      "rating": rating,
      // "countRequest": countRequest,
      "firstName": userName,
      "lastName": lastName,
      "userID": userID,
      "count": count
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: mainColor),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No data available'),
                  );
                } else if (snapshot.hasData) {
                  Map<String, String?> data =
                      snapshot.data as Map<String, String?>;
                  // data.toString();
                  return Container(
                    color: Colors.grey[200],
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Stack(children: [
                              Positioned(
                                  child: Container(
                                height: 150,
                                color: mainColor,
                              )),
                              Positioned(
                                left: 20,
                                right: 20,
                                top: 50,
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 240,
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${data['firstName'] ?? ""} ${data['lastName'] ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              fontFamily: 'Cairo'),
                                        ),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "مستعد للموافقة على عمل",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                      fontFamily: 'Cairo'),
                                                ),
                                                Text(
                                                  "انت سوف تتلقى اشعارات عمل جديد",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 16,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Switch(
                                              value: switchValue,
                                              activeColor: Colors.amber[400],
                                              thumbColor:
                                                  MaterialStateProperty.all(
                                                      whiteColor),
                                              onChanged: (value) async {
                                                setState(() {
                                                  switchValue = value;

                                                  print(value);
                                                });

                                                // Make API call based on the new value of the switch
                                                if (value) {
                                                  print("active");
                                                  try {
                                                    await _active(int.parse(
                                                        data['userID']!));
                                                  } catch (e) {
                                                    // Revert switch value to false if there's an error
                                                    setState(() {
                                                      switchValue = false;
                                                    });
                                                    // Optionally, you can show an error message to the user
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Failed to activate'),
                                                    ));
                                                  }
                                                } else {
                                                  print("dactive");
                                                  try {
                                                    await _dactive(int.parse(
                                                        data['userID']!));
                                                  } catch (e) {
                                                    // Revert switch value to true if there's an error
                                                    setState(() {
                                                      switchValue = true;
                                                    });
                                                    // Optionally, you can show an error message to the user
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Failed to deactivate'),
                                                    ));
                                                  }
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 50,
                                  left: 50,
                                  child: CircleAvatar(
                                    radius: 55,
                                    child: Icon(
                                      Icons.person,
                                      size: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  )),
                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: mainColor,
                                      size: 60,
                                    ),
                                    const Text(
                                      "5",
                                      style: TextStyle(fontFamily: 'Cairo'),
                                    ),
                                    Text(
                                      "طلب اعادة عمل",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontFamily: 'Cairo'),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.work,
                                      color: mainColor,
                                      size: 60,
                                    ),
                                    Text(
                                      "${data['count']}",
                                      style: TextStyle(fontFamily: 'Cairo'),
                                    ),
                                    Text(
                                      S.of(context).newjob,
                                      style: TextStyle(
                                          color: greyColor,
                                          fontFamily: "Cairo"),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 70,
                            width: 250,
                            color: whiteColor,
                            child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.star_half,
                                    textDirection: TextDirection.ltr,
                                    size: 50,
                                    color: mainColor,
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text("${data['rating'] ?? ""}",
                                            style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "Cairo")),
                                        Text(S.of(context).rating,
                                            style: TextStyle(
                                                color: greyColor,
                                                fontFamily: "Cairo"))
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 70,
                            width: 250,
                            color: whiteColor,
                            child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.thumb_up,
                                    textDirection: TextDirection.ltr,
                                    size: 45,
                                    color: mainColor,
                                  ),
                                  const SizedBox(
                                    width: 23,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text("0",
                                            style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "Cairo")),
                                        Text(S.of(context).requestdone,
                                            style: TextStyle(
                                                color: greyColor,
                                                fontFamily: "Cairo"))
                                      ],
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              })),
    );
  }
}
