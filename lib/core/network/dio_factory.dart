import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/app_prefs.dart';
import '../app/constants.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultlanguage = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    // String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      defaultlanguage: "en"
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      // receiveTimeout: Constants.apiTimeOut,
      // sendTimeout: Constants.apiTimeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    // if (!kReleaseMode) {
    //   dio.interceptors.add(dioLoggerInterceptor);
    // }

    return dio;
  }
}
