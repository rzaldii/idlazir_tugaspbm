import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  final TextEditingController controller;

  final IconData prefixIcon;

  final TextInputType? keyboardType;

  final bool obscureText;

  final IconData? suffixIcon;

  final VoidCallback? onSuffixTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,

    this.keyboardType,

    this.obscureText = false,

    this.suffixIcon,

    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,

      obscureText: obscureText,

      cursorColor: AppColors.primary,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: Icon(prefixIcon),

        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onSuffixTap, icon: Icon(suffixIcon))
            : null,

        filled: true,

        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.15),

            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
