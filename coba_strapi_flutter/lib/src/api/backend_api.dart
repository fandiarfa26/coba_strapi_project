import 'package:coba_strapi_flutter/src/api/failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backendApiProvider = Provider((ref) => BackendAPI());

class BackendAPI {
  Uri _buildUri({required String endpoint, Map<String, String>? params}) {
    return Uri(
      scheme: 'http',
      host: 'localhost',
      port: 1337,
      path: '/api$endpoint',
      queryParameters: params,
    );
  }

  Future<T> callReturn<T>({
    required Future<Response> Function() request,
    required T Function(dynamic) parse,
  }) async {
    try {
      final response = await request();
      return parse(response.data);
    } on DioError catch (e) {
      Response? res = e.response;
      if (res != null) {
        throw Failure.fromJson(res.data['error']);
      } else {
        throw Failure(message: e.message ?? 'unknown');
      }
    }
  }

  Uri get loginUrl => _buildUri(endpoint: '/auth/local');
  Uri get registerUrl => _buildUri(endpoint: '/auth/local/register');
}
