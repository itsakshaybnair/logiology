 import 'package:flutter/material.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';

void showSnackbar(final String message,final BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: context.setResponsiveSize(10, 8),
          child: Center(child: Text(message)),
        ),
      ),
    );
  }