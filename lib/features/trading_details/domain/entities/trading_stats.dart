class TraderStats {
  final double averageRoi;
  final int winRates;
  final double totalProfit;
  final double averageLosses;
  final int totalTrades;
  final List<String> tradingPairs;

  const TraderStats({
    required this.averageRoi,
    required this.winRates,
    required this.totalProfit,
    required this.averageLosses,
    required this.totalTrades,
    required this.tradingPairs,
  });
}