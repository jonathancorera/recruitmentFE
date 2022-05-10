import 'package:http/http.dart' as http;
import 'package:recruitmentclient/model/login_response.dart';

import 'dart:convert';

import '../common/urlsolver.dart';
import '../model/api_status.dart';

//service class for login

class LoginService {
  //method to log in a user
  Future<Object> login(String userName, String password) async {
    var user = {};

    user["username"] = userName;
    user["password"] = password;

    String usrJson = json.encode(user);

    try {
      var response = await http.post(Uri.parse(UrlSolver.login()),
          headers: {"Content-Type": "application/json"}, body: usrJson);

      if (response.statusCode == 200) {
        return Success(response: loginResponseFromJson(response.body));
      }
      return Failure(
          code: response.statusCode, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }
}
