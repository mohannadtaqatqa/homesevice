import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:homeservice/core/function/fcm_config.dart';
import 'package:homeservice/firebase_options.dart';
import 'package:homeservice/generated/l10n.dart';
import 'package:homeservice/view/screen/archives.dart';
import 'package:homeservice/view/screen/home.dart';
import 'package:homeservice/view/screen/home_page_provider.dart';
import 'package:homeservice/view/screen/login.dart';
import 'package:homeservice/view/screen/onnordingscreen.dart';
import 'package:homeservice/view/screen/reservation_provider.dart';
import 'package:homeservice/view/screen/settings_app.dart';
import 'package:homeservice/view/screen/welcome.dart';
import 'package:homeservice/view/widgit/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/binding.dart';
import 'view/screen/Spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      fcmconfig();
    // requestPermissionNotification();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(await MyApp.create());
}

class MyApp extends StatelessWidget {
  const MyApp({this.lang = 'en', super.key});

  final String lang;

  static Future<MyApp> create() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lang = prefs.getString("lang") ?? 'ar';
    return MyApp(lang: lang);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // fontfamily:'Cairo'
      theme: ThemeData(fontFamily: 'Cairo'),
      initialBinding: Binding(),
      locale: Locale(lang),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar'), Locale('en')],
      localeResolutionCallback: (deviceLang, supportLang) {
        for (Locale locale in supportLang) {
          if (deviceLang != null &&
              deviceLang.languageCode == locale.languageCode) {
            return deviceLang;
          }
        }
        return supportLang.first;
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const SpalshScreen(),
        ),
        GetPage(name: "/login", page: () => const login()),
        GetPage(name: '/onBording', page: () => const onBording()),
        GetPage(name: '/welcome', page: () => const Welcome()),
        GetPage(name: '/Archives', page: () => const Archives()),
        GetPage(name: '/account', page: () => const Account()),
        GetPage(name: "/reservation", page: () => const reservation_provider()),
        GetPage(name: "/home", page: () => const HomePage()),
        GetPage(name: "/HomePageProvider", page: () => const HomePageProvider()),
        GetPage(name: "/service", page: () => const Service()),
        // GetPage(name: "/mysetting", page:()=> const Mysetting())
        
      ],
    );
  }
}
