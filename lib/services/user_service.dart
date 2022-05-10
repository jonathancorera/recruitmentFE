import 'package:http/http.dart' as http;
import 'package:recruitmentclient/model/delete_user_response.dart';
import 'package:recruitmentclient/model/get_user_list_response.dart';
import 'package:recruitmentclient/model/login_response.dart';
import 'package:recruitmentclient/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../common/urlsolver.dart';
import '../model/api_status.dart';
import '../model/query_response.dart';

//service class for all user-related requests

class UserService {
  LoginResponse? userInfo;

  //fetch logged user object from memory to obtain authentication token
  Future<LoginResponse> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return loginResponseFromJson(prefs.getString("user")!);
  }

  //method to get user object by username
  Future<Object> getByUserName(String userName) async {
    LoginResponse userInfo = await getUserDetails();

    final queryParameters = {"email": userName};

    final uri = Uri.http(
        UrlSolver.rootBare, UrlSolver.getByUserName(), {"email": userName});

    try {
      var response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + userInfo.jwttoken!
      });

      if (response.statusCode == 200) {
        return Success(response: userFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

//method to get all users
  Future<Object> getUserList(int page) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare, (UrlSolver.getallUsers(page)));

    try {
      var response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + userInfo.jwttoken!
      });

      if (response.statusCode == 200) {
        return Success(response: getUserListResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

//method to filter users by qualification type
  Future<Object> filterByQualType(String type, String query) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(
        UrlSolver.rootBare,
        (UrlSolver.getUserByQualificationType()),
        {"qualificationType": type, "searchParam": query});

    try {
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + userInfo.jwttoken!
        },
      );

      if (response.statusCode == 200) {
        return Success(response: queryResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to filter users by skill
  Future<Object> filterBySkill(String type) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(
        UrlSolver.rootBare, (UrlSolver.getUserBySkill()), {"skill": type});

    try {
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + userInfo.jwttoken!
        },
      );

      if (response.statusCode == 200) {
        return Success(response: queryResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to filter users by experience
  Future<Object> filterByExperience(String type) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare, (UrlSolver.getUserByExperience()),
        {"experience": type});

    try {
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + userInfo.jwttoken!
        },
      );

      if (response.statusCode == 200) {
        return Success(response: queryResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to filter users by minimum qualification level
  Future<Object> filterByMinQualLevel(int qualLevel) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare,
        (UrlSolver.getUserByMinQualificationLevel(qualLevel)));

    try {
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + userInfo.jwttoken!
        },
      );

      if (response.statusCode == 200) {
        return Success(response: queryResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  Future<Object> filterByMinGCSEPasses(int minPasses) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(
        UrlSolver.rootBare, (UrlSolver.getUserByMinGCSEPasses(minPasses)));

    try {
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + userInfo.jwttoken!
        },
      );

      if (response.statusCode == 200) {
        return Success(response: queryResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to filter users by job sector
  Future<Object> filterByJobSector(String jobSector) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare, UrlSolver.getUserByJobSector(),
        {"jobsector": jobSector});

    try {
      var response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + userInfo.jwttoken!
        },
      );

      if (response.statusCode == 200) {
        return Success(response: queryResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to delete users
  Future<Object> deleteUser(int userId) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(
        UrlSolver.rootBare, UrlSolver.deleteUser(), {"id": userId.toString()});

    try {
      var response = await http.delete(uri, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + userInfo.jwttoken!
      });

      if (response.statusCode == 200) {
        return Success(response: deleteUserResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }
}
