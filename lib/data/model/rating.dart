import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../generated/l10n.dart';

 

rating(BuildContext context,String customerId,String providerId) {
  showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => 
      RatingDialog(
    initialRating: 1.0,
    // your app's name?
    title: Text(
      S.current.compulationRating,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: Text(
      S.current.TapRating,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ),
    // your app's logo?
    image: Image.asset("images/review.png", width: 100, height: 100),
    submitButtonText: S.current.SubmitRating,
    commentHint: 'Set your custom comment hint',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) async {
      final responce =
          await post(Uri.parse('http://10.0.2.2:5000/raiting'), headers: {
        'Content-Type': 'application/json',
      },
          body: jsonEncode(<String, String>{
            "reviewer_id":providerId,
            "description": response.comment,
            "user_id": customerId,
            "raiting_value": response.rating.toString(),
          }));

      try {
        print(responce.statusCode);
      } catch (e) {
        print(e);
      }
      print('rating: ${response.rating}, comment: ${response.comment}');
    })
    );
}