import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class ProgressIndicatorBar extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const ProgressIndicatorBar({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Expanded(
          child: index == 1 ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 4.0,
            decoration: BoxDecoration(
              color: index == currentPage ? AppColors.accentBlue : Colors.grey[800],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ) : Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 4.0,
            decoration: BoxDecoration(
              color: AppColors.accentBlue,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ) ,
        ),
      ),
    );
  }
}