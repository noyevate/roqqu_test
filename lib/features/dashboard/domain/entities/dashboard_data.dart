import 'trade_history_item.dart';

class DashboardData {
  final double copyTradingAssets;
  final double netProfit;
  final double todaysPnl;
  final List<double> pnlChartData;
  final List<TradeHistoryItem> tradeHistory;

  const DashboardData({
    required this.copyTradingAssets,
    required this.netProfit,
    required this.todaysPnl,
    required this.pnlChartData,
    required this.tradeHistory,
  });
}