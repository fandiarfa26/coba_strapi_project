import 'package:coba_strapi_flutter/src/features/auth/data/auth_repository.dart';
import 'package:coba_strapi_flutter/src/features/auth/presentation/controllers/logout_controller.dart';
import 'package:coba_strapi_flutter/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _logout() async {
    final success = await ref.read(logoutControllerProvider.notifier).logout();
    if (success && mounted) {
      //context.goNamed(AppRoute.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      logoutControllerProvider,
      (_, state) => state.showAlertOnError(context),
    );
    final state = ref.watch(logoutControllerProvider);

    final user = ref.watch(getAuthUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: user == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.username),
                  Text(user.email),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.isLoading ? null : _logout,
        label: state.isLoading
            ? const CircularProgressIndicator()
            : const Text('Keluar'),
        icon: const Icon(Icons.logout),
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
      ),
    );
  }
}
