import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';

class CustomNavBar1 extends StatelessWidget {
  const CustomNavBar1({super.key, required this.onPressed, this.text});
  final void Function() onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        color: AppColors.bottomContainerBackground,
        padding: EdgeInsets.only(
          left: screenWidth * 0.06,
          right: screenWidth * 0.06,
          top: 20,
          bottom: MediaQuery.of(context).viewPadding.bottom + 10,
        ),
        child: GradientButton(
          text: text ?? 'Proceed' ,
          onPressed: onPressed,
        ),
      );
  }
}

