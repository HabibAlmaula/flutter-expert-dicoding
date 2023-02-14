import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

String dioErr({required DioError error, String? message}) {
  String errorMessage = '';
  switch (error.type) {
    case DioErrorType.connectTimeout:
      errorMessage = "Connection timeout";
      break;
    case DioErrorType.sendTimeout:
      errorMessage = "Receive timeout in send request";
      break;
    case DioErrorType.receiveTimeout:
      errorMessage = "Receive timeout in connection";
      break;
    case DioErrorType.response:
      List<int> err = [400, 401, 403, 404];
      if (err.contains(error.response?.statusCode)) {
        errorMessage = message ??
            "${error.response?.data["message"]} code:${error.response?.statusCode}";
      } else if (error.response?.statusCode == 500) {
        errorMessage = "unknown server error";
      }
      break;
    case DioErrorType.cancel:
      errorMessage = "Request was cancelled";
      break;
    case DioErrorType.other:
      errorMessage = "Connection failed due to internet connection";
      break;
  }

  return errorMessage;
}
