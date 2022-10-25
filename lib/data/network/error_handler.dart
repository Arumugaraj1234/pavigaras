import 'package:dio/dio.dart';
import 'package:pavigaras/app/enumerations.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return RemoteDataResponseStatus.connectTimedOut.failure();
      case DioErrorType.sendTimeout:
        return RemoteDataResponseStatus.sendTimedOut.failure();
      case DioErrorType.receiveTimeout:
        return RemoteDataResponseStatus.receiveTimedOut.failure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return RemoteDataResponseStatus.badRequest.failure();
          case ResponseCode.forbidden:
            return RemoteDataResponseStatus.forbidden.failure();
          case ResponseCode.unauthorized:
            return RemoteDataResponseStatus.unauthorized.failure();
          case ResponseCode.notFound:
            return RemoteDataResponseStatus.notFound.failure();
          case ResponseCode.internalServerError:
            return RemoteDataResponseStatus.internalServerError.failure();
          default:
            return RemoteDataResponseStatus.defaultStatus.failure();
        }
      case DioErrorType.cancel:
        return RemoteDataResponseStatus.cancelled.failure();
      case DioErrorType.other:
        return RemoteDataResponseStatus.defaultStatus.failure();
    }
  }
}

class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

class ResponseCode {
  // API status code
  static const int success = 200; // Success with data
  static const int noContent = 201; // Success wih no data
  static const int badRequest = 400; //failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorized = 401; // failure, user not authorized
  static const int notFound = 404; //api url is not correct or not found
  static const int internalServerError = 500; // Crash happened in server

  //local status code
  static const int defaultStatus = -1;
  static const int connectTimedOut = -2;
  static const int cancelled = -3;
  static const int receiveTimedOut = -4;
  static const int sendTimedOut = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  //API status code
  static const String success = "Success"; // Success with data
  static const String noContent =
      "Success with no content"; // Success wih no data
  static const String badRequest =
      "Bad request, Please try again later"; //failure, api rejected the request
  static const String forbidden =
      "Forbidden request, Please try again later"; // failure, api rejected the request
  static const String unauthorized =
      "User is unauthorized, Please try again later"; // failure, user not authorized
  static const String notFound =
      "Url is not found, Please try again later"; //api url is not correct or not found
  static const String internalServerError =
      "Something went wrong. Please try again later"; // Crash happened in server

  //local status code
  static const String defaultStatus =
      "Something went wrong. Please try again later";
  static const String connectTimedOut = "Timeout error, Please try again later";
  static const String cancelled =
      "Request was cancelled, Please try again later";
  static const String receiveTimedOut = "Timeout error, Please try again later";
  static const String sendTimedOut = "Timeout error, Please try again later";
  static const String cacheError = "Cache error, Please try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
}

class AppInternalStatus {
  static const int success = 1;
  static const int failed = 0;
}

class DefaultFailure extends Failure {
  DefaultFailure()
      : super(ResponseCode.defaultStatus, ResponseMessage.defaultStatus);
}

extension RemoteDataResponseStatusExtention on RemoteDataResponseStatus {
  Failure failure() {
    switch (this) {
      case RemoteDataResponseStatus.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case RemoteDataResponseStatus.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case RemoteDataResponseStatus.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case RemoteDataResponseStatus.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case RemoteDataResponseStatus.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case RemoteDataResponseStatus.connectTimedOut:
        return Failure(
            ResponseCode.connectTimedOut, ResponseMessage.connectTimedOut);
      case RemoteDataResponseStatus.cancelled:
        return Failure(ResponseCode.cancelled, ResponseMessage.cancelled);
      case RemoteDataResponseStatus.receiveTimedOut:
        return Failure(
            ResponseCode.receiveTimedOut, ResponseMessage.receiveTimedOut);
      case RemoteDataResponseStatus.sendTimedOut:
        return Failure(ResponseCode.sendTimedOut, ResponseMessage.sendTimedOut);
      case RemoteDataResponseStatus.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case RemoteDataResponseStatus.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      default:
        return Failure(
            ResponseCode.defaultStatus, ResponseMessage.defaultStatus);
    }
  }
}
