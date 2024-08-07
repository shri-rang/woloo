import 'package:dio/dio.dart';

import '../../main.dart';
import '../../utils/resources/string_manager.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.data["message"] ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unautorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    // var mContext = navigatorKey!.currentState!.context;
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unautorised:
        return Failure(ResponseCode.unautorised, ResponseMessage.unautorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unautorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.success; // success with no data (no content)
  static const String badRequest =
      AppStrings.strBadRequestError; // failure, API rejected request
  static const String unautorised =
      AppStrings.strUnauthorizedError; // failure, user is not authorised
  static const String forbidden =
      AppStrings.strForbiddenError; //  failure, API rejected request
  static const String internalServerError =
      AppStrings.strInternalServerError; // failure, crash in server side
  static const String notFound =
      AppStrings.strNotFoundError; // failure, crash in server side

  // local status code
  static const String connectTimeout = AppStrings.strTimeoutError;
  static const String cancel = AppStrings.strDefaultError;
  static const String receiveTimeout = AppStrings.strTimeoutError;
  static const String sendTimeout = AppStrings.strTimeoutError;
  static const String cacheError = AppStrings.strCacheError;
  static const String noInternetConnection = AppStrings.strNoInternetError;
  static const String DEFAULT = AppStrings.strDefaultError;
}

class ApiInternalStatus {
  static const int success = 200;
  static const int failure = 400;
}
