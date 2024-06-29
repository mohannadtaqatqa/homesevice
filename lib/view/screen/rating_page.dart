import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  Future<List> getRating() async {
    //Getreview/user/:id
    final prefs = await SharedPreferences.getInstance();
    //print(prefs.getString('userId'));
    final response = await get(Uri.parse(
        'http://10.0.2.2:5000/Getreview/user/${prefs.getString('userId')}'));
    List resBody = jsonDecode(response.body);
    return resBody;
  }

// نريد عرض تقييمات العملاء والوصف بشكل منظم وجميل
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).clientRatings,
          style:
              const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getRating(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(S.of(context).noRating),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) => Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${S.of(context).rating1}:  ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Cairo'),
                                ),
                                Text(
                                  snapshot.data![index]['raiting_value']
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${S.of(context).description}:  ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Cairo'),
                                ),
                                Text(snapshot.data![index]['description'],
                                    style:
                                        const TextStyle(fontFamily: 'Cairo')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
