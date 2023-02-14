import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';

class TextFormFieldCustomerBuiltPhoneNumber extends StatefulWidget {
  TextFormFieldCustomerBuiltPhoneNumber(
      {Key? key,
        this.controller,
        this.hintTxt,
        this.icoon,
        this.obscText,
        this.ontap,
        this.suffitext,
        this.textInputType,
        this.isOptional,
        this.isNumber,
        this.maxLines,
        this.showSeparator,
        this.eyeIcon,
        this.showEyeIcon,
        this.isEmail,
        this.isonAssetPath
      });

  TextEditingController? controller;
  String? hintTxt, suffitext,isonAssetPath;
  IconData? icoon;
  bool? obscText = false;
  VoidCallback? ontap;
  TextInputType? textInputType = TextInputType.text;
  bool? isOptional = false, isNumber = false, isEmail = false;
  int? maxLines;
  bool? showSeparator = true, showEyeIcon = false;
  Widget? eyeIcon;


  @override
  State<TextFormFieldCustomerBuiltPhoneNumber> createState() =>
      _TextFormFieldCustomerBuiltPhoneNumberState();
}

class _TextFormFieldCustomerBuiltPhoneNumberState
    extends State<TextFormFieldCustomerBuiltPhoneNumber> {

  String phoneNumberPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
      ),
      child: TextFormField(
        maxLines: widget.obscText ?? false ? 1 : widget.maxLines,
        //minLines:2,
        inputFormatters: widget.isNumber != true
            ? []
            : [FilteringTextInputFormatter.digitsOnly],
        keyboardType: widget.textInputType,
        obscureText: widget.obscText ?? false,
        validator: widget.isOptional != true
            ? widget.isNumber!=true
            ? (value) {
          if (value!.isEmpty) {
            return widget.hintTxt != null
                ? widget.hintTxt! + " should not be null"
                : "Fiels should not be null";
          } else {
            return null;
          }
        } : (value) {
          if (value == null ||
              value.isEmpty ||
              value.length!=11) {
            return 'Enter a valid Phone Number';
          } else {
            return null;
          }
        } : (value) {},

        onTap: widget.ontap,
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: CustomColors().customGreenColor,
              width: 1.0,
            ),
          ),

          hintText: widget.hintTxt,
          suffixIcon: widget.showEyeIcon == true ? widget.eyeIcon : null,
          prefixIcon: widget.showSeparator ?? true
              ? Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                    right:
                    BorderSide(color: CustomColors().customGreenColor)),
              ),
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageIcon(
                  AssetImage(widget.isonAssetPath??"assets/add.png"),
                  color: CustomColors().customGreenColor,
                ),
              ),
              // Icon(widget.icoon,
              //     color: CustomColors().customGreenColor),
          )
              : null,
          //suffixText: widget.suffitext,
        ),
      ),
    );
  }
}
