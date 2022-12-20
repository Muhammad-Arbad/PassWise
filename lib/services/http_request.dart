import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passwise_app_rehan_sb/models/sign_up_model.dart';

class HttpRequest {

  String baseUrl = "https://api.passwise.app/";
  String token = "";

  Future<List> getAllPasses(String token) async {
    token = token;
    http.Response response = await http.get(
      Uri.parse(baseUrl + "passes"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Cookie": "auth_token=" + token
      },
    );
    if (response.statusCode == 200) {
      print("Rsponse received");
      print(jsonDecode(response.body));
      return(jsonDecode(response.body));
    } else {
      print("Rsponse Not received");
      print(response.statusCode);
      return [];
    }
  }

  Future<String> requestLogin(String username, String password) async {
    Map<String, String> loginRequestBody = {
      'email': username,
      'password': password
    };
    var body = json.encode(loginRequestBody);

    final response = await http.post(
      Uri.parse(baseUrl + "login"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print("invalidasjdn = "+response.statusCode.toString());
    if(response.statusCode==200){
      print(response.statusCode);
      print(response.body);
      token = jsonDecode(response.body)["token"];
      return response.body;
    }
    else
      {
        return "null";
      }

  }


  Future<String> signUp(Sign_Up_Model sign_up_model) async{
    var headers = {
      'Content-Type': 'application/json',
     };
    var response = await http.post(Uri.parse('https://api.passwise.app/signup'),
    body : json.encode({
      "name": sign_up_model.name,
      "password": sign_up_model.password,
      "email": sign_up_model.email,
      "user_role": "Company",
      "office": sign_up_model.office,
      "phone_no": sign_up_model.phoneNo,
      "code": sign_up_model.code
    }),
    headers:headers);



    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return "success";
    }
    else {
      print(response.reasonPhrase);
      return jsonDecode(response.body)['message'];
    }


  }

}
