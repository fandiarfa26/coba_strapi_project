import 'package:coba_strapi_flutter/src/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/home_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';

enum AppRoute {
  login,
  register,
  home,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authUser = ref.watch(getAuthUserProvider);
  return GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      if (authUser != null) {
        if (state.matchedLocation.startsWith('/login')) {
          debugPrint('Redirect Home');
          return '/home';
        }
      } else {
        if (!state.matchedLocation.startsWith('/login')) {
          debugPrint('Redirect Login');
          return '/login';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
        routes: [
          GoRoute(
            path: 'register',
            name: AppRoute.register.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const RegisterScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
    ],
  );
});
