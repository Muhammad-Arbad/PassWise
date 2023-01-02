import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/views/sign_in.dart';
import 'package:passwise_app_rehan_sb/views/sign_up.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';

class Sign_In_Up extends StatefulWidget {
  const Sign_In_Up({Key? key}) : super(key: key);

  @override
  State<Sign_In_Up> createState() => _Sign_In_UpState();
}

class _Sign_In_UpState extends State<Sign_In_Up> with SingleTickerProviderStateMixin{

  late TabController tabBarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.animateTo(1);
  }

  @override
  void dispose() {
    tabBarController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => OurScaffoldTemplate(
          appBarWidget: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("PASS "),
                    Text(
                      "WISE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Flexible(
                child:  Image.asset('assets/logo/passwisewhitelogo.png'),
              ),
               Flexible(
                 child: TabBar(
                   controller: tabBarController,
                    //indicatorColor: Colors.white,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0, color: Colors.white),
                        insets: EdgeInsets.symmetric(horizontal: 80.0)),
                    tabs: [
                      Tab(
                        child:
                        // FittedBox(
                        //   fit: BoxFit.scaleDown,
                        //   child:
                        //   Text(
                        //     "Sign up",
                        //     style: TextStyle(fontSize: 20),
                        //   ),)
                        Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child:
                        // FittedBox(
                        //   fit: BoxFit.scaleDown,
                        //   child:
                        //   Text(
                        //     "Sign in",
                        //     style: TextStyle(fontSize:20),
                        //   ),)
                        Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
               )
            ],
          ),
          bodyWidget: Center(
            child: TabBarView(
                controller: tabBarController,
                children: [
              SignUp(),
              SignIn(),
            ]),
          ),
          showFAB: false,
      );
}