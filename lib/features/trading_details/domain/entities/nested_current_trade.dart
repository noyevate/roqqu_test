class NestedCurrentTrade {
  final String pair;
  final String leverage;
  final double roi;
  final double entryPrice;
  final double marketPrice;
  final int copiers;
  final double copiersAmount;
  final String entryTime;

  const NestedCurrentTrade( { 
    required this.pair, required this.leverage, required this.roi, required this.entryPrice, required this.marketPrice, required this.copiers, required this.copiersAmount, required this.entryTime,
  });
}