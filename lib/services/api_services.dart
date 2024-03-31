import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:quick_eats/utils/utils.dart';

class ApiServices {
  static final Dio _dio = Dio();

  /// signup user mock api call
  static Future<Response> signUpUserApi(Map<String, dynamic> data) async {
    final response = await _dio.post(
      "$kBaseUrl/users",
      data: jsonEncode(data),
      options: Options(headers: {"Content-Type": "application/json"}),
    );
    return response;
  }

  /// signin user mock api call
  static Future<Response> signInUserApi() async {
    final response = await _dio.get(
      "$kBaseUrl/users",
      options: Options(headers: {"Content-Type": "application/json"}),
    );
    return response;
  }

  /// get all restaurants mock api call
  static Future<Response> getRestaurantsApi() async {
    final response = await _dio.get(
      "$kBaseUrl/restaurants",
      options: Options(headers: {"Content-Type": "application/json"}),
    );
    return response;
  }

  /// add user rating mock api
  static Future<Response> updateRatingApi(Map<String, dynamic> data) async {
    final response = await _dio.patch(
      "$kBaseUrl/restaurants",
      data: jsonEncode(data),
      options: Options(headers: {"Content-Type": "application/json"}),
    );
    return response;
  }
}
