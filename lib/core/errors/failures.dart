import 'package:dio/dio.dart';

abstract class Failures {
  final String errMessage;

  const Failures(this.errMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with ApiServer");

      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout with ApiServer");

      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout with ApiServer");

      case DioExceptionType.badCertificate:
        return ServerFailure("Timeout with ApiServer, Try again!");

      case DioExceptionType.badResponse:
        return ServerFailure.formResponce(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Timeout with ApiServer");

      case DioExceptionType.connectionError:
        return ServerFailure("Connection error, check your network!");

      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketException")) {
          return ServerFailure("No Internet Connection!");
        }
        return ServerFailure("Unexpected error, please Try again");
      }
  }

  factory ServerFailure.formResponce(int statesCode, dynamic response) {
    if (statesCode == 400 || statesCode == 401 || statesCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statesCode == 404) {
      return ServerFailure("Your requset not found, please try later!");
    } else if (statesCode == 500) {
      return ServerFailure("Internal server error, please try later!");
    } else {
      return ServerFailure("Opps, There is an error.");
    }
  }
}