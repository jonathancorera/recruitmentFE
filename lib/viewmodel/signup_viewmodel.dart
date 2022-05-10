import 'package:flutter/cupertino.dart';
import 'package:recruitmentclient/services/signup_service.dart';

import '../model/api_status.dart';
import '../model/signup_response.dart';


//viewmodel class that handles the state of the signup page


class SignUpViewModel extends ChangeNotifier {

  bool _loading = false;
  SignUpResponse? _signUpResponse;
  ReturnError? _signUpError;
  bool _signUpSuccess =false;
  

  bool get loading => _loading;
  SignUpResponse? get signUpResponse => _signUpResponse;
  ReturnError? get signUpError => _signUpError;
   bool get signUpSuccess => _signUpSuccess;

  SignUpViewModel() {
    print("signup viewmodel instantiated");
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

    setSignUpSuccess(bool signUpSuccess)  {
    _signUpSuccess = signUpSuccess;
  }


  
  setSignUpModel(SignUpResponse signUpResponse) {
    _signUpResponse = signUpResponse;
  }


  setSignUpError(ReturnError signUpError) {
    _signUpError = signUpError;
  }


  Future<void> signUp(String firstName, String lastName, String userName, String password, String chosenRole) async {

      setLoading(true);

      var response = await SignUpService().signUp(firstName, lastName, userName, password,chosenRole);

      if (response is Success) {
        SignUpResponse receivedSignUpResponse =
            response.response as SignUpResponse;
            setSignUpModel(receivedSignUpResponse);
            if(receivedSignUpResponse.message!.contains("Succesfully created the user"))
            setSignUpSuccess(true);
      }
      if (response is Failure) {
        ReturnError loginError = ReturnError(
          code: response.code,
          message: response.errorResponse,
        );
        setSignUpError(loginError);
      }

    setLoading(false);

  }
}
