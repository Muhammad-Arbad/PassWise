import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';

class TextFormFieldCustomerBuilt extends StatefulWidget {
  TextFormFieldCustomerBuilt(
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
      this.showSeparator});

  TextEditingController? controller;
  String? hintTxt, suffitext;
  IconData? icoon;
  bool? obscText = false;
  VoidCallback? ontap;
  TextInputType? textInputType = TextInputType.text;
  bool? isOptional = false, isNumber = false;
  int? maxLines;
  bool? showSeparator = true;

  @override
  State<TextFormFieldCustomerBuilt> createState() =>
      _TextFormFieldCustomerBuiltState();
}

class _TextFormFieldCustomerBuiltState
    extends State<TextFormFieldCustomerBuilt> {
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
            ? (value) {
                if (value!.isEmpty) {
                  //return null;
                  return widget.hintTxt! + " should not be null";
                } else {
                  return null;
                }
              }
            : (value) {},
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
          prefixIcon: widget.showSeparator ?? true
              ? Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: CustomColors().customGreenColor)),
                  ),
                  child: Icon(widget.icoon,
                      color: CustomColors().customGreenColor))
              : null,
          //suffixText: widget.suffitext,
        ),
      ),
    );
  }
}
