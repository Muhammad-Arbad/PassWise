import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwise_app_rehan_sb/constants/custom_colors.dart';
import 'package:passwise_app_rehan_sb/models/sign_up_model.dart';
import 'package:passwise_app_rehan_sb/services/http_request.dart';
import 'package:passwise_app_rehan_sb/sharedPreferences/user_preferences.dart';
import 'package:passwise_app_rehan_sb/views/sign_in_up.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_button.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_field.dart';
import 'package:passwise_app_rehan_sb/widgets/custom_text_form_phone_no.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameControllar = TextEditingController();
  TextEditingController phoneNoControllar = TextEditingController();
  TextEditingController officeControllar = TextEditingController();
  TextEditingController securityCodeControllar = TextEditingController();
  TextEditingController emailControllar = TextEditingController();
  TextEditingController passwordControllar = TextEditingController();


  HttpRequest signUpRequestObject = HttpRequest();
  bool isLaoding = false,hidePassword=true;
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
                "Create Account",
                style: TextStyle(
                    color: CustomColors().customGreenColor,
                    fontSize: 23,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomerBuilt(
                hintTxt: "Name",
                icoon: Icons.person,
                controller: nameControllar,
              ),
              TextFormFieldCustomerBuiltPhoneNumber(
                isNumber: true,
                textInputType: TextInputType.number,
                hintTxt: "Phone no",
                icoon: Icons.phone_android,
                controller: phoneNoControllar,
              ),
              TextFormFieldCustomerBuilt(
                hintTxt: "Office",
                icoon: Icons.home_outlined,
                controller: officeControllar,
              ),
              TextFormFieldCustomerBuilt(
                textInputType: TextInputType.number,
                hintTxt: "Security Code",
                icoon: Icons.format_list_numbered,
                controller: securityCodeControllar,
              ),
              TextFormFieldCustomerBuilt(
                isEmail: true,
                textInputType: TextInputType.emailAddress,
                hintTxt: "Email",
                icoon: Icons.email_outlined,
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
                icoon: Icons.key_outlined,
                controller: passwordControllar,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButtonWidget(
                      btntext: 'Sign Up',
                      btnonPressed: signUpfunction
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

  void signUpfunction() async {

    final isValid = formKey.currentState?.validate();
    if(isValid!){

      Sign_Up_Model sign_up_model = Sign_Up_Model(
        name: nameControllar.text,
          phoneNo: phoneNoControllar.text,
          office: officeControllar.text,
          code: securityCodeControllar.text,
          email: emailControllar.text,
          password: passwordControllar.text,
     );
      setState(() {
        isLaoding = true;
      });


      String response = await signUpRequestObject.signUp(sign_up_model);
      setState(() {
        isLaoding = false;
      });
      if(response=='success'){
        showToast("Account Created");
        emptyTextFields();
      }
      else
        {
          showToast(response);
        }
    }
  }

  void showToast(String response) {
    Fluttertoast.showToast(
        msg: response,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: response=='Account Created'?CustomColors().customGreenColor:Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void emptyTextFields() {
     nameControllar.text = "";
     phoneNoControllar.text = "";
     officeControllar.text = "";
     securityCodeControllar.text = "";
     emailControllar.text = "";
     passwordControllar.text = "";
     setState(() {
     });
  }
}
