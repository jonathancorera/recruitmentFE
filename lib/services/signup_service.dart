import 'package:http/http.dart' as http;

import 'dart:convert';

import '../common/urlsolver.dart';
import '../model/api_status.dart';
import '../model/signup_response.dart';

//service class to create users

class SignUpService {
  //method to create a user
  Future<Object> signUp(
    String firstName,
    String lastName,
    String userName,
    String password,
    String chosenRole,
  ) async {
    var createUser = {};

    var role = {};

    if (chosenRole == "JOBSEEKER") {
      role["id"] = 2;
      role["name"] = "JOBSEEKER";
    } else {
      role["id"] = 1;
      role["name"] = "RECRUITER";
    }

    createUser["firstName"] = firstName;
    createUser["lastName"] = lastName;
    createUser["password"] = password;
    createUser["userName"] = userName;
    createUser["hired"] = false;
    createUser["hiredBy"] = 1;
    createUser["hiredDate"] = DateTime.now().toIso8601String();
    createUser["isActive"] = true;
    createUser["role"] = role;
    createUser["id"] = 0;

    String createJson = json.encode(createUser);

    try {
      var response = await http.post(Uri.parse(UrlSolver.signup()),
          headers: {"Content-Type": "application/json"}, body: createJson);

      print("response code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        return Success(response: signUpResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }
}
