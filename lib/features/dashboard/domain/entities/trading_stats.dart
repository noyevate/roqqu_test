 class TradingStats {
  final int proTraders;
  final int tradingDays;
  final int profitShare;
  final int totalOrders;
  final double averageLosses;
  final int totalCopyTrades;
  final List<String> tradingPairs;

  const TradingStats({
    required this.proTraders,
    required this.tradingDays,
    required this.profitShare,
    required this.totalOrders,
    required this.averageLosses,
    required this.totalCopyTrades,
    required this.tradingPairs,
  });
}