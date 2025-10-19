// import 'package:roqqu_test/features/home/data/datasources/coin_tinker_datasource.dart';
// import 'package:roqqu_test/features/home/domain/entities/coin.dart';

// class CoinRepository {
//   final CoinTickerDataSource _dataSource;
//   CoinRepository(this._dataSource);

//   // We need to map the full name (e.g., "bitcoin") to the symbol (e.g., "BTC")
//   final Map<String, String> _nameToSymbolMap = {
//     'bitcoin': 'BTC',
//     'ethereum': 'ETH',
//     'binance-coin': 'BNB', // Note: CoinCap uses 'binance-coin' for BNB
//     'ripple': 'XRP',
//   };

//   Stream<Coin> getCoinTickerStream(List<String> symbols) {
//     // We need to pass the CoinCap specific IDs to the data source
//     final coinCapIds = symbols.map((s) {
//         switch(s.toUpperCase()) {
//             case 'BTC': return 'bitcoin';
//             case 'ETH': return 'ethereum';
//             case 'BNB': return 'binance-coin';
//             case 'XRP': return 'ripple';
//             default: return s.toLowerCase();
//         }
//     }).toList();

//     _dataSource.connect(coinCapIds);

//     return _dataSource.stream.map((tickerData) {
//       // --- THIS IS THE UPDATED MAPPING LOGIC FOR COINCAP ---
//       // The key of the map is the coin's ID (e.g., "bitcoin")
//       final coinId = tickerData.keys.first;
//       final price = double.tryParse(tickerData.values.first ?? '0.0') ?? 0.0;
      
//       // We look up the symbol from our map
//       final symbol = _nameToSymbolMap[coinId] ?? '?';

//       // CoinCap's ticker stream doesn't include price change percent.
//       // We will have to calculate this ourselves or leave it as 0.0 for now.
//       return Coin(
//         symbol: symbol,
//         name: coinId.toUpperCase(), // Use the ID as a temporary name
//         iconAsset: '',
//         price: price,
//         priceChangePercent: 0.0, // Defaulting to 0.0
//       );
//     });
//   }

//   void closeStream() {
//     _dataSource.disconnect();
//   }
// }


// import 'package:roqqu_test/features/home/data/datasources/coin_tinker_datasource.dart';
// import 'package:roqqu_test/features/home/domain/entities/coin.dart';

// class CoinRepository {
//   final CoinTickerDataSource _dataSource;
//   CoinRepository(this._dataSource);

//   Stream<Coin> getCoinTickerStream(List<String> symbols) {
//     // The symbols ['BTC', 'ETH'] are already in the correct format for the connect method.
//     _dataSource.connect(symbols);

//     return _dataSource.stream.map((tickerData) {
//       // --- THIS IS THE UPDATED MAPPING LOGIC FOR COINBASE ---
//       // Coinbase keys:
//       // 'product_id': "BTC-USD"
//       // 'price': "22840.12"
//       // 'price_percent_change_24h': "-0.61" (This field is often in their REST API, but let's check the stream)
      
//       // Note: Coinbase WebSocket 'ticker' channel does not include 24h change.
//       // We will default it to 0.0, as showing the live price is the main goal.
//       // A full production app would fetch this value via a separate HTTP call.
      
//       return Coin(
//         // The product_id is in the format 'BTC-USD', we extract 'BTC'.
//         symbol: tickerData['product_id']?.replaceAll('-USD', '') ?? '?',
//         name: 'Unknown', // This would still come from a local map
//         iconAsset: '',
//         price: double.tryParse(tickerData['price'] ?? '0.0') ?? 0.0,
//         // Defaulting to 0.0 as the 'ticker' stream doesn't provide this.
//         priceChangePercent: 0.0, 
//       );
//     });
//   }

//   void closeStream() {
//     _dataSource.disconnect();
//   }
// }



// import 'package:roqqu_test/features/home/data/datasources/coin_tinker_datasource.dart';
// import 'package:roqqu_test/features/home/domain/entities/coin.dart';

// class CoinRepository {
//   final CoinTickerDataSource _dataSource;
//   CoinRepository(this._dataSource);

//   Stream<Coin> getCoinTickerStream(List<String> symbols) {
//     // Connect to Binance WebSocket
//     _dataSource.connect(symbols);

//     return _dataSource.stream.map((tickerData) {
//       // Binance WebSocket sends data in a nested format under 'data' key
//       // Example: { "stream": "btcusdt@ticker", "data": { ... } }
//       final data = tickerData['data'] ?? tickerData;

//       // Binance key references
//       final symbol = data['s'] ?? '';
//       final priceStr = data['c'] ?? '0.0';
//       final percentStr = data['P'] ?? '0.0';

//       return Coin(
//         symbol: symbol.replaceAll('USDT', ''), // e.g. BTC from BTCUSDT
//         name: 'Unknown', // You can map this manually if you have a symbol-name map
//         iconAsset: '',
//         price: double.tryParse(priceStr) ?? 0.0,
//         priceChangePercent: double.tryParse(percentStr) ?? 0.0,
//       );
//     });
//   }

//   void closeStream() {
//     _dataSource.disconnect();
//   }
// }

import 'dart:convert';

import 'package:roqqu_test/features/home/data/datasources/coin_tinker_datasource.dart';
import 'package:roqqu_test/features/home/domain/entities/coin.dart';
import 'package:http/http.dart' as http;

class CoinRepository {
  final CoinTickerDataSource _dataSource;
  CoinRepository(this._dataSource);
  Future<List<Coin>> getInitialCoinData(List<String> symbols) async {
    final List<Coin> initialCoins = [];
    for (final symbol in symbols) {
      final pair = '${symbol.toLowerCase()}usd';
      final url = Uri.parse('https://www.bitstamp.net/api/v2/ticker/$pair/');
      try {
        final response = await http.get(url).timeout(const Duration(seconds: 5));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          // Bitstamp's 'open' is the price 24h ago, 'last' is the current price.
          // Change = (last - open) / open
          final openPrice = double.tryParse(data['open'] ?? '0.0') ?? 0.0;
          final lastPrice = double.tryParse(data['last'] ?? '0.0') ?? 0.0;
          
          final priceChangePercent = openPrice > 0 ? ((lastPrice - openPrice) / openPrice) * 100 : 0.0;

          initialCoins.add(Coin(
            symbol: symbol.toUpperCase(),
            name: 'Unknown',
            iconAsset: '',
            price: lastPrice,
            priceChangePercent: priceChangePercent,
          ));
        }
      } catch (e) {
        print('Failed to fetch initial data for $symbol: $e');
        // Add a default coin so the UI doesn't break
        initialCoins.add(Coin(symbol: symbol.toUpperCase(), name: 'Unknown', iconAsset: ''));
      }
    }
    return initialCoins;
  }

  Stream<Coin> getCoinTickerStream(List<String> symbols) {
    _dataSource.connect(symbols);

    return _dataSource.stream.map((tradeData) {
      // --- THIS IS THE UPDATED MAPPING LOGIC FOR BITSTAMP ---
      
      // Extract the channel and data from the map sent by the DataSource
      final channel = tradeData['channel'] as String?;
      final data = tradeData['data'] as Map<String, dynamic>?;

      if (channel == null || data == null) {
        // Return a dummy object or handle error if data is malformed
        return const Coin(symbol: '?', name: 'Error', iconAsset: '');
      }

      // The channel is 'live_trades_btcusd'. We extract 'BTC'.
      final symbol = channel.replaceAll('live_trades_', '').replaceAll('usd', '').toUpperCase();
      
      // The price is in the 'price' field of the data object.
      final price = (data['price'] as num?)?.toDouble() ?? 0.0;
      
      // NOTE: Bitstamp's 'live_trades' channel does not provide the 24h percentage change.
      // A full production app would get this via a separate HTTP call to their Ticker endpoint.
      // For this assessment, showing the live price is the main goal, so we'll default it.
      return Coin(
        symbol: symbol,
        name: 'Unknown', // This would come from a local map
        iconAsset: '',
        price: price,
        priceChangePercent: 0.0, // Defaulting to 0.0
      );
    });
  }

  void closeStream() {
    _dataSource.disconnect();
  }
}
