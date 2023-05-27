import 'package:coba_strapi_flutter/src/features/auth/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_controller.g.dart';

@riverpod
class LogoutController extends _$LogoutController {
  @override
  FutureOr<void> build() {}

  Future<bool> logout() async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).removeData();
      ref.invalidate(getAuthUserProvider);
      state = const AsyncData(null);
      return true;
    } catch (e) {
      state = AsyncError(e, StackTrace.empty);
      return false;
    }
  }
}
