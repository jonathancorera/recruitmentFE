//generic model for wrapping API responses

class Success {
  int? code;
  Object? response;
  Success({this.code, this.response});
  
}

class Failure {
  int? code;
  Object? errorResponse;
  Failure({this.code, this.errorResponse});
}


class ReturnError {
  int? code;
  Object? message;
  ReturnError({this.code, this.message});
}