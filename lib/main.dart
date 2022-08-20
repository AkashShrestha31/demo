import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Pages/Authentication/Login/Login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  // await FlutterDownloader.initialize(debug: false);
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://mipmap/launcher_icon',
      [
        NotificationChannel(
          channelKey: 'big_picture',
          channelName: 'Big pictures',
          channelDescription: 'Notifications with big and beautiful images',
          defaultColor: Color(0xFF3ba07e),
          ledColor: Color(0xFF3ba07e),
          importance: NotificationImportance.High,
          vibrationPattern: lowVibrationPattern,
        ),
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          importance: NotificationImportance.High,
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF3ba07e),
          ledColor: Color(0xFF3ba07e),
          // ledColor: Colors.white
        ),
      ]);
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('np', 'NP')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  var notificationdata = json.decode(message.data['notification']);
  var data = json.decode(message.data['data']);
  var box = GetStorage();
  bool checkNotification = box.read('notification');
  bool activitycheckNotification = box.read('activitynotification');
}

Map<int, Color> color = {
  50: Color.fromRGBO(59, 160, 126, .1),
  100: Color.fromRGBO(59, 160, 126, .2),
  200: Color.fromRGBO(59, 160, 126, .3),
  300: Color.fromRGBO(59, 160, 126, .4),
  400: Color.fromRGBO(59, 160, 126, .5),
  500: Color.fromRGBO(59, 160, 126, .6),
  600: Color.fromRGBO(59, 160, 126, .7),
  700: Color.fromRGBO(59, 160, 126, .8),
  800: Color.fromRGBO(59, 160, 126, .9),
  900: Color.fromRGBO(59, 160, 126, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF3ba07e, color);

class MyApp extends StatelessWidget {
//   033B9B
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nepal Driving License',
      theme: ThemeData(
        primarySwatch: colorCustom,
        // fontFamily: 'Poppins',
      ),
      home: MyHomePage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final box = GetStorage();
    box.write('home', false);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Image.asset(
                "assets/AppLogo/ndlb.png",
                scale: SizeConfig.screenHeight * 0.006,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Powered by  ",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: SizeConfig.safeBlockHorizontal * 3,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700)),
                    Image.asset(
                      "assets/AppLogo/growthlab.png",
                      scale: SizeConfig.safeBlockHorizontal * 1.3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
