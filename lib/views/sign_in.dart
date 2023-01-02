import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/sharedPreferences/user_preferences.dart';
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
  bool hidePassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return !isLaoding? SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: Column(
            children: [
              Text(
                "Sign in",
                style: TextStyle(
                    color: CustomColors().customGreenColor,
                    fontSize: 23,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomerBuilt(
                textInputType: TextInputType.emailAddress,
                hintTxt: "Email",
                //icoon: Icons.email,
                isEmail: true,
                icoon: Icons.email,
                controller: emailControllar,
              ),
              TextFormFieldCustomerBuilt(
                eyeIcon: InkWell(
                    onTap: (){
                      _togglePasswordView();
                    },
                    child: Icon(hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off,color: CustomColors().customGreenColor,)),
                obscText: hidePassword,
                showEyeIcon: true,
                hintTxt: "Password",
                icoon: Icons.key,
                controller: passwordControllar,
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
    Center(child: CircularProgressIndicator(color: CustomColors().customGreenColor,));
  }

  void _togglePasswordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void signInfunction() async {
    final isValid = formKey.currentState?.validate();
    if(isValid!){
      setState(() {
        isLaoding = true;
      });
      String data = await loginRequestObject.singnIn(emailControllar.text, passwordControllar.text);
      // print(jsonDecode(data));
      if(data!='null'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VisitorList(token: jsonDecode(data)["token"],)));
        // setState(() {
        //   isLaoding = false;
        // });
      }
      else{
        setState(() {
          isLaoding = false;
        });
        showToast();
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
