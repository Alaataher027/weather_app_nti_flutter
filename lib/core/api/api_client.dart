import 'package:dio/dio.dart';
import 'package:weather_app_nti/core/api/api_constants.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Map<String, dynamic>> getWeather({required String endPoint}) async {
    var response = await _dio.get("${ApiConstants.baseUrl}$endPoint");
    return response.data;
  }

  Future<dynamic> getSearch({required String endPoint}) async {
    var response = await _dio.get("${ApiConstants.baseUrl}$endPoint");
    return response.data;
  }

}
