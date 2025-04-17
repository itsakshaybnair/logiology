import 'package:flutter/material.dart';

  extension ResponsiveSizeX on BuildContext {
  
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;


  double setResponsiveSize(double forMob, double forTab) {
    if (screenWidth > 600) {
    return (forTab / 100) * screenWidth;
    } else {
      return (forMob / 100) * screenWidth;
    }
  }
}