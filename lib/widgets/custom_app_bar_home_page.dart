import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';

class CustomAppBarHomePage extends StatefulWidget implements PreferredSizeWidget {
  double heightOfAppBar;
  CustomAppBarHomePage({Key? key, required this.heightOfAppBar}) : super(key: key);

  @override
  State<CustomAppBarHomePage> createState() => _CustomAppBarHomePageState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(heightOfAppBar);
}

class _CustomAppBarHomePageState extends State<CustomAppBarHomePage> {
  @override
  Widget build(BuildContext context) => Container(
        color: CustomColors().customWhiteColor,
        height: widget.heightOfAppBar,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Container(
            decoration: BoxDecoration(
                color: CustomColors().customGreenColor,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(30))),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("PASS "),
                      Text("WISE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/logo/passwise_logo.jpg')),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const TabBar(
                    //indicatorColor: Colors.white,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0,color: Colors.white),
                        insets: EdgeInsets.symmetric(horizontal:80.0)
                    ),
                    tabs: [
                  Tab(
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                  ),),
                ])
              ],
            ),
          ),
        ),
      );
}
