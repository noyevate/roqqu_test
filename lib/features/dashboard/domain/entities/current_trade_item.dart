class CurrentTradeItem {
  final String pair;
  final String leverage;
  final double roi;
  final String proTrader;
  final double entryPrice;
  final double marketPrice; 
  final String entryTime;

  const CurrentTradeItem({
    required this.pair,
    required this.leverage,
    required this.roi,
    required this.proTrader,
    required this.entryPrice,
    required this.marketPrice,
    required this.entryTime,
  });
}