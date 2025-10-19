import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

// class CoinTickerDataSource {
//   IOWebSocketChannel? _channel;
//   final StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();

//   Stream<Map<String, dynamic>> get stream => _streamController.stream;

//   // --- THIS IS THE NEW, REFACTORED METHOD FOR COINBASE ---
//   void connect(List<String> symbols) {
//     if (_channel != null) disconnect();

//     // The Coinbase WebSocket URL is simple and direct.
//     const url = 'wss://ws-feed.exchange.coinbase.com';
//     debugPrint("Connecting to Coinbase URL: $url");

//     try {
//       _channel = IOWebSocketChannel.connect(Uri.parse(url));
      
//       // After connecting, we must send a subscription message.
//       // The product IDs must be in the format 'BTC-USD'.
//       debugPrint('channer: $_channel');
//       final productIds = symbols.map((s) => '${s.toUpperCase()}-USD').toList();
//       final subscriptionMessage = {
//         'type': 'subscribe',
//         'product_ids': productIds,
//         'channels': ['ticker'], // The 'ticker' channel provides real-time price updates
//       };

//       // Send the subscription message to the server.
//       _channel?.sink.add(jsonEncode(subscriptionMessage));
//       debugPrint('Sent Coinbase subscription: ${jsonEncode(subscriptionMessage)}');

//       // Now, listen for incoming messages.
//       _channel?.stream.listen(
//         (message) {
//           final data = jsonDecode(message) as Map<String, dynamic>;

//           // Coinbase ticker messages have a 'type' of 'ticker'.
//           if (data['type'] == 'ticker' && data.containsKey('price')) {
//              // --- ADD THIS DEBUG PRINT ---
//             debugPrint('COINBASE TICKER: $data');
//             _streamController.add(data);
//           }
//         },
//         onError: (error) {
//           final errorMessage = 'Coinbase WebSocket Error: $error';
//           debugPrint(errorMessage);
//           _streamController.addError(errorMessage);
//         },
//         onDone: () => debugPrint('Coinbase WebSocket Closed'),
//       );

//     } catch (e) {
//       final errorMessage = 'Error connecting to Coinbase WebSocket: $e';
//       debugPrint(errorMessage);
//       _streamController.addError(errorMessage);
//     }
//   }

//   void disconnect() {
//     // Before closing, it's good practice to send an unsubscribe message.
//     if (_channel != null) {
//       final unsubscribeMessage = { 'type': 'unsubscribe', 'channels': ['ticker'] };
//       _channel?.sink.add(jsonEncode(unsubscribeMessage));
//     }
//     _channel?.sink.close();
//     _channel = null;
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

// class CoinTickerDataSource {
//   IOWebSocketChannel? _channel;
//   final StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
//   Stream<Map<String, dynamic>> get stream => _streamController.stream;

//   void connect(List<String> symbols) {
//     if (_channel != null) disconnect();

//     const url = 'wss://ws.bitstamp.net';
//     debugPrint("🌍 Connecting to Bitstamp WebSocket: $url");

//     try {
//       _channel = IOWebSocketChannel.connect(Uri.parse(url));
//       debugPrint("✅ Connected to Bitstamp WebSocket");

//       // Subscribe to each symbol’s live trade channel
//       for (final symbol in symbols) {
//         final channelName = 'live_trades_${symbol.toLowerCase()}usd';
//         final subscribeMessage = {
//           "event": "bts:subscribe",
//           "data": {"channel": channelName}
//         };

//         _channel?.sink.add(jsonEncode(subscribeMessage));
//         debugPrint("📡 Subscribed to Bitstamp channel: $channelName");
//       }

//       // Listen to the WebSocket stream
//       _channel?.stream.listen(
//         (message) {
//           final decoded = jsonDecode(message);

//           if (decoded['event'] == 'trade') {
//             final tradeData = decoded['data'];

//             _streamController.add({
//               'symbol': tradeData['symbol'] ?? tradeData['channel'] ?? '',
//               'price': tradeData['price'],
//               'volume': tradeData['amount'],
//               'timestamp': tradeData['timestamp'],
//             });
//             debugPrint("💹 Trade update: ${tradeData['price']}");
//           }
//         },
//         onError: (error) {
//           debugPrint("🛑 Bitstamp WebSocket Error: $error");
//           _streamController.addError(error);
//         },
//         onDone: () {
//           debugPrint("🔌 Bitstamp WebSocket Closed");
//         },
//       );
//     } catch (e) {
//       debugPrint("⚠️ Error connecting to Bitstamp WebSocket: $e");
//       _streamController.addError(e);
//     }
//   }

//   void disconnect() {
//     if (_channel != null) {
//       _channel?.sink.add(jsonEncode({
//         "event": "bts:unsubscribe",
//         "data": {"channel": "live_trades_btcusd"}
//       }));
//       _channel?.sink.close();
//       _channel = null;
//       debugPrint("🔕 Disconnected from Bitstamp WebSocket");
//     }
//   }
// }

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
      
      // --- Bitstamp Subscription Logic ---
      // We must send a separate subscription message for each trading pair.
      for (final symbol in symbols) {
        final pair = '${symbol.toLowerCase()}usd'; // e.g., 'btcusd'
        final subscriptionMessage = {
          'event': 'bts:subscribe',
          'data': {
            'channel': 'live_trades_$pair',
          },
        };
        _channel?.sink.add(jsonEncode(subscriptionMessage));
        debugPrint('Sent Bitstamp subscription for: $pair');
      }

      // Now, listen for all incoming messages.
      _channel?.stream.listen(
        (message) {
          final data = jsonDecode(message) as Map<String, dynamic>;

          // We only care about actual trade events, which give us the latest price.
          if (data['event'] == 'trade') {
            debugPrint('BITSTAMP TRADE: $data');
            // We need to pass both the data and the channel name to the repository
            // so it knows which coin this price belongs to.
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

