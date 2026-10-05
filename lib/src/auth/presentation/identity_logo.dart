import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahafez_design_system/mahafez_design_system.dart';

import 'identity_assets.dart';

final class IdentityLogo extends StatelessWidget {
  const IdentityLogo({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final logoSize = size ?? 140.responsiveWidth;
    return SvgPicture.asset(
      IdentityAssets.appLogo,
      width: logoSize,
      height: logoSize,
      fit: BoxFit.cover,
    );
  }
}
