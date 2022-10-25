import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    int _timeOut = 60 * 1000; // 1 minute

    Map<String, String> headers = {
      AppConstants.contentType: AppConstants.applicationJson,
      AppConstants.accept: AppConstants.applicationJson,
      AppConstants.authorization: AppConstants.authorizationToken,
      AppConstants.defaultLanguage: AppConstants.englishLanguage
    };

    dio.options = BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        headers: headers);

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    } // No logs for release mode

    return dio;
  }
}
