import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56, // A standard, accessible button height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // We use the centralized colors we defined in AppColors
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryGradientStart,
            AppColors.primaryGradientEnd,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // We use the centralized text style we defined in our AppTheme
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}