import 'package:flutter/material.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_button.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Signup Comming soon",style: TextStyle(fontSize: 30,color: CustomColors().customGreenColor),),
      ),
    );
    // return Container(
    //   padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
    //   child: Column(
    //     children: [
    //       Text(
    //         "Sign up",
    //         style: TextStyle(
    //             color: CustomColors().customGreenColor,
    //             fontSize: 30),
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       TextFormFieldCustomerBuilt(
    //         hintTxt: "Phone no",
    //         icoon: Icons.phone,
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       TextFormFieldCustomerBuilt(
    //         hintTxt: "Password",
    //         icoon: Icons.key,
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Text("Forgot password?"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           CustomButtonWidget(
    //               btntext: 'Sign in',
    //               btnonPressed: signUpfunction)
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  void signUpfunction() {}
}
