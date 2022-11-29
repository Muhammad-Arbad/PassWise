import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:passwise_app_rehan_sb/models/visitor_details.dart';

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
    // else if(response.statusCode==401){
    //   return "invalid";
    // }
    else
      {
        return "null";
      }

  }
}
