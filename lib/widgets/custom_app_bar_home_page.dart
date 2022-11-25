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
        height: 400,
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
                    children: const [
                      Text("PASS "),
                      Text("WISE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/logo/passwise_logo.jpg')),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const TabBar(tabs: [
                  Tab(
                    text: 'Sign up',
                  ),
                  Tab(
                    text: 'Sign in',
                  ),
                ])
              ],
            ),
          ),
        ),
      );
}
