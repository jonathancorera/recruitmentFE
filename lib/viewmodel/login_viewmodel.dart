import 'package:flutter/cupertino.dart';

import '../model/api_status.dart';
import '../model/login_response.dart';
import '../services/login_service.dart';

//viewmodel class that handles the state of the login page

class LoginViewModel extends ChangeNotifier {
  bool _loading = false;
  LoginResponse? _loginResponse;
  ReturnError? _loginError;
  bool _loginSuccess = false;
  bool _loginCredError = false;

  bool get loading => _loading;
  LoginResponse? get loginResponse => _loginResponse;
  ReturnError? get loginError => _loginError;
  bool get loginSuccess => _loginSuccess;
  bool get loginCredError => _loginCredError;

  LoginViewModel() {
    print("login view instantiated");
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLoginSuccess(bool loginSucess) {
    _loginSuccess = loginSucess;
  }

  setLoginCredError(bool loginCredError) {
    _loginCredError = loginCredError;
  }

  setLoginModel(LoginResponse loginResponse) {
    _loginResponse = loginResponse;
  }

  setLoginError(ReturnError loginError) {
    _loginError = loginError;
  }

  Future<void> login(String userName, String password) async {
    setLoading(true);
    setLoginSuccess(false);
    setLoginCredError(false);

    var response = await LoginService().login(userName, password);

    if (response is Success) {
      LoginResponse receivedLoginResponse = response.response as LoginResponse;
      setLoginModel(receivedLoginResponse);
      if (receivedLoginResponse.message == "Login Success!")
        setLoginSuccess(true);
    }
    if (response is Failure) {
      ReturnError loginError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );

      if (loginError.code == 401) setLoginCredError(true);
      setLoginError(loginError);
    }

    setLoading(false);
  }
}
