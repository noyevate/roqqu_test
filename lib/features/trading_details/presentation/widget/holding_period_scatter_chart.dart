import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HoldingPeriodScatterChart extends StatelessWidget {
  const HoldingPeriodScatterChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for profit and loss points
    final List<ScatterSpot> spots = [
      ScatterSpot(
        1,
        1,
        dotPainter: FlDotCirclePainter(radius: 6, color: Colors.green),
      ),
      ScatterSpot(
        1.5,
        1,
        dotPainter: FlDotCirclePainter(radius: 5, color: Colors.green),
      ),
      ScatterSpot(
        2,
        1,
        dotPainter: FlDotCirclePainter(radius: 4, color: Colors.green),
      ),
      ScatterSpot(
        3.5,
        1,
        dotPainter: FlDotCirclePainter(radius: 7, color: Colors.green),
      ),
      ScatterSpot(
        4,
        1,
        dotPainter: FlDotCirclePainter(radius: 5, color: Colors.green),
      ),
      ScatterSpot(
        2.5,
        0,
        dotPainter: FlDotCirclePainter(radius: 5, color: Colors.red),
      ),
    ];


    return ScatterChart(
      ScatterChartData(
        scatterSpots: spots,
        minX: 0,
        maxX: 5,
        minY: -0.5,
        maxY: 1.5,

        
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.white.withOpacity(0.1), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                String text = '';
                if (value.toInt() == 0 || value.toInt() == 1) {
                  text = '64k';
                }
                return Text(text, style: const TextStyle(fontSize: 12));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                String text = '';
                switch (value.toInt()) {
                  case 1:
                    text = '1m';
                    break;
                  case 2:
                    text = '24h';
                    break;
                  case 3:
                    text = '5d';
                    break;
                  case 4:
                    text = '15d';
                    break;
                }
                return Text(text, style: const TextStyle(fontSize: 12));
              },
            ),
          ),
        ),
      ),
    );
  }
}
