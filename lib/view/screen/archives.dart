import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeservice/core/function/date_util.dart';
import 'package:homeservice/view/widgit/arrc_crad.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utilti/color.dart';
import '../../generated/l10n.dart';

class Archives extends StatelessWidget {
  const Archives({super.key});

  Future<List<Map<String, dynamic>>> getInfoArchive() async {
    final prefs = await SharedPreferences.getInstance();
    int userId = int.parse(prefs.getString('userId')!);
    final response = await get(
        Uri.parse('http://10.0.2.2:5000/GETArchive/customer/$userId'));
    List resbody = jsonDecode(response.body);
    return resbody.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Archive),
      ),
      body: SafeArea(
          child: FutureBuilder<List<Map<String,dynamic>>>(
        future: getInfoArchive(),
        builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                     ConnectionState.waiting) {
                     return Center(
                      child: CircularProgressIndicator(
                    color: mainColor),
                       );}
                        if(!snapshot.hasData){
                          return Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/img 404.png',
                                  width: 400,
                                  height: 200,
                                ),
                                const SizedBox(height: 20),
                                Text(S.of(context).norequest,
                                    style: Theme.of(context).textTheme.headline6),
                              ],
                            ),
                          );
                        }
          return ListView.builder(
          itemCount: snapshot.data?.length,
    itemBuilder: (context, index) => arc_card(
                    name1: snapshot.data![index]["provider_fname"],
                    name2: snapshot.data![index]["provider_lname"],
                    phone: snapshot.data![index]["provider_phone"],
                    servicename: snapshot.data![index]["servcie_name"],
                    datereq: DateUtil.formatDate(snapshot.data![index]["date"]),
                    descrbtion: snapshot.data![index]["description"],
                    city: snapshot.data![index]["city"],
                    address: snapshot.data![index]["address"],
                    requestid: snapshot.data?[index]["request_id"],)
              );
        },


      )),
    );
  }
}
