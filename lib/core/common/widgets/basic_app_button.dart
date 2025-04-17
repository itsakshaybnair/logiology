import 'package:flutter/material.dart';
import 'package:logiology/core/common/assets/app_fonts.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? fontSize;
  final Color? textColor;
  const BasicAppButton(
      {required this.onPressed,
      required this.title,
      this.height,
      super.key,
      this.fontSize,  
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          minimumSize:
              Size.fromHeight(height ?? context.setResponsiveSize(22, 16)),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(context.setResponsiveSize(8, 6)),
          ),
        ),
        child: Text(title,
            style: TextStyle(
                fontSize: fontSize ?? context.setResponsiveSize(4.5, 4),
                color: textColor?? AppColors.blueColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.outfitMedium)));
  }
}
