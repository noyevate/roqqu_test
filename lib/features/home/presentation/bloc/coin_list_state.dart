import 'package:roqqu_test/features/home/domain/entities/coin.dart';

abstract class CoinListState {}

class CoinListInitial extends CoinListState {}

class CoinListLoading extends CoinListState {}

class CoinListLoaded extends CoinListState {
  final Map<String, Coin> coins; 
  CoinListLoaded(this.coins);
}

class CoinListError extends CoinListState {
  final String message;
  CoinListError(this.message);
}