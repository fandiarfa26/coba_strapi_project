import 'package:coba_strapi_flutter/src/features/auth/presentation/controllers/login_controller.dart';
import 'package:coba_strapi_flutter/src/utils/async_value_ui.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/app_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final success =
          await ref.read(loginControllerProvider.notifier).submitLogin(
                _emailController.text,
                _passController.text,
              );
      if (success && mounted) {
        //context.goNamed(AppRoute.home.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      loginControllerProvider,
      (_, state) => state.showAlertOnError(context),
    );
    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _emailController,
              enabled: !state.isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong!';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Email tidak valid!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Masukkan email',
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _passController,
              enabled: !state.isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong!';
                }
                return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Masukkan password',
                labelText: 'Password',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              child: FilledButton(
                onPressed: state.isLoading ? null : _submit,
                child: Text(state.isLoading ? 'Loading...' : 'Submit'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        context.goNamed(AppRoute.register.name);
                      },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
