import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/fcm_config.dart';
import 'package:homeservice/core/function/snakbar.dart';
import 'package:homeservice/core/utilti/color.dart';
import 'package:homeservice/view/screen/home.dart';
import 'package:homeservice/view/screen/check_email.dart';
import 'package:homeservice/view/screen/navbar_provider.dart';
import 'package:homeservice/view/screen/singup.dart';
import 'package:homeservice/view/screen/welcome.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/l10n.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// class LoggedIn extends StatefulWidget {
//   const LoggedIn({super.key});

//   @override
//   State<LoggedIn> createState() => _LoggedInState();
// }

// class _LoggedInState extends State<LoggedIn> {
//   @override
// void initState() {
//   // TODO: implement initState
//   check();
//   super.initState();
// }

// Future<void> check() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   bool isloggedIn = pref.getBool("LoggedIn") ?? false;
//   //print(isloggedIn);
//   if (isloggedIn) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (ctx) => Appointement()));
//   }
//   //print(isloggedIn);

// }
class LoggedIn extends StatefulWidget {
  const LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  @override
  void initState() {
    super.initState();
    // Check for stored login status (optional)
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    const storage = FlutterSecureStorage();
    final isLoggedIn = await storage.read(key: 'isLoggedIn') == 'true';
    if (isLoggedIn) {
      // Navigate to Home screen or perform actions based on logged-in user
      Get.to(() => const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Welcome();
  }
}

class login_provider extends StatefulWidget {
  const login_provider({super.key});

  @override
  State<login_provider> createState() => _loginState();
}

class _loginState extends State<login_provider> {
  final myController = TextEditingController();
  final myController1 = TextEditingController();

  Future<void> _login() async {
    fcmconfig();
    requestPermissionNotification();
    final String email = myController.text.trim();
    final String pass = myController1.text.trim();
    // final stroge = FlutterSecureStorage();
    try {
      final response = await post(
        Uri.parse('http://10.0.2.2:5000/login_Provider'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email, "password": pass}),
      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String userEmail = responseData['provider']['email'].toString();
        final String userId = responseData['provider']['id'].toString();
        final String userName = responseData['provider']['fname'].toString();
        final String userLname = responseData['provider']['lname'].toString();
        final String countRequest =
            responseData['provider']['countRequest'].toString();
        final String rating = responseData['provider']['rating'].toString();
        final prefs = await SharedPreferences.getInstance();
        //print("provider id => ${userId}");
        //  await stroge.write(key: "userEmail", value: userEmail);
        //  await stroge.write(key: 'isLoggedIn', value: 'true');
        //  await stroge.write(key: "userName", value: userName);
        //await stroge.write(key: "userID", value: userId);
        prefs.setString("userEmail", userEmail);
        prefs.setString("userName", userName);
        prefs.setString("lastName", userLname);
        prefs.setString("userId", userId);
        prefs.setString("countRequest", countRequest);
        prefs.setString("rating", rating);
    FirebaseMessaging.instance.subscribeToTopic("booking$userId");

        Get.to(() => const Navbar_Provider());
      } else {
        // Login failed, show error message
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String errorMessage = responseData['error'];
        Snackbar( message: errorMessage, context: context, backgroundColor: Colors.red , textColor: Colors.white) ;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //     errorMessage,
        //     style: const TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: Colors.red,
        // ));
      }
    } catch (e) {
      // Snackbar ( message: , context: context, backgroundColor: Colors.red , textColor: Colors.white) ;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
          child: Text(
            "كلمة المرور او الايميل خطأ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.red,
      ));

      // Handle error
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(children: [
        Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: const Image(
              image: AssetImage('images/loginimg.jpg'),
              //image: AssetImage('images\lo'),
              height: 200.0,
            ),
          ),
        ),
        Center(
          child: Text(
            S.of(context).login,
            style: const TextStyle(
                //color: Colors.blue[900],
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                letterSpacing: 0),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "   ${S.of(context).Email}",
          style: const TextStyle(
              fontSize: 13, color: Colors.black, fontFamily: 'Cairo'),
        ),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            textAlign: TextAlign.left,
            controller: myController,
            decoration: InputDecoration(
                //  border: OutlineInputBorder(),
                // hintText: 'coustmer@gmail.com',
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
                // label: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 15),
                //     child: Text(S.of(context).username)),
                suffixIcon: Icon(
                  Icons.account_box,
                  //  color: Colors.blue[900],
                  color: mainColor,
                )),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          "   ${S.of(context).password}",
          style: const TextStyle(
              fontSize: 13, color: Colors.black, fontFamily: 'Cairo'),
        ),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
              obscureText: true,
              controller: myController1,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  // icon: Icon(Icons.lock, color: Colors.blue[900],), //icon at head of input
                  // prefixIcon: Icon(Icons.people), //you can use prefixIcon property too.

                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    //color: Colors.blue[900],
                    color: mainColor,
                  ) //icon at tail of input
                  )),
        ),
        const SizedBox(
          height: 15.0,
        ),
        InkWell(
          onTap: () {
            Get.to(() => const InputPhone());
          },
          child: Text(
            S.of(context).Forgotyourpassword,
            style: TextStyle(color: mainColor, fontFamily: 'Cairo'),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
                // backgroundColor: Colors.blue[900],
                backgroundColor: mainColor,
                fixedSize: const Size(359.0, 58.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0))),
            onPressed: _login
            //  () async {
            //   // final SharedPreferences pref =
            //   //     await SharedPreferences.getInstance();
            //   // await pref.setBool("LoggedIn", true);

            //   (Get.to(() => const Home_Page()));
            // }
            ,
            child: Text(
              S.of(context).login,
              style: TextStyle(
                  color: whiteColor, fontSize: 20.0, fontFamily: 'Cairo'),
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        // DividerOR(),
        // SizedBox(height: 5.0),
        // Flexible(
        //     child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Authpage(
        //       iconData: FontAwesomeIcons.apple,
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Authpage(
        //       iconData: FontAwesomeIcons.f,
        //       color: Colors.blue[900],
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     const Authpage(
        //       iconData: FontAwesomeIcons.google,
        //       color: Colors.red,
        //     ),
        //   ],
        // )),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).Donthaveanaccount,
              style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
            ),
            InkWell(
                onTap: () {
                  Get.to(() => const Register());
                },
                child: Text(
                  S.of(context).SingUp,
                  style: TextStyle(
                      fontSize: 16, color: mainColor, fontFamily: 'Cairo'),
                ))
          ],
        )
      ]),
    ));
  }
}

class FieldPassword extends StatelessWidget {
  const FieldPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
              // icon: Icon(Icons.lock, color: Colors.blue[900],), //icon at head of input
              // prefixIcon: Icon(Icons.people), //you can use prefixIcon property too.

              suffixIcon: Icon(
                Icons.remove_red_eye,
                //color: Colors.blue[900],
                color: mainColor,
              ) //icon at tail of input
              )),
    );
  }
}

class FieldUsername extends StatelessWidget {
  const FieldUsername({
    super.key,
    required this.myController,
  });

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        textAlign: TextAlign.left,
        controller: myController,
        decoration: InputDecoration(
            //  border: OutlineInputBorder(),
            // hintText: 'coustmer@gmail.com',
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
            // label: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 15),
            //     child: Text(S.of(context).username)),
            suffixIcon: Icon(
              Icons.account_box,
              //  color: Colors.blue[900],
              color: mainColor,
            )),
      ),
    );
  }
}
