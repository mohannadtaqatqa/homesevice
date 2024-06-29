import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package for Get.isDarkMode
import 'package:homeservice/core/function/snakbar.dart';
import 'package:homeservice/core/utilti/color.dart';
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
  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        switchValue = data['status'] == '1' ? true : false;
      });
    });
  }

  Future<void> _active(int? id) async {
    await post(Uri.parse('http://10.0.2.2:5000/updateStatusById/true/$id'));
  }

  Future<void> _dactive(int? id) async {
    await post(Uri.parse('http://10.0.2.2:5000/updateStatusById/$id'));
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    String rating = prefs.getString("rating")!;
    String userName = prefs.getString("firstName")!;
    String lastName = prefs.getString("lastName")!;
    String userID = prefs.getString('userId')!;
    String count = prefs.getString("count")!;
    String status = prefs.getString('status')!;
    return {
      "rating": rating,
      "firstName": userName,
      "lastName": lastName,
      "userID": userID,
      "count": count,
      "status": status
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.isDarkMode;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.grey[200]!;
    final Color cardColor = isDarkMode ? Colors.grey[800]! : whiteColor;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor = isDarkMode ? Colors.grey[400]! : greyColor;
    final Color iconColor = isDarkMode ? Colors.amber[400]! : mainColor;

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
              return const Center(
                child: Text('No data available'),
              );
            } else if (snapshot.hasData) {
              Map<String, String?> data = snapshot.data as Map<String, String?>;
              return Container(
                height: double.infinity,
                color: backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: 150,
                                color: mainColor,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              right: 20,
                              top: 50,
                              child: Container(
                                alignment: Alignment.center,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${data['firstName'] ?? ""} ${data['lastName'] ?? ""}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        fontFamily: 'Cairo',
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).areyoureday,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                fontFamily: 'Cairo',
                                                color: textColor,
                                              ),
                                            ),
                                            Text(
                                              S.of(context).newnoti,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 16,
                                                fontFamily: 'Cairo',
                                                color: secondaryTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Switch(
                                          value: switchValue,
                                          activeColor: iconColor,
                                          thumbColor: MaterialStateProperty.all(
                                              whiteColor),
                                          onChanged: (value) async {
                                            setState(() {
                                              switchValue = value;
                                            });

                                            if (value) {
                                              try {
                                                await _active(
                                                    int.parse(data['userID']!));
                                              } catch (e) {
                                                Snackbar(
                                                    message:
                                                        'Failed to activate',
                                                    context: context,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white);
                                              }
                                            } else {
                                              try {
                                                await _dactive(
                                                    int.parse(data['userID']!));
                                              } catch (e) {
                                                // setState(() {
                                                //   switchValue = true;
                                                // });
                                                Snackbar(
                                                    message:
                                                        'Failed to deactivate',
                                                    context: context,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white);
                                              }
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 50,
                              left: 50,
                              child: CircleAvatar(
                                radius: 55,
                                child: Image.asset(
                                  "images/main-Image.png",
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              color: cardColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.refresh,
                                  color: iconColor,
                                  size: 60,
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                      fontFamily: 'Cairo', color: textColor),
                                ),
                                Text(
                                  S.of(context).reprovid,
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.work,
                                  color: iconColor,
                                  size: 60,
                                ),
                                Text(
                                  "${data['count']}",
                                  style: TextStyle(
                                      fontFamily: 'Cairo', color: textColor),
                                ),
                                Text(
                                  S.of(context).newjob,
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 250,
                        color: cardColor,
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
                              color: iconColor,
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
                                  Text(
                                    data['rating'] ?? "",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                  Text(
                                    S.of(context).rating,
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 250,
                        color: cardColor,
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
                              color: iconColor,
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
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                  Text(
                                    S.of(context).requestdone,
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
