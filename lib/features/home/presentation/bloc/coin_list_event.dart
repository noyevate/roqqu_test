abstract class CoinListEvent {}

class SubscribeToCoinTickers extends CoinListEvent {
  final List<String> symbols;
  SubscribeToCoinTickers(this.symbols);
}

class UnsubscribeFromCoinTickers extends CoinListEvent {}