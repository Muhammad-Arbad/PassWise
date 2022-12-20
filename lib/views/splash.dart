import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/views/sign_in_up.dart';

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
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sign_In_Up()));
  }
}


