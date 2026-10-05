// ignore_for_file: unused_element_parameter

import 'package:mahafez_design_system/mahafez_design_system.dart';
import 'package:flutter/material.dart';
import 'package:identity_product/src/auth/presentation/identity_strings.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../identity_logo.dart';
import '../providers/auth_controller.dart';
import '../widgets/sign_up/sign_up_form.dart';

class IdentitySignUpScreen extends StatelessWidget {
  const IdentitySignUpScreen({super.key, this.onSignIn});

  final VoidCallback? onSignIn;

  @override
  Widget build(BuildContext context) {
    final l10n = IdentityStrings.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const IdentityLogo(size: 32),
            MahafezSpacing.sm.horizontalSpace,
            Text(
              l10n.appName,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: MahafezResponsive.symmetricPadding(
            horizontal: MahafezSpacing.lg,
            vertical: MahafezSpacing.xl,
          ),
          child: _SignUpBody(onSignIn: onSignIn),
        ),
      ),
    );
  }
}

class _SignUpBody extends ConsumerWidget {
  const _SignUpBody({super.key, this.onSignIn});

  final VoidCallback? onSignIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<IdentityAuthState>(identityAuthControllerProvider, (_, next) {
      if (!next.isLoading && next.error != null) {
        MahafezSnackbar.showFailure(context, failure: next.error!);
        ref.read(identityAuthControllerProvider.notifier).clearError();
      }
    });

    final l10n = IdentityStrings.of(context);
    final theme = Theme.of(context);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MahafezSpacing.lg.verticalSpace,

          // Titles
          Text(
            l10n.createAccount,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          MahafezSpacing.sm.verticalSpace,
          Text(
            l10n.signUpSubtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          MahafezSpacing.xxxl.verticalSpace,

          // Form
          const SignUpForm(),

          MahafezSpacing.xxl.verticalSpace,

          // Sign In Link
          _SignInPrompt(onPressed: onSignIn),
        ],
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = IdentityStrings.of(context);
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.alreadyHaveAccount,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        MahafezSpacing.xs.horizontalSpace,
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(MahafezSpacing.sm),
          child: Padding(
            padding: MahafezResponsive.symmetricPadding(
              horizontal: MahafezSpacing.xs,
              vertical: MahafezSpacing.xs,
            ),
            child: Text(
              l10n.signIn,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
