import 'package:flutter/material.dart';
import 'package:roqqu_test/features/copy_trading/domain/entities/pro_trader.dart';
import 'package:roqqu_test/features/trading_details/domain/entities/trading_stats.dart';

class TraderDetails {
  final ProTrader trader; 
  final int tradingDays;
  final int profitShare;
  final int totalOrders;
  final List<double> roiChartData; 
  final List<double> pnlChartData;
  final TraderStats stats;

  const TraderDetails({
    required this.trader,
    required this.tradingDays,
    required this.profitShare,
    required this.totalOrders,
    required this.roiChartData,
    required this.pnlChartData,
    required this.stats,
  });
}