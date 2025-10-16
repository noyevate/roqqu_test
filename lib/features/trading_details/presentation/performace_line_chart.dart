import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math'; 

typedef YAxisLabelFormatter = String Function(double value);

class PerformanceLineChart extends StatelessWidget {
  final List<double> data;
  final YAxisLabelFormatter yAxisLabelFormatter;
  final Color chartColor;
  final Color? chartBackgroundColor;
  final bool showGrid;
  final double fillOvershoot;

  const PerformanceLineChart({
    super.key,
    required this.data,
    required this.yAxisLabelFormatter,
    this.chartColor = const Color(0xFF00C853),
    this.chartBackgroundColor,
    this.showGrid = true,
    this.fillOvershoot = 0.0, t
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data to display"));
    }

    final mainSpots = data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();

    final fillSpots = mainSpots.map((spot) => FlSpot(spot.x, spot.y + fillOvershoot)).toList();

    final double minY = data.reduce(min);
    final double maxY = fillSpots.map((spot) => spot.y).reduce(max);
    
    final interval = (maxY - minY) > 0 ? (maxY - minY) / 4 : 1;

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,

        backgroundColor: chartBackgroundColor,
        borderData: FlBorderData(show: false),

        gridData: showGrid
            ? FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: interval.truncateToDouble(),
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.white.withOpacity(0.05),
                  strokeWidth: 1,
                ),
              )
            : const FlGridData(show: false),

        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: interval.toDouble(),
              getTitlesWidget: (value, meta) {
                if (value >= data.reduce(max) || value == meta.min) {
                  return const SizedBox.shrink();
                }
                final String labelText = yAxisLabelFormatter(value);
                return Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(labelText, style: const TextStyle(fontSize: 12)),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
             sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: (mainSpots.length / 5).floor().toDouble(), // Show ~5 labels
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= data.length) return const SizedBox.shrink();
                final date = DateTime(2024, 3, 23).add(Duration(days: value.toInt()));
                final text = '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                return Text(text, style: const TextStyle(fontSize: 12));
              },
            ),
          ),
        ),

        lineBarsData: [
          LineChartBarData(
            spots: fillSpots,
            barWidth: 0, // Invisible line
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: chartColor.withOpacity(0.1),
            ),
          ),
          
          LineChartBarData(
            spots: mainSpots,
            isCurved: false,
            barWidth: 6.0,
            color: chartColor.withOpacity(0.2),
            dotData: const FlDotData(show: false),
          ),

          LineChartBarData(
            spots: mainSpots,
            isCurved: false,
            barWidth: 2.5,
            color: chartColor,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
