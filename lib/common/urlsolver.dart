import 'package:path/path.dart';


//this file contains all of the endpoint URLs required for API communication with the backend

class UrlSolver {
  //static String root = "http://localhost:8080";
  //  static String rootBare = "localhost:8080";
  static String root = "http://13.41.73.150:8090";
    static String rootBare = "13.41.73.150:8090";

  static login() {
    return root + '/Recruitment/authenticate';
  }

  static signup() {
    return root + '/Recruitment/user/create';
  }

    static getByUserName() {
    return  '/Recruitment/user/getbyusername';
  }

      static getCVByUserId() {
    return  '/Recruitment/cv/getbyuserid/';
  }

        static getallUsers(int page) {
    return  '/Recruitment/user/search/' + page.toString();
  }

static FilterUsers(int page) {
    return  '/Recruitment/user/search/filter/' + page.toString();
  }
          static deleteUser () {
    return  '/Recruitment/user/delete/';
  }
          static deleteCV () {
    return  '/Recruitment/cv/delete/';
  }

  static createCV(){
    return '/Recruitment/cv/create';
  }

    static generateCVPdf(){
    return '/Recruitment/cv/createpdf';
  }

  static getUserByQualificationType () {
    return '/Recruitment/user/getbyanyqualificationtypeandparameter';
  }

 static getUserBySkill () {
    return '/Recruitment/user/getbyanyskillparameter';
    
  }
 static getUserByExperience () {
    return '/Recruitment/user/getbyanyexperienceparameter';
  }
   static getUserByMinQualificationLevel (int qualLevel) {
    return '/Recruitment/user/getbyminqualificationlevel/' + qualLevel.toString();
  }
    static getUserByMinGCSEPasses (int minPasses) {
    return '/Recruitment/user/getbymingcsepasses/' + minPasses.toString();
  }

      static getUserByJobSector () {
    return '/Recruitment/user/getbyjobsector';
  }



}
