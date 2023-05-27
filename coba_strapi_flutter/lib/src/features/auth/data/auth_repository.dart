import 'dart:convert';

import 'package:coba_strapi_flutter/src/features/auth/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final SharedPreferences prefs;
  AuthRepository(this.prefs);

  static const tokenKey = 'TOKEN_KEY';
  static const userKey = 'USER_KEY';

  String? get token => prefs.getString(tokenKey);

  UserModel? getUser() {
    String? user = prefs.getString(userKey);
    if (user != null) {
      return UserModel.fromJson(jsonDecode(user));
    }
    return null;
  }

  Future<void> saveData(UserResponse response) async {
    await prefs.setString(tokenKey, response.jwt);
    await prefs.setString(userKey, jsonEncode(response.user));
  }

  Future<void> removeData() async {
    await prefs.clear();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
String? getAuthToken(GetAuthTokenRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.token;
}

@Riverpod(keepAlive: true)
UserModel? getAuthUser(GetAuthUserRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getUser();
}
