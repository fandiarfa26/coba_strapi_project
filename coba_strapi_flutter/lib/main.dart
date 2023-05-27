import 'package:coba_strapi_flutter/src/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWithValue(AuthRepository(prefs))
    ],
    child: const MyApp(),
  ));
}
