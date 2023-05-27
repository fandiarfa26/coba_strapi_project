import 'package:coba_strapi_flutter/src/features/auth/data/auth_repository.dart';
import 'package:coba_strapi_flutter/src/features/auth/data/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  final Ref ref;
  AuthService(this.ref);

  Future<void> login(String email, String password) async {
    final cancelToken = CancelToken();
    ref.onDispose(() {
      debugPrint('[Auth] Service: Cancel Login');
      cancelToken.cancel();
    });
    final userRepo = ref.watch(userRepositoryProvider);
    final response =
        await userRepo.login(email, password, cancelToken: cancelToken);
    await ref.read(authRepositoryProvider).saveData(response);
  }

  Future<void> register(String name, String email, String password) async {
    final cancelToken = CancelToken();
    ref.onDispose(() {
      debugPrint('[Auth] Service: Cancel Register');
      cancelToken.cancel();
    });
    final userRepo = ref.watch(userRepositoryProvider);
    final response = await userRepo.register(name, email, password,
        cancelToken: cancelToken);
    await ref.read(authRepositoryProvider).saveData(response);
  }
}

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref);
}
