class Coin {
  final String name;
  final String symbol;
  final String iconAsset;
  final double price;
  final double priceChangePercent;

  const Coin({
    required this.name,
    required this.symbol,
    required this.iconAsset,
    this.price = 0.0,
    this.priceChangePercent = 0.0,
  });
  
  // Helper method for updating with new data
  Coin copyWith({double? price, double? priceChangePercent}) {
    return Coin(
      name: name,
      symbol: symbol,
      iconAsset: iconAsset,
      price: price ?? this.price,
      priceChangePercent: priceChangePercent ?? this.priceChangePercent,
    );
  }
}