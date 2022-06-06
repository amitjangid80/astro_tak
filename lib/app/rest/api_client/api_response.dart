// Created By Amit Jangid on 05/06/22

class ApiResponse<T> {
  bool isSuccess;
  T responseBody;

  ApiResponse({required this.isSuccess, required this.responseBody});
}
