import 'package:coba_strapi_flutter/src/features/auth/presentation/controllers/register_controller.dart';
import 'package:coba_strapi_flutter/src/utils/async_value_ui.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final success =
          await ref.read(registerControllerProvider.notifier).submitRegister(
                _nameController.text,
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
      registerControllerProvider,
      (_, state) => state.showAlertOnError(context),
    );
    final state = ref.watch(registerControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              enabled: !state.isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Masukkan nama',
                labelText: 'Nama',
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
