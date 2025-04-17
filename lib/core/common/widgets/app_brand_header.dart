import 'package:flutter/material.dart';
import 'package:logiology/core/common/assets/app_fonts.dart';
import 'package:logiology/core/common/assets/app_images.dart';

class AppBrandHeader extends StatelessWidget {
  final double imageRadius;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;

  const AppBrandHeader({
    super.key,
    required this.imageRadius,
    required this.fontSize,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        CircleAvatar(
          radius: imageRadius,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(AppImages.logiology),
        ),
        SizedBox(width: imageRadius),
        Text(
          'Logiology',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.njalBold,
          ),
        ),
     
        
      ],
    );
  }
}
