import 'package:mahafez_design_system/mahafez_design_system.dart';
import 'package:flutter/material.dart';
import 'package:identity_product/src/auth/presentation/identity_strings.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../identity_validators.dart';
import '../../providers/auth_controller.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(identityAuthControllerProvider.notifier)
          .signUpWithEmailPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
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
            label: l10n.fullName,
            hintText: l10n.fullNamePlaceholder,
            controller: _nameController,
            keyboardType: TextInputType.name,
            validator: (value) => IdentityValidators.required(context, value),
          ),
          MahafezSpacing.xl.verticalSpace,
          MahafezTextField(
            label: l10n.email,
            hintText: l10n.emailPlaceholder,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => IdentityValidators.email(context, value),
          ),
          MahafezSpacing.xl.verticalSpace,
          MahafezTextField(
            label: l10n.password,
            hintText: l10n.passwordPlaceholder,
            controller: _passwordController,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            validator: (value) => IdentityValidators.password(context, value),
          ),
          32.verticalSpace,
          MahafezButton(
            label: l10n.createAccount,
            onPressed: _submit,
            isLoading: authState.loadingMethod == IdentityLoadingMethod.email,
          ),
        ],
      ),
    );
  }
}
