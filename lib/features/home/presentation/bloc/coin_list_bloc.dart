import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqqu_test/features/home/data/repositories/coin_repository_impl.dart';
import 'package:roqqu_test/features/home/domain/entities/coin.dart';
import 'coin_list_event.dart';
import 'coin_list_state.dart';


// class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
//   final CoinRepository _coinRepository;
  
//   // This map holds our initial data and will be updated.
//   final Map<String, Coin> _initialCoins = {
//     'BTC': const Coin(name: 'Bitcoin', symbol: 'BTC', iconAsset: 'assets/images/bitcoin_icon.svg'),
//     'ETH': const Coin(name: 'Ethereum', symbol: 'ETH', iconAsset: 'assets/images/etherum_icon.svg'),
//     'BNB': const Coin(name: 'BNB', symbol: 'BNB', iconAsset: 'assets/images/etherum_icon.svg'),
//     'XRP': const Coin(name: 'XRP', symbol: 'XRP', iconAsset: 'assets/images/etherum_icon.svg'),
//   };

//   CoinListBloc(this._coinRepository) : super(CoinListInitial()) {
//     on<SubscribeToCoinTickers>(_onSubscribe);
//     on<UnsubscribeFromCoinTickers>(_onUnsubscribe);
//   }

//   // --- THIS IS THE CORRECTED METHOD ---
//   Future<void> _onSubscribe(
//     SubscribeToCoinTickers event,
//     Emitter<CoinListState> emit,
//   ) async {
//     // Immediately emit the initial list with 0 values
//     emit(CoinListLoaded(Map.from(_initialCoins)));

//     // Use emit.forEach to handle the stream correctly.
//     // This keeps the event handler alive.
//     await emit.forEach<Coin>(
//       _coinRepository.getCoinTickerStream(event.symbols),
//       onData: (coinUpdate) {
//         // Get the current state's coin map
//         final currentState = state;
//         if (currentState is CoinListLoaded) {
//           final updatedCoins = Map<String, Coin>.from(currentState.coins);
          
//           // Find the coin to update and apply new data using copyWith
//           if (updatedCoins.containsKey(coinUpdate.symbol)) {
//             updatedCoins[coinUpdate.symbol] = updatedCoins[coinUpdate.symbol]!.copyWith(
//               price: coinUpdate.price,
//               priceChangePercent: coinUpdate.priceChangePercent,
//             );
//             // Return the new state to be emitted by emit.forEach
//             return CoinListLoaded(updatedCoins);
//           }
//         }
//         // If state is not loaded, just return the current state
//         return currentState; 
//       },
//       onError: (error, stackTrace) => CoinListError(error.toString()),
//     );
//   }

//   void _onUnsubscribe(UnsubscribeFromCoinTickers event, Emitter<CoinListState> emit) {
//     _coinRepository.closeStream();
//     // No need to emit here, the stream will just close.
//   }

//   @override
//   Future<void> close() {
//     _coinRepository.closeStream();
//     return super.close();
//   }
// }



class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final CoinRepository _coinRepository;

  // We no longer need a hardcoded _initialCoins map here.
  // The data will come from the repository.

  CoinListBloc(this._coinRepository) : super(CoinListInitial()) {
    on<SubscribeToCoinTickers>(_onSubscribe);
    on<UnsubscribeFromCoinTickers>(_onUnsubscribe);
  }

  // --- THIS IS THE FULLY REFACTORED AND CORRECTED METHOD ---
  Future<void> _onSubscribe(
    SubscribeToCoinTickers event,
    Emitter<CoinListState> emit,
  ) async {
    // 1. Emit a loading state to show a spinner in the UI.
    emit(CoinListLoading());

    try {
      // 2. Call the repository to fetch the COMPLETE initial data via HTTP.
      final initialData = await _coinRepository.getInitialCoinData(event.symbols);
      
      // Create the initial map of coins from the data we just fetched.
      final initialMap = {for (var coin in initialData) coin.symbol: coin};
      
      // 3. Emit the first "Loaded" state. The UI will now show the list
      // with the correct prices AND the correct 24h percentage changes.
      emit(CoinListLoaded(initialMap));

      // 4. AFTER the initial data is loaded, subscribe to the WebSocket
      // for live PRICE-ONLY updates using emit.forEach.
      await emit.forEach<Coin>(
        _coinRepository.getCoinTickerStream(event.symbols),
        onData: (priceUpdate) {
          final currentState = state;
          
          if (currentState is CoinListLoaded) {
            // Create a mutable copy of the current map of coins.
            final updatedCoins = Map<String, Coin>.from(currentState.coins);
            
            // Check if the coin from the WebSocket update exists in our map.
            if (updatedCoins.containsKey(priceUpdate.symbol)) {
              
              // CRITICAL FIX: Only update the 'price'. The 'priceChangePercent'
              // from our initial HTTP call is preserved.
              updatedCoins[priceUpdate.symbol] = updatedCoins[priceUpdate.symbol]!.copyWith(
                price: priceUpdate.price,
              );

              // Return the new state with the updated price to be emitted.
              return CoinListLoaded(updatedCoins);
            }
          }
          // If the state isn't 'Loaded' or the symbol doesn't match, do nothing.
          return currentState; 
        },
        onError: (error, stackTrace) {
          // It's often better to just print stream errors and keep showing
          // the last known data, rather than showing a full error screen.
          print("Error on WebSocket stream: $error");
          return state; // Return the current state to avoid breaking the UI
        },
      );

    } catch (e) {
      // This will catch any errors from the initial HTTP call.
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