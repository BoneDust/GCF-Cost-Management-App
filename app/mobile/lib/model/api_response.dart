class ApiResponse {
  String error;
  String success;
  var object;
  bool hasError = false;

  bool isSuccess = false;

  int code;

  ApiResponse.withError(this.error, this.code, {this.object}){
    hasError = true;
  }

  ApiResponse.isSuccess(this.success, this.code, {this.object}){
    isSuccess = true;
  }
}