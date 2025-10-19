import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.containerContent});

  final Widget containerContent;

  @override
  Widget build(BuildContext context) {
    final screenWidth =  MediaQuery.of(context).size.width;
    return SizedBox(
      
      height: MediaQuery.of(context).size.height * 0.8,
      width: screenWidth,
      
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
        ),
        child: Container(
          color: AppColors.darkBackground,
          width: screenWidth,
          child: SingleChildScrollView(
            child: containerContent,
          ),
        ),
      ),
    );
  }
}