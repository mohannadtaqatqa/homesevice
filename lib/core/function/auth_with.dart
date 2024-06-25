import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homeservice/core/controller.dart';
import 'package:homeservice/core/function/user_controller.dart';
import 'package:homeservice/view/screen/info_addtion.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/screen/buttom_bar.dart';
import '../../view/screen/navbar_provider.dart';

class Authviewmodel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // void googleSignInMethod_() async {
  //   final GoogleSignInAccount? account = await _googleSignIn.signIn();
  //   print(account);
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //       await account!.authentication;
  //   if (googleSignInAuthentication.accessToken != null ||
  //       googleSignInAuthentication.idToken != null) {
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     print(" flutter   zzz${credential.accessToken}");

  //     await _auth.signInWithCredential(credential);
  //   }
  // }

  googleSignInMethod() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return;
      } else {
        GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        String? email = userCredential.user!.email;
        String? displayName = userCredential.user!.displayName;
        // /logingoogle
        final respo = await post(Uri.parse("http://10.0.2.2:5000/logingoogle"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "email": email,
            }));
        print(respo.statusCode);
        if (respo.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(respo.body);
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
          // Get.to()

          UserController userController = Get.put(UserController());
          userController.setData(userData);
          print(isValid);
          if (isValid == "1") {
            if (userType == "0") {
              print("ok");
              FirebaseMessaging.instance.subscribeToTopic("ok$userId");
              FirebaseMessaging.instance.subscribeToTopic("reject$userId");
              FirebaseMessaging.instance.subscribeToTopic("suggest$userId");
              FirebaseMessaging.instance.subscribeToTopic("cancel$userId");
              print("ok get to navbar");
              Get.off(() => const Navbar());
            } else if (userType == "1") {
              print(responseData['token']['status']);
              prefs.setString("status", responseData['token']['status'].toString());
              FirebaseMessaging.instance.subscribeToTopic("booking$userId");
              FirebaseMessaging.instance.subscribeToTopic("rating$userId");
              FirebaseMessaging.instance.subscribeToTopic("remider$userId");
              FirebaseMessaging.instance.subscribeToTopic("cancel$userId");
              prefs.setString("rating",responseData['token']['rating'].toString(),);
              prefs.setString("count",responseData['token']['count'].toString(),);
              // prefs.setString("providerId", responseData['token'][''].toString());
              print("provider get to navbar");
              Get.off(() => const Navbar_Provider());
            }
          }
        } else {
          emailCotrlr.text = email!;
          fullNameCotrlr.text = displayName!;
          String fullName = userCredential.user!.displayName!;
          List<String> names = fullName.split(" ");
          firstnameCotrlr.text = names[0];
          secondnameCntrlr.text = names.length > 1 ? names.sublist(1).join(" ") : "";
          Get.to(() => const InfoAddition());
        }

        return userCredential;
      }
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }

  FacebookLogin _faceebookLogin = FacebookLogin();

   facebookLogin() async {
    print("object");
    FacebookLoginResult result =
        await _faceebookLogin.logIn(customPermissions: ['email']);
    final String accessToken = result.accessToken!.token;

    print(accessToken);
    if (result.status == FacebookLoginStatus.success) {
      final faceCedential = FacebookAuthProvider.credential(accessToken);
      await _auth.signInWithCredential(faceCedential);
    }
  }
   Future<UserCredential> facebook_Login() async {
    // Trigger the sign-in flow
     FacebookLoginResult loginResult = await _faceebookLogin.logIn();
    print (loginResult.status);
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    print(facebookAuthCredential.idToken); //Here getting null

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  //  Future<void> facebookSignIn() async {
  //   try {
  //     final result = await _facebookLogin.logIn(permissions: [
  //       FacebookPermission.publicProfile,
  //       FacebookPermission.email,
  //     ]);

  //     switch (result.status) {
  //       case FacebookLoginStatus.success:
  //         final AccessToken accessToken = result.accessToken!;

  //         final AuthCredential credential =
  //             FacebookAuthProvider.credential(accessToken.token);

  //         // اسجل الدخول باستخدام اعتمادات Facebook إلى Firebase
  //         final UserCredential userCredential =
  //             await FirebaseAuth.instance.signInWithCredential(credential);

  //         // استرداد بيانات المستخدم
  //         final user = userCredential.user;

  //         // يمكنك استخدام بيانات المستخدم هنا لتحديث حالة التطبيق أو تخزينها بشكل مؤقت
  //         print('Logged in as: ${user!.displayName}');

  //         break;

  //       case FacebookLoginStatus.cancel:
  //         // حالة إلغاء تسجيل الدخول
  //         print('Facebook login canceled');
  //         break;

  //       case FacebookLoginStatus.error:
  //         // حالة حدوث خطأ
  //         print('Error while logging in: ${result.error}');
  //         break;
  //     }
  //   } catch (error) {
  //     print('Error while logging in: $error');
  //   }
  // }
}
