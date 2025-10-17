import 'package:roqqu_test/features/dashboard/domain/entities/current_trade_item.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/trading_stats.dart';

import 'trade_history_item.dart';

class DashboardData {
  final double copyTradingAssets;
  final double netProfit;
  final double todaysPnl;
  final List<double> pnlChartData;
  final List<TradeHistoryItem> tradeHistory;
  final List<CurrentTradeItem> currentTrades;
  final TradingStats stats;
  

  const DashboardData({
    required this.copyTradingAssets,
    required this.netProfit,
    required this.todaysPnl,
    required this.pnlChartData,
    required this.tradeHistory,
    required this.currentTrades,
    required this.stats,
  });
}