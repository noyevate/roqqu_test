class TradeHistoryItem {
  final String pair;
  final String leverage;
  final double roi;
  final String proTrader;
  final double entryPrice;
  final double exitPrice;
  final double proTraderAmount;
  final String entryTime;
  final String exitTime;

  const TradeHistoryItem({
    required this.pair,
    required this.leverage,
    required this.roi,
    required this.proTrader,
    required this.entryPrice,
    required this.exitPrice,
    required this.proTraderAmount,
    required this.entryTime,
    required this.exitTime,
  });
}