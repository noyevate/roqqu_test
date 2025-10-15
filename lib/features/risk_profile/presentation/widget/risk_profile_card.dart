import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class RiskProfileCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const RiskProfileCard({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color(0xFF2E3546), // Card background color
              border: Border.all(
                color: isSelected ? AppColors.accentBlue : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.displayLarge?.copyWith(fontSize: screenWidth * 0.045),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  description,
                  style: textTheme.bodyLarge?.copyWith(fontSize: screenWidth * 0.035),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  // shape: BoxShape.circle,
                  color: AppColors.accentBlue,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}