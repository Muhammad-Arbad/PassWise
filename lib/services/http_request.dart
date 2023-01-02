import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:passwise_app_rehan_sb/models/add_visitor_model.dart';
import 'package:passwise_app_rehan_sb/models/sign_up_model.dart';
import 'package:passwise_app_rehan_sb/sharedPreferences/user_preferences.dart';

class HttpRequest {

  String baseUrl = "https://api.passwise.app/";
  String token = "";

  Future<List> getAllPasses(String token) async {
    token = token;
    http.Response response = await http.get(
      Uri.parse(baseUrl + "passes"),
      headers: <String, String>{
        "Content-Type": "application/json",
        // "Cookie": "auth_token=" + token
        "Cookie": "auth_token=" + UserPreferences.getUserToken()!
      },
    );
    if (response.statusCode == 200) {
      // print("Rsponse received");
      // print(jsonDecode(response.body));
      return(jsonDecode(response.body));
    } else {
      // print("Rsponse Not received");
      // print(response.statusCode);
      return [];
    }
  }

  Future<String> singnIn(String username, String password) async {
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

    // print("invalidasjdn = "+response.statusCode.toString());
    if(response.statusCode==200){
      // print(response.statusCode);
      // print(response.body);
      UserPreferences.setUserToken(jsonDecode(response.body)["token"]);
      String x = jsonDecode(response.body)["expiresIn"];
      List<String> c = x.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
      c.removeLast(); // ['a', 'a', 'a', 'b', 'c']
      x = c.join();
      // print(x);
      //UserPreferences.setExpiryTime(int.parse(jsonDecode(response.body)["expiresIn"]));
      //UserPreferences.setExpiryTime(int.parse(x));

      // DateTime expiryTime = DateTime.now().add(Duration(seconds: 30));
      DateTime expiryTime = DateTime.now().add(Duration(seconds: int.parse(x)));
      UserPreferences.setExpiryTime(expiryTime.toString());
      UserPreferences.setCompanyName(jsonDecode(response.body)["user"]['office']);

      // print("DateTime.now().second"+DateTime.now().toString());
      // print("expiryTime.second"+expiryTime.toString());



      //print("ExpiryTime = "+jsonDecode(response.body)["expiresIn"]);
      //token = jsonDecode(response.body)["token"];
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
      // print(jsonDecode(response.body));
      return "success";
    }
    else {
      // print(response.reasonPhrase);
      return jsonDecode(response.body)['message'];
    }


  }

  Future<String?> addVisitor(AddVisitorModel addVisitorModel)async{

    var headers = {
      'Content-Type': 'application/json',
      // 'Cookie': 'auth_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNmRlMDYzNGJiZjRlOTNiOTg2OWU1MyIsImlhdCI6MTY3MTYwMjYyNiwiZXhwIjoxNjcxNjQ1ODI2fQ.YxowVkehKMy0CzuSUnDCCZZ7t8CFPppOkSD9bC_Aydw'
      'Cookie': 'auth_token='+UserPreferences.getUserToken()!
    };
    var request = http.Request('POST', Uri.parse('https://api.passwise.app/passGen'));

    request.body = json.encode(addVisitorModel.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // print("Response status code = "+response.statusCode.toString());

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return "allowed";
    }
    else {
      // print(response.reasonPhrase);
      return response.reasonPhrase;
    }
  }

  Future<String> uploadImage(String file)async{

    var headers = {
      'Cookie': 'auth_token='+UserPreferences.getUserToken()!
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://api.passwise.app/imageUpload'));
    request.files.add(await http.MultipartFile.fromPath('image', file));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print("if part of Image");
    // print(await response.stream.bytesToString());
    return await response.stream.bytesToString();
    }
    else {
      // print("else part of Image");
    // print(response.reasonPhrase);
    return "null";
    }
  }

}
