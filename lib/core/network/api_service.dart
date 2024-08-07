import 'package:dio/dio.dart';

import '../app/constants.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Response> get({String? endPoint, dynamic data, dynamic params}) async {
    print("end $endPoint");
    print("date $data");
    print("param $params");
    var response = await dio.get('${Constants.baseUrl}$endPoint',
        data: data, queryParameters: params);
    return response;
  }

  Future<Response> post(
      {required String endPoint, dynamic data, dynamic params}) async {
    var response = await dio.post('${Constants.baseUrl}$endPoint',
        data: data, queryParameters: params);
    return response;
  }

  Future<Response> put({required String endPoint}) async {
    var response = await dio.put('${Constants.baseUrl}$endPoint');
    return response;
  }

  Future<Response> delete({required String endPoint}) async {
    var response = await dio.delete('${Constants.baseUrl}$endPoint');
    return response;
  }
}
