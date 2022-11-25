import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';

class CustomButtonWidget extends StatefulWidget {
  CustomButtonWidget({required this.btntext,this.btncolor,this.btnonPressed});
  String btntext;
  Color? btncolor;
  VoidCallback? btnonPressed;

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(widget.btntext,style: TextStyle(fontWeight: FontWeight.bold),),
      style: ElevatedButton.styleFrom(
        primary: CustomColors().customGreenColor,
        padding: EdgeInsets.all(18),
        onPrimary: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: CustomColors().customGreenColor)),
      ),
      onPressed: widget.btnonPressed,
    );
  }
}