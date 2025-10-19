import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';


class CoinTickerDataSource {
  IOWebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();

  Stream<Map<String, dynamic>> get stream => _streamController.stream;

  void connect(List<String> symbols) {
    if (_channel != null) disconnect();

    const url = 'wss://ws.bitstamp.net';
    debugPrint("Connecting to Bitstamp URL: $url");

    try {
      _channel = IOWebSocketChannel.connect(Uri.parse(url));
      
      for (final symbol in symbols) {
        final pair = '${symbol.toLowerCase()}usd'; 
        final subscriptionMessage = {
          'event': 'bts:subscribe',
          'data': {
            'channel': 'live_trades_$pair',
          },
        };
        _channel?.sink.add(jsonEncode(subscriptionMessage));
        debugPrint('Sent Bitstamp subscription for: $pair');
      }

      _channel?.stream.listen(
        (message) {
          final data = jsonDecode(message) as Map<String, dynamic>;

          if (data['event'] == 'trade') {
            debugPrint('BITSTAMP TRADE: $data');
            _streamController.add({
              'channel': data['channel'],
              'data': data['data'],
            });
          } else if (data['event'] == 'bts:subscription_succeeded') {
            debugPrint('Bitstamp subscription succeeded: ${data['channel']}');
          }
        },
        onError: (error) {
          final errorMessage = 'Bitstamp WebSocket Error: $error';
          debugPrint(errorMessage);
          _streamController.addError(errorMessage);
        },
        onDone: () => debugPrint('Bitstamp WebSocket Closed'),
      );

    } catch (e) {
      final errorMessage = 'Error connecting to Bitstamp WebSocket: $e';
      debugPrint(errorMessage);
      _streamController.addError(errorMessage);
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}

