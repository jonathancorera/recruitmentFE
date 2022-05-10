import 'package:flutter/cupertino.dart';
import 'package:recruitmentclient/model/delete_user_response.dart';
import 'package:recruitmentclient/model/get_user_list_response.dart';
import 'package:recruitmentclient/model/user.dart';
import 'package:recruitmentclient/services/user_service.dart';

import '../model/api_status.dart';

//viewmodel class that handles the state of all pages that deal with Users


class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _paginationLoading = false;
  bool _islastPage = false;
  int _totalPages = 0;

  bool _userDeletedSuccessfully = false;

  User? _user;
  GetUserListResponse? _userListResponse;
  ReturnError? _getUserError;
  ReturnError? _deleteUserError;

  List<Content> _userList = [];
  int _currentPage = 1;
  String _lastQuery = "";

  bool get loading => _loading;
  bool get userDeletedSuccessfully => _userDeletedSuccessfully;
  bool get paginationloading => _paginationLoading;
  bool get isLastPage => _islastPage;
  int get totalPages => _totalPages;
  User? get user => _user;
  ReturnError? get getUserError => _getUserError;
  ReturnError? get deleteUserError => _deleteUserError;
  List<Content>? get userList => _userList;
  int get currentPage => _currentPage;
  String get lastQuery => _lastQuery;
  GetUserListResponse get userListResponse => _userListResponse!;

  UserViewModel() {
    print("user viewmodel instantiated");
    clearUsers();
    //getUserList(0);
  }

  setUserDeletedSuccessfully(bool userDeletedSuccessfully) async {
    _userDeletedSuccessfully = userDeletedSuccessfully;
    notifyListeners();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTotalPages(int totalPages) {
    _totalPages = totalPages;
  }

  setLastQuery(String lastQuery) {
    _lastQuery = lastQuery;
  }

  setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }

  incrementPage() {
    _currentPage++;
  }

  setPaginationLoading(bool paginationLoading) async {
    _paginationLoading = paginationLoading;
    notifyListeners();
  }

  setLastPage(bool isLastPage) {
    _islastPage = isLastPage;
  }

  setUserModel(User user) {
    _user = user;
  }

  setUserListResponse(GetUserListResponse userListResponse) {
    _userListResponse = userListResponse;
  }

  setUserList(List<Content> userList) {
    _userList = userList;
  }

  createUserList(GetUserListResponse getUserListResponse) {
    if (getUserListResponse.content != []) {
      for (int i = 0; i < getUserListResponse.content!.length; i++) {
        _userList.add(getUserListResponse.content![i]);
      }
    }
  }

  createUserListfromQuery(List<Content> userList) {
    if (userList != []) {
      for (int i = 0; i < userList.length; i++) {
        _userList.add(userList[i]);
      }
    }
  }

  clearUsers() {
    _userList.clear();
    print("user list cleared");
  }

  setGetUserError(ReturnError getUserError) {
    _getUserError = getUserError;
  }

  setDeleteUserError(ReturnError deleteUserError) {
    _deleteUserError = deleteUserError;
  }

  deleteUser(int userId) async {
    setLoading(true);
    setUserDeletedSuccessfully(false);

    print("delete user viewmodel called");
    var response = await UserService().deleteUser(userId);

    if (response is Success) {
      print("Delete User Response " + response.code.toString());
      DeleteUserResponse receivedUserResponse =
          response.response as DeleteUserResponse;
      if (receivedUserResponse.message == "Succesfully deleted the user")
        setUserDeletedSuccessfully(true);
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setDeleteUserError(userError);
    }

    setLoading(false);
    print("done");
  }

  getUserbyUserName(String userName) async {
    setLoading(true);

    print("Get user viewmodel called");
    var response = await UserService().getByUserName(userName);

    if (response is Success) {
      User receivedUserResponse = response.response as User;
      setUserModel(receivedUserResponse);
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    setLoading(false);
    print("done");
  }

  getUserList(int page) async {
    if (page != 0) {
      setPaginationLoading(true);
    } else {
      setLoading(true);
      setLastPage(false);
      clearUsers();
    }

    if (!_islastPage) {
      var response = await UserService().getUserList(page);

      if (response is Success) {
        GetUserListResponse receivedUsersResponse =
            response.response as GetUserListResponse;
        if (receivedUsersResponse.content!.isNotEmpty) {
          setUserListResponse(receivedUsersResponse);
          createUserList(receivedUsersResponse);
        } else {
          print('is last page');
          setLastPage(true);
          notifyListeners();
        }
      }
      if (response is Failure) {
        ReturnError userError = ReturnError(
          code: response.code,
          message: response.errorResponse,
        );
        setGetUserError(userError);
      }

      print("user list length" + userList!.length.toString());

      setLoading(false);
      setPaginationLoading(false);
    }
  }

  filterUserByJobSector(String jobSector) async {
    setLoading(true);

    var response = await UserService().filterByJobSector(jobSector);

    if (response is Success) {
      List<Content> receivedUsersResponse = response.response as List<Content>;
      if (receivedUsersResponse.isNotEmpty) {
        clearUsers();
        createUserListfromQuery(receivedUsersResponse);
      } else {
        clearUsers();
      }
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    print("user list length" + userList!.length.toString());

    setLoading(false);
    setPaginationLoading(false);
  }

  filterUsersByQualification(String type, String query) async {
    setLoading(true);

    var response = await UserService().filterByQualType(type, query);

    if (response is Success) {
      List<Content> receivedUsersResponse = response.response as List<Content>;
      if (receivedUsersResponse.isNotEmpty) {
        clearUsers();
        createUserListfromQuery(receivedUsersResponse);
      } else {
        clearUsers();
      }
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    print("user list length" + userList!.length.toString());

    setLoading(false);
    setPaginationLoading(false);
  }

  filterUsersByExperience(String type) async {
    setLoading(true);

    var response = await UserService().filterByExperience(type);

    if (response is Success) {
      List<Content> receivedUsersResponse = response.response as List<Content>;
      if (receivedUsersResponse.isNotEmpty) {
        clearUsers();
        createUserListfromQuery(receivedUsersResponse);
      } else {
        clearUsers();
      }
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    print("user list length" + userList!.length.toString());

    setLoading(false);
    setPaginationLoading(false);
  }

  filterUsersBySkill(String type) async {
    setLoading(true);

    var response = await UserService().filterBySkill(type);

    if (response is Success) {
      List<Content> receivedUsersResponse = response.response as List<Content>;
      if (receivedUsersResponse.isNotEmpty) {
        clearUsers();
        createUserListfromQuery(receivedUsersResponse);
      } else {
        clearUsers();
      }
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    print("user list length" + userList!.length.toString());

    setLoading(false);
    setPaginationLoading(false);
  }

  filterUsersByMinQualLevel(int type) async {
    setLoading(true);

    var response = await UserService().filterByMinQualLevel(type);

    if (response is Success) {
      List<Content> receivedUsersResponse = response.response as List<Content>;
      if (receivedUsersResponse.isNotEmpty) {
        clearUsers();
        createUserListfromQuery(receivedUsersResponse);
      } else {
        clearUsers();
      }
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    print("user list length" + userList!.length.toString());

    setLoading(false);
    setPaginationLoading(false);
  }

  filterUsersByMinGCSEPasses(int minPasses) async {
    setLoading(true);

    var response = await UserService().filterByMinGCSEPasses(minPasses);

    if (response is Success) {
      List<Content> receivedUsersResponse = response.response as List<Content>;
      if (receivedUsersResponse.isNotEmpty) {
        clearUsers();
        createUserListfromQuery(receivedUsersResponse);
      } else {
        clearUsers();
      }
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetUserError(userError);
    }

    print("user list length" + userList!.length.toString());

    setLoading(false);
    setPaginationLoading(false);
  }
}
