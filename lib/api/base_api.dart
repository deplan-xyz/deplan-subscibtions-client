import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseApi {
  // final baseUrl = 'http://localhost:9898';
  final baseUrl = 'https://phorevr-09ba19e6f8ae.herokuapp.com';
  late final Dio _dioClient;
  BaseApi() {
    _dioClient = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        followRedirects: true,
      ),
    );
  }

  @protected
  Dio get client {
    return _dioClient;
  }

  @protected
  getRequest(String path,
      {Map<String, dynamic> queryParameters = const {}}) async {
    final headers = await this.headers;
    try {
      return await client.get(path,
          queryParameters: queryParameters, options: Options(headers: headers));
    } on DioException catch (e) {
      return e.response;
    }
  }

  @protected
  postRequest(String path, {Map<String, dynamic> body = const {}}) async {
    final headers = await this.headers;
    try {
      return await client.post(path,
          data: body, options: Options(headers: headers));
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Map<String, String>> get headers async {
    return await _getHeaders();
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await Auth.authToken;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
