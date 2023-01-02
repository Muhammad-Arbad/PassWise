import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';

class TextFormFieldCustomerBuiltSearch extends StatefulWidget {
  TextFormFieldCustomerBuiltSearch(
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
        this.onChange});

  TextEditingController? controller;
  String? hintTxt, suffitext;
  IconData? icoon;
  bool? obscText = false;
  VoidCallback? ontap;
  TextInputType? textInputType = TextInputType.text;
  bool? isOptional = false, isNumber = false;
  int? maxLines;
  bool? showSeparator = true;
  void Function(String)? onChange;

  @override
  State<TextFormFieldCustomerBuiltSearch> createState() =>
      _TextFormFieldCustomerBuiltSearchState();
}

class _TextFormFieldCustomerBuiltSearchState
    extends State<TextFormFieldCustomerBuiltSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        autofocus: true,
        onChanged:widget.onChange,
        maxLines: widget.obscText ?? false ? 1 : widget.maxLines,
        inputFormatters: widget.isNumber != true
            ? []
            : [FilteringTextInputFormatter.digitsOnly],
        keyboardType: widget.textInputType,
        obscureText: widget.obscText ?? false,
        validator: widget.isOptional != true
            ? (value) {
          if (value!.isEmpty) {
            //return null;
            return widget.hintTxt!=null?widget.hintTxt! + " should not be null":
            "Fiels should not be null";
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
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: CustomColors().customGreenColor,
              width: 1.0,
            ),
          ),

          hintText: widget.hintTxt,
          //suffixIcon: ,
          suffixIcon: widget.icoon!=null ?? true
              ? Container(
              child: Icon(widget.icoon,
                  size: 30,
                  color: CustomColors().customGreenColor))
              : null,
          //suffixText: widget.suffitext,
        ),
      ),
    );
  }
}
