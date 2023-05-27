import 'package:coba_strapi_flutter/src/api/failure.dart';
import 'package:coba_strapi_flutter/src/features/auth/application/auth_service.dart';
import 'package:coba_strapi_flutter/src/features/auth/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {}

  Future<bool> submitRegister(
      String name, String email, String password) async {
    state = const AsyncLoading();
    try {
      final service = ref.read(authServiceProvider);
      await service.register(name, email, password);
      ref.invalidate(getAuthUserProvider);
      state = const AsyncData(null);
      return true;
    } catch (e) {
      state = AsyncError((e as Failure).message, StackTrace.empty);
      return false;
    }
  }
}
