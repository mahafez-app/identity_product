import 'package:flutter/widgets.dart';

import 'identity_strings.dart';

abstract final class IdentityValidators {
  static String? email(BuildContext context, String? value) {
    final strings = IdentityStrings.of(context);
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return strings.validationError;
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(normalized)) {
      return strings.invalidEmail;
    }
    return null;
  }

  static String? password(BuildContext context, String? value) {
    if (value == null || value.length < 6) {
      return IdentityStrings.of(context).validationError;
    }
    return null;
  }

  static String? required(BuildContext context, String? value) =>
      value == null || value.trim().isEmpty
      ? IdentityStrings.of(context).validationError
      : null;
}
