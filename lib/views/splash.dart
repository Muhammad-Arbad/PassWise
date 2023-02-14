import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/sharedPreferences/user_preferences.dart';
import 'package:passwise_app_rehan_sb/views/no_internet.dart';
import 'package:passwise_app_rehan_sb/views/sign_in_up.dart';
import 'package:passwise_app_rehan_sb/views/visitor_list.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToHomeScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().customGreenColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(""),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/logo/passwise_logo.jpg')),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Text("www.passwise.app",style: TextStyle(color: Colors.white),)
            ],
          ),
        )
        ),
      );
  }

  void goToHomeScreen() async{


    bool result = await InternetConnectionChecker().hasConnection;

    await Future.delayed(Duration(milliseconds: 2000));


    if(UserPreferences.getUserToken()== null ||
        UserPreferences.getUserToken()== "null" ||
        DateTime.now().isAfter(DateTime.parse((UserPreferences.getExpiryTime())??DateTime.now().toString())))
    {
      if(result){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sign_In_Up()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoInternetConnection()));
      }
      // print("UserPreferences.getUserToken()"+UserPreferences.getUserToken().toString());

    }
    else{

      if(result){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VisitorList()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoInternetConnection()));
      }


    }
    
  }
}

