import 'package:flutter/material.dart';
import 'package:roqqu_test/features/copy_trading/domain/entities/pro_trader.dart';

class TraderDetails {
  final ProTrader trader; 
  final int tradingDays;
  final int profitShare;
  final int totalOrders;
  final List<double> roiChartData; 
  final List<double> pnlChartData;

  const TraderDetails({
    required this.trader,
    required this.tradingDays,
    required this.profitShare,
    required this.totalOrders,
    required this.roiChartData,
    required this.pnlChartData,
  });
}