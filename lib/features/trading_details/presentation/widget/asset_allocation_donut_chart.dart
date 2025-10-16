import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/trading_details/presentation/widget/custom_radial_chart_painter.dart';

class AssetsAllocationDonutChart extends StatelessWidget {
  const AssetsAllocationDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final radius = screenWidth * 0.2; 


    return SizedBox(
      height: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.infinite, 
            painter: CustomRadialChartPainter(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BTCUSDT',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: radius * 0.25, 
                ),
              ),
              Text(
                '100.00%',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: radius * 0.2, 
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}