import 'dart:convert';

import 'package:http/http.dart';

Future<List> fetchservices() async {
  print("inside getX");
  final response = await get(Uri.parse('http://10.0.2.2:5000/service'));
  print("inside getX2");
  List resbody = jsonDecode(response.body);
  print(resbody);
  return resbody;
}