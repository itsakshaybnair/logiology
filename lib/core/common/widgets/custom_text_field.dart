import 'package:flutter/material.dart';
import 'package:logiology/core/common/extensions/responsive_size.dart';
import 'package:logiology/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator; 

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField( 
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator, 
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.transparentColor,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.hintTextColor,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.all(context.setResponsiveSize(8, 6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.setResponsiveSize(8, 6)),
          borderSide: BorderSide(
            color: Colors.white,
            width: context.setResponsiveSize(.2, .3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.setResponsiveSize(8, 6)),
          borderSide: BorderSide(
            color: Colors.white,
            width: context.setResponsiveSize(.2, .3),
          ),
        ),
      ),
    );
  }
}
