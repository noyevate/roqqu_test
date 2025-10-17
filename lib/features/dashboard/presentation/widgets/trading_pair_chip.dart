import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class TradingPairChip extends StatelessWidget {
  final String pair;
  const TradingPairChip({super.key, required this.pair});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.tertiaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(pair),
    );
  }
}