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
}
