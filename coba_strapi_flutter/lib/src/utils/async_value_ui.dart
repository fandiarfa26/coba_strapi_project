import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'show_snackbar.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = error.toString();
      showSnackbar(context, message);
    }
  }
}
