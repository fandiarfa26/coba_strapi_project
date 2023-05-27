import 'package:coba_strapi_flutter/src/api/backend_api.dart';
import 'package:coba_strapi_flutter/src/api/client.dart';
import 'package:coba_strapi_flutter/src/features/auth/domain/user.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {
  final BackendAPI api;
  final Dio client;
  UserRepository({required this.api, required this.client});

  Future<UserResponse> login(
    String email,
    String password, {
    CancelToken? cancelToken,
  }) {
    return api.callReturn<UserResponse>(
      request: () => client.postUri(
        api.loginUrl,
        data: {
          "identifier": email,
          "password": password,
        },
        cancelToken: cancelToken,
      ),
      parse: (data) => UserResponse.fromJson(data),
    );
  }

  Future<UserResponse> register(
    String name,
    String email,
    String password, {
    CancelToken? cancelToken,
  }) {
    return api.callReturn<UserResponse>(
      request: () => client.postUri(
        api.registerUrl,
        data: {
          'username': name,
          'email': email,
          'password': password,
        },
        cancelToken: cancelToken,
      ),
      parse: (data) => UserResponse.fromJson(data),
    );
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(
    api: ref.watch(backendApiProvider),
    client: ref.watch(clientProvider),
  );
}
