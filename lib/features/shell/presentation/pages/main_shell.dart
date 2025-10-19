import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:roqqu_test/features/home/presentation/widget/action_sheet.dart';
import 'package:roqqu_test/features/shell/presentation/pages/custom_bottom_navr_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        bottomNavigationBar: const CustomBottomNavBar(),
        body: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: screenWidth * 0.05, top: screenWidth * 0.3,),
          child: ActionSheet(),
        ),
      ),
    );
  }
}