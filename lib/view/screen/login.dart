import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/fcm_config.dart';
import 'package:homeservice/core/function/user_controller.dart';
import 'package:homeservice/core/utilti/Color.dart';
import 'package:homeservice/view/screen/OTP.dart';
import 'package:homeservice/view/screen/buttom_bar.dart';
import 'package:homeservice/view/screen/home.dart';
import 'package:homeservice/view/screen/check_email.dart';
import 'package:homeservice/view/screen/navbar_provider.dart';
import 'package:homeservice/view/screen/singup.dart';
import 'package:homeservice/view/screen/welcome.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
//   print(isloggedIn);
//   if (isloggedIn) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (ctx) => Appointement()));
//   }
//   print(isloggedIn);

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
      Get.to(() => const Home_Page());
    }
  }

  Widget build(BuildContext context) {
    return const Welcome();
  }
}

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  bool obscureText = true;
  IconData eye = Icons.visibility_off;

  Future<void> _login() async {
    final String email = myController.text.trim();
    final String pass = myController1.text.trim();
    // final stroge = FlutterSecureStorage();
    try {
      final response = await post(Uri.parse('http://10.0.2.2:5000/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"email": email, "password": pass}));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        responseData['token'] = JwtDecoder.decode(responseData['token']);
        print(responseData);
        // if (responseData['message'] == "Login successful") {
        final String userType = responseData['token']['userType'].toString();
        final String userEmail = responseData['token']['email'].toString();
        final String userId = responseData['token']['userId'].toString();
        final String firstName = responseData['token']['fname'].toString();
        final String lastName = responseData['token']['lname'].toString();
        final String city = responseData['token']['city'].toString();
        final String address = responseData['token']['address'].toString();
        final String phone = responseData['token']['phone'].toString();
        final String isValid = responseData['token']['isvalid'].toString();
        final prefs = await SharedPreferences.getInstance();
        // ارسال اشعار اذا تمت الموافقة على الطلب
        prefs.setString("userEmail", userEmail);
        prefs.setString("firstName", firstName);
        prefs.setString("lastName", lastName);
        prefs.setString("userId", userId);
        prefs.setString("userType", userType);
        prefs.setString("city", city);
        prefs.setString("address", address);
        prefs.setString("phone", phone);
        // final prefs = await SharedPreferences.getInstance();
        Map<String, String> userData = {
          'userId': prefs.getString('userId')!,
          'userType': prefs.getString('userType')!,
          'firstName': prefs.getString('firstName')!,
          'lastName': prefs.getString('lastName')!,
          'phone': prefs.getString('phone')!,
          'email': prefs.getString('userEmail')!,
          'city': prefs.getString('city')!,
          'address': prefs.getString('address')!,
        };
        UserController userController = Get.put(UserController());
        userController.setData(userData);
        prefs.setString("isLoggedIn", "true");
        fcmconfig();
        if (isValid == "1") {
          if (userType == "0") {
            FirebaseMessaging.instance.subscribeToTopic("ok$userId");
            FirebaseMessaging.instance.subscribeToTopic("reject$userId");
            FirebaseMessaging.instance.subscribeToTopic("suggest$userId");
            FirebaseMessaging.instance.subscribeToTopic("remider$userId");
            FirebaseMessaging.instance.subscribeToTopic("cancel$userId");
            Get.to(() => const Navbar());
          } else if (userType == "1") {
            FirebaseMessaging.instance.subscribeToTopic("booking$userId");
            FirebaseMessaging.instance.subscribeToTopic("rating$userId");
            FirebaseMessaging.instance.subscribeToTopic("remider$userId");
            FirebaseMessaging.instance.subscribeToTopic("cancel$userId");
            prefs.setString(
              "rating",
              responseData['token']['rating'].toString(),
            );
            prefs.setString(
              "count",
              responseData['token']['count'].toString(),
            );
            prefs.setString(
                'status', responseData['token']['status'].toString());
            // if (responseData['token']['status'] == '0' ) {
            // prefs.setBool("status", false);
            // }
            // else {
            //   prefs.setBool("status", true);
            // }
            // prefs.setString("providerId", responseData['token'][''].toString());
            Get.to(() => const Navbar_Provider());
          }
        } else {
          Get.to(() => forgetOTP(
                email: email,
                currentPage: 'LoginPage',
              ));
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String errorMessage = responseData['error'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
      }
    } catch (e) {
      print(e);
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
            style: TextStyle(
                color: !Get.isDarkMode
                    ? Colors.black
                    : Color.fromARGB(230, 255, 255, 255),
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
          style: TextStyle(
              fontSize: 13,
              color: !Get.isDarkMode ? Colors.black : Colors.white,
              fontFamily: 'Cairo'),
        ),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
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
                  color: !Get.isDarkMode ? mainColor : Colors.white,
                )),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          "   ${S.of(context).password}",
          style: TextStyle(
              fontSize: 13,
              color: !Get.isDarkMode ? Colors.black : Colors.white,
              fontFamily: 'Cairo'),
        ),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
              obscureText: obscureText,
              controller: myController1,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  // icon: Icon(Icons.lock, color: Colors.blue[900],), //icon at head of input
                  // prefixIcon: Icon(Icons.people), //you can use prefixIcon property too.

                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        if (eye == Icons.visibility) {
                          obscureText = true;
                          eye = Icons.visibility_off;
                        } else {
                          obscureText = false;
                          eye = Icons.visibility;
                        }
                      });
                    },
                    child: Icon(
                      eye,
                      //color: Colors.blue[900],
                      color: !Get.isDarkMode
                          ? mainColor
                          : Color.fromARGB(230, 255, 255, 255),
                    ),
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
