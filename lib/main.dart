import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwise_app_rehan_sb/views/splash.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blue, // navigation bar color
         statusBarColor: Colors.transparent,
         statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.light,// status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: VisitorList(),
      //home: HomePage(),
      home: SplashScreen(),
    );
  }
}
