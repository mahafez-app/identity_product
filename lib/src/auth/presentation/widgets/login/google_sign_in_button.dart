import 'package:mahafez_design_system/mahafez_design_system.dart';
import 'package:flutter/material.dart';
import 'package:identity_product/src/auth/presentation/identity_strings.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../identity_assets.dart';
import '../../providers/auth_controller.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = IdentityStrings.of(context);
    final theme = Theme.of(context);
    final authState = ref.watch(identityAuthControllerProvider);

    return MahafezButton(
      type: MahafezButtonType.secondary,
      label: l10n.continueWithGoogle,
      onPressed: () {
        ref.read(identityAuthControllerProvider.notifier).signInWithGoogle();
      },
      isLoading: authState.loadingMethod == IdentityLoadingMethod.google,
      foregroundColor: theme.colorScheme.onSurface,
      icon: SvgPicture.asset(IdentityAssets.googleIcon, width: 24, height: 24),
    );
  }
}
