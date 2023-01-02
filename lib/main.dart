import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwise_app_rehan_sb/sharedPreferences/user_preferences.dart';
import 'package:passwise_app_rehan_sb/views/add_visitor.dart';
import 'package:passwise_app_rehan_sb/views/send_qr_code.dart';
import 'package:passwise_app_rehan_sb/views/sign_in_up.dart';
import 'package:passwise_app_rehan_sb/views/splash.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blue, // navigation bar color
         statusBarColor: Colors.transparent,
         statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.light,// status bar color
  ));

  await UserPreferences.init();
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
      //home: OurScaffoldTemplate(showFAB: true,bodyWidget: Container(),bottomSheet: Container(),appBarWidget: Container()),
      home: SplashScreen(),
      //home: SendQRCode(),
      //home: AddVisitor(),
      //home: Sign_In_Up(),
    );
  }
}
