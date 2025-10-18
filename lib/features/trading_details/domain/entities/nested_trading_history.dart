class NestedTradeHistory {
  final String pair;
  final String leverage;
  final double roi;
  final double entryPrice;
  final double exitPrice;
  final int copiers;
  final double copiersAmount;
  final String entryTime;
  final String exitTime; 
  const NestedTradeHistory( { 
    required this.pair, required this.leverage, required this.roi, required this.entryPrice, required this.exitPrice, required this.copiers, required this.copiersAmount, required this.entryTime, required this.exitTime,
   });
}