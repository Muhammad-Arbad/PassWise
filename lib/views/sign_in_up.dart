import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/views/sign_in.dart';
import 'package:passwise_app_rehan_sb/views/sign_up.dart';
import 'package:passwise_app_rehan_sb/widgets/our_scaffold.dart';

class Sign_In_Up extends StatefulWidget {
  const Sign_In_Up({Key? key}) : super(key: key);

  @override
  State<Sign_In_Up> createState() => _Sign_In_UpState();
}

class _Sign_In_UpState extends State<Sign_In_Up> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: OurScaffoldTemplate(
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
                // child: Padding(
                //   padding: const EdgeInsets.all(0.0),
                //   child:  Image.asset('assets/logo/passwisewhitelogo.png',fit: BoxFit.cover),
                // ),
              ),
              // Flexible(
              //   child: Container(
              //     height: 85,
              //     width: 85,
              //     decoration: BoxDecoration(
              //       image: const DecorationImage(
              //           image: AssetImage('assets/logo/passwise_logo.jpg'),fit: BoxFit.contain),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),
               Flexible(
                 child: TabBar(
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
            child: TabBarView(children: [
              SignUp(),
              SignIn(),
            ]),
          ),
          showFAB: false,
        ),
      );
}