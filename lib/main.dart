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
import 'package:homeservice/view/widgit/Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final String lang = prefs.getString("lang") ?? 'en';
    return MyApp(lang: lang);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: ThemeData(
      //   fontFamily: 'Cairo',
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // themeMode: ThemeMode.light,
      // home: Directionality(
      //   textDirection: TextDirection.ltr,
      //   child: const SpalshScreen(),
      // ),

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
        GetPage(name: "/home", page: () => const Home_Page()),
        GetPage(name: "/HomePageProvider", page: () => const HomePageProvider()),
        GetPage(name: "/service", page: () => const Service()),
        // GetPage(name: "/mysetting", page:()=> const Mysetting())
        
      ],
    );
  }
}

class them{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 241, 8, 8),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    // fontFamily: 'Cairo',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      button: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}