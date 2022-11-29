import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/views/sign_in.dart';
import 'package:passwise_app_rehan_sb/views/sign_up.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_app_bar_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFFE9EDF0),
          appBar: CustomAppBarHomePage(
            heightOfAppBar: 200,
            //heightOfAppBar: MediaQuery.of(context).size.height / 4,
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            color: CustomColors().customGreenColor,
            child: Container(
                decoration: BoxDecoration(
                    color: CustomColors().customWhiteColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30))),
                child: Center(
                  child: TabBarView(
                    children: [
                      SignUp(),
                      SignIn(),
                    ]
                  ),

                )),
          ),
        ),
      );


}
