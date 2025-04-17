
import 'package:flutter/material.dart';
import 'package:logiology/core/common/assets/app_fonts.dart';
import 'package:logiology/core/theme/app_colors.dart';

class AppTheme {
 static final darkThememode = ThemeData(
    primaryColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.dark,
           fontFamily: AppFonts.outfitMedium,
           appBarTheme: AppBarTheme(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
           )

  
  );
}
