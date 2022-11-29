import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/views/visitor_list.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_button.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_field.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailControllar = TextEditingController();

  TextEditingController passwordControllar = TextEditingController();

  HttpRequest loginRequestObject = HttpRequest();
  bool isLaoding = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return !isLaoding? SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            children: [
              Text(
                "Sign in",
                style: TextStyle(
                    color: CustomColors().customGreenColor,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              // TextFormFieldCustomerBuilt(
              //   textInputType: TextInputType.phone,
              //   hintTxt: "Phone no",
              //   icoon: Icons.phone,
              // ),
              TextFormFieldCustomerBuilt(
                textInputType: TextInputType.emailAddress,
                hintTxt: "Email",
                //icoon: Icons.email,
                icoon: Icons.email,
                controller: emailControllar,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomerBuilt(
                obscText: true,
                hintTxt: "Password",
                icoon: Icons.key,
                controller: passwordControllar,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot password?"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButtonWidget(
                      btntext: 'Sign in',
                      btnonPressed: signInfunction
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ):
    Center(child: CircularProgressIndicator())
    ;
  }

  void signInfunction() async {
    final isValid = formKey.currentState?.validate();
    if(isValid!){
      setState(() {
        isLaoding = true;
      });
      String data = await loginRequestObject.requestLogin(emailControllar.text, passwordControllar.text);
      print(jsonDecode(data));
      if(data!='null'){
        print("Login Successful");
        // Fluttertoast.showToast(
        //     msg: "Login Successful",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitorList(token: jsonDecode(data)["token"],)));
        setState(() {
          isLaoding = false;
        });
      }
      // else if(data=='invalid'){
      //   print("Invalid user name or password");
      //   setState(() {
      //     isLaoding = false;
      //   });
      //   //showToast();
      // }
      else{
        print("else part");
        setState(() {
          isLaoding = false;
        });
        showToast();
        // Fluttertoast.showToast(
        //     msg: "invalid Email or Password",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
    }

  }
  void showToast() {
    Fluttertoast.showToast(
        msg: "Invalid username or password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
