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
        initialCoins.add(Coin(symbol: symbol.toUpperCase(), name: 'Unknown', iconAsset: ''));
      }
    }
    return initialCoins;
  }

  Stream<Coin> getCoinTickerStream(List<String> symbols) {
    _dataSource.connect(symbols);

    return _dataSource.stream.map((tradeData) {
      
      final channel = tradeData['channel'] as String?;
      final data = tradeData['data'] as Map<String, dynamic>?;

      if (channel == null || data == null) {
        return const Coin(symbol: '?', name: 'Error', iconAsset: '');
      }

      final symbol = channel.replaceAll('live_trades_', '').replaceAll('usd', '').toUpperCase();
            final price = (data['price'] as num?)?.toDouble() ?? 0.0;

      return Coin(
        symbol: symbol,
        name: 'Unknown',
        iconAsset: '',
        price: price,
        priceChangePercent: 0.0, 
      );
    });
  }

  void closeStream() {
    _dataSource.disconnect();
  }
}
