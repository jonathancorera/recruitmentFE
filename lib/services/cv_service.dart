import 'package:http/http.dart' as http;

import 'package:recruitmentclient/model/create_cv_response.dart';
import 'package:recruitmentclient/model/delete_cv_response.dart';
import 'package:recruitmentclient/model/login_response.dart';
import 'package:recruitmentclient/model/cv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/urlsolver.dart';
import '../model/api_status.dart';

import 'dart:html' as html;

//service class for all CV-related requests

class CVService {
  LoginResponse? userInfo;
  //fetch logged user object from memory to obtain authentication token
  Future<LoginResponse> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return loginResponseFromJson(prefs.getString("user")!);
  }

  //method to get a CV by the user Id
  Future<Object> getCVByUserId(int userId) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare, UrlSolver.getCVByUserId(),
        {"userId": userId.toString()});

    try {
      var response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + userInfo.jwttoken!
      });

      if (response.statusCode == 200) {
        return Success(response: cvFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to create a CV
  Future<Object> createCV(int userId, CV cv) async {
    LoginResponse userInfo = await getUserDetails();

    String cvJson = cvToJson(cv);

    final uri = Uri.http(UrlSolver.rootBare, UrlSolver.createCV(),
        {"userId": userId.toString()});

    try {
      var response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + userInfo.jwttoken!,
          },
          body: cvJson);
      if (response.statusCode == 200) {
        return Success(response: createCvResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

  //method to delete a CV
  Future<Object> deleteCV(int userId) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare, UrlSolver.deleteCV(),
        {"userId": userId.toString()});

    try {
      var response = await http.delete(uri, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + userInfo.jwttoken!
      });

      if (response.statusCode == 200) {
        return Success(response: deleteCvResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } catch (e) {
      return Failure(code: 100, errorResponse: "Error");
    }
  }

//method to generate a pdf of a CV
  void generatePdf(int userId) async {
    LoginResponse userInfo = await getUserDetails();

    final uri = Uri.http(UrlSolver.rootBare, UrlSolver.generateCVPdf(),
        {"userId": userId.toString()});

     downloadFile("http://localhost:8080/Recruitment/cv/createpdf?userId=" + userId.toString());
  }


//helper function to download a PDF from a browser
void downloadFile(String url) {
   html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
   anchorElement.download = url;
   anchorElement.click();
}

}
