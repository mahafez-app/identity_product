import 'package:mahafez_design_system/mahafez_design_system.dart';
import 'package:flutter/material.dart';
import 'package:identity_product/src/auth/presentation/identity_strings.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../identity_validators.dart';
import '../../providers/auth_controller.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      // Navigation is handled via GoRouter redirect listening to authStateChangesProvider.
      ref
          .read(identityAuthControllerProvider.notifier)
          .signInWithEmailPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = IdentityStrings.of(context);
    final authState = ref.watch(identityAuthControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MahafezTextField(
            label: l10n.email,
            hintText: l10n.emailPlaceholder,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => IdentityValidators.email(context, value),
          ),
          MahafezSpacing.lg.verticalSpace,
          MahafezTextField(
            label: l10n.password,
            hintText: '••••••',
            controller: _passwordController,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            validator: (value) => IdentityValidators.required(context, value),
          ),
          MahafezSpacing.xl.verticalSpace,
          MahafezButton(
            label: l10n.signIn,
            onPressed: _submit,
            isLoading: authState.loadingMethod == IdentityLoadingMethod.email,
          ),
        ],
      ),
    );
  }
}
