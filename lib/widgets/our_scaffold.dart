import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/widgets/bustom_bottom_sheet.dart';

class OurScaffoldTemplate extends StatelessWidget {

  Widget? bottomSheet, floationgActionButton, appBarWidget;
  Widget bodyWidget;
  void Function()? fabOnPress;
  bool showFAB = true,resizeToAvoidBottomInset;

  OurScaffoldTemplate(
      {Key? key,
      this.bottomSheet,
      this.fabOnPress,
      required this.showFAB,
      required this.bodyWidget,
      this.appBarWidget,
      this.resizeToAvoidBottomInset=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBarHeight = MediaQuery.of(context).size.height * 0.28;
    var bottomSheetHeight = MediaQuery.of(context).size.height * 0.12;
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      //backgroundColor: Colors.transparent,
      appBar: appBarWidget!=null?CustomAppBar(heightOfAppBar: appBarHeight,appBarWidget: appBarWidget,):null,
      body: Container(
        color: CustomColors().customGreenColor,
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          children: [
            //CustomAppBar(heightOfAppBar: 500),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors().customWhiteColor,
                  borderRadius: appBarWidget!=null?BorderRadius.only(topLeft: Radius.circular(30)):BorderRadius.only(topLeft: Radius.circular(0)),
                ),
                child: bodyWidget,
              ),
            ),
          ],
        ),
      ),
      //heightOfAppBar: 300),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showFAB
          ? Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors().customWhiteColor,
              ),
              padding: EdgeInsets.all(10),
              child: FloatingActionButton(
                backgroundColor: CustomColors().customGreenColor,
                child: Icon(
                  Icons.arrow_forward,
                  size: 40,
                ),
                onPressed: () => fabOnPress!(),
              ),
            )
          : null,

      bottomSheet: bottomSheet!=null? Container(
        height: bottomSheetHeight,
        color: CustomColors().customWhiteColor,
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            borderRadius: showFAB
                ? BorderRadius.only(topRight: Radius.circular(0))
                : BorderRadius.only(topRight: Radius.circular(30)),
            color: CustomColors().customGreenColor,
          ),
          //child: bottomSheet,
          child:  bottomSheet
          //CustomBottomSheet(addVisitor: (){},home: (){}),
        ),
      ):
      null,
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  double heightOfAppBar;
  Widget? appBarWidget;

  CustomAppBar({Key? key, required this.heightOfAppBar,required this.appBarWidget}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(heightOfAppBar);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        color: CustomColors().customWhiteColor,
        height: widget.heightOfAppBar,
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors().customGreenColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
            ),
          ),
          child: widget.appBarWidget,
        ),
      );
}
