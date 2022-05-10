import 'package:flutter/cupertino.dart';
import 'package:recruitmentclient/model/create_cv_response.dart';
import 'package:recruitmentclient/model/cv.dart';
import 'package:recruitmentclient/model/delete_cv_response.dart';
import 'package:recruitmentclient/services/cv_service.dart';

import '../model/api_status.dart';

//viewmodel class that handles the state of all pages that deal with CV

class CVViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _paginationLoading = false;
  bool _islastPage = false;
  int _totalPages = 0;

  CV? _cv;
  ReturnError? _getCvError;
  ReturnError? _createCvError;
  ReturnError? _deleteCvError;

  List<CV> _cvList = [];
  int _currentPage = 1;
  String _lastQuery = "";

  CreateCvResponse? _createCvResponse;

  bool _cvDeletedSuccessfully = false;

  bool get loading => _loading;
  bool get paginationloading => _paginationLoading;
  bool get cvDeletedSuccessfully => _cvDeletedSuccessfully;
  bool get isLastPage => _islastPage;
  int get totalPages => _totalPages;
  CV? get cv => _cv;
  ReturnError? get getCvError => _getCvError;
  List<CV>? get cvList => _cvList;
  int get currentPage => _currentPage;
  String get lastQuery => _lastQuery;
  CreateCvResponse? get createCvResponse => _createCvResponse;
  ReturnError? get createCvError => _createCvError;
  ReturnError? get deleteCvError => _deleteCvError;

  CVViewModel() {
    clearCvs();
  }

  setCvDeletedSuccessfully(bool cvDeletedSuccessfully) async {
    _cvDeletedSuccessfully = cvDeletedSuccessfully;
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

  setCVModel(CV cv) {
    _cv = cv;
  }

  setCreateCvResponse(CreateCvResponse createCvResponse) {
    _createCvResponse = createCvResponse;
  }

  setUserList(List<CV> cvList) {
    _cvList = cvList;
  }

  clearCvs() {
    _cvList.clear();
  }

  setGetCVError(ReturnError getCvError) {
    _getCvError = getCvError;
  }

  setCreateCVError(ReturnError createCvError) {
    _createCvError = createCvError;
  }

  setDeleteCVError(ReturnError createCvError) {
    _deleteCvError = deleteCvError;
  }

  getCVbyUserId(int userId) async {
    setLoading(true);

    var response = await CVService().getCVByUserId(userId);

    if (response is Success) {
      CV receivedCvResponse = response.response as CV;
      setCVModel(receivedCvResponse);
    }
    if (response is Failure) {
      ReturnError cvError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setGetCVError(cvError);
    }

    setLoading(false);
  }

  createCV(int userId, CV cv) async {
    setLoading(true);

    var response = await CVService().createCV(userId, cv);

    if (response is Success) {
      CreateCvResponse receivedCvResponse =
          response.response as CreateCvResponse;
      setCreateCvResponse(receivedCvResponse);
    }
    if (response is Failure) {
      ReturnError cvError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setCreateCVError(cvError);
    }

    setLoading(false);
  }

  deleteCV(int userId) async {
    setLoading(true);
    setCvDeletedSuccessfully(false);

    var response = await CVService().deleteCV(userId);

    if (response is Success) {
      DeleteCvResponse receivedUserResponse =
          response.response as DeleteCvResponse;
      if (receivedUserResponse.message == "Succesfully deleted the CV")
        setCvDeletedSuccessfully(true);
    }
    if (response is Failure) {
      ReturnError userError = ReturnError(
        code: response.code,
        message: response.errorResponse,
      );
      setDeleteCVError(userError);
    }

    setLoading(false);
  }

  generateCVPDf(int userId) async {
    setLoading(true);

    CVService().generatePdf(userId);

    setLoading(false);
  }
}
