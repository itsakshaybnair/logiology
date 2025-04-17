import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/theme/app_colors.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final double? height;
  final Color color;
  final bool defaultColor;

  const SvgIcon({
    super.key,
    required this.icon,
    this.height,
    this.color = AppColors.whiteColor,
    this.defaultColor = false,
  });

  @override
  Widget build(BuildContext context) {
    
    return SvgPicture.asset(
      icon,
      height: height?? context.setResponsiveSize(6, 3),
      colorFilter: defaultColor
          ? null
          : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
