import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqqu_test/features/home/data/repositories/coin_repository_impl.dart';
import 'package:roqqu_test/features/home/domain/entities/coin.dart';
import 'coin_list_event.dart';
import 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final CoinRepository _coinRepository;

  CoinListBloc(this._coinRepository) : super(CoinListInitial()) {
    on<SubscribeToCoinTickers>(_onSubscribe);
    on<UnsubscribeFromCoinTickers>(_onUnsubscribe);
  }

  Future<void> _onSubscribe(
    SubscribeToCoinTickers event,
    Emitter<CoinListState> emit,
  ) async {
    emit(CoinListLoading());

    try {
      final initialData = await _coinRepository.getInitialCoinData(event.symbols);
      
      final initialMap = {for (var coin in initialData) coin.symbol: coin};
      
      emit(CoinListLoaded(initialMap));

      
      await emit.forEach<Coin>(
        _coinRepository.getCoinTickerStream(event.symbols),
        onData: (priceUpdate) {
          final currentState = state;
          
          if (currentState is CoinListLoaded) {
            final updatedCoins = Map<String, Coin>.from(currentState.coins);
            
            if (updatedCoins.containsKey(priceUpdate.symbol)) {
              
              updatedCoins[priceUpdate.symbol] = updatedCoins[priceUpdate.symbol]!.copyWith(
                price: priceUpdate.price,
              );

              return CoinListLoaded(updatedCoins);
            }
          }
          return currentState; 
        },
        onError: (error, stackTrace) {
         
          print("Error on WebSocket stream: $error");
          return state; 
        },
      );

    } catch (e) {
      emit(CoinListError(e.toString()));
    }
  }

  void _onUnsubscribe(UnsubscribeFromCoinTickers event, Emitter<CoinListState> emit) {
    _coinRepository.closeStream();
  }

  @override
  Future<void> close() {
    _coinRepository.closeStream();
    return super.close();
  }
}