//-----[ ApiResponse ]-----//

class ApiResponse {
  final int responseCode;
  final dynamic responseData;
  final bool isSuccess;
  final String ? errorMessage;


  ApiResponse({
    required this.responseData,
    required this.responseCode,
    required this.isSuccess,
    this.errorMessage,
});
}