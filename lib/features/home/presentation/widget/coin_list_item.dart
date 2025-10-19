import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_test/features/home/domain/entities/coin.dart'; 

class CoinListItem extends StatelessWidget {
  final Coin coin;
  const CoinListItem({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final bool isPositive = coin.priceChangePercent >= 0;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          coin.symbol == "BTC" ?
              SvgPicture.asset("assets/images/bitcoin_icon.svg") : 
              coin.symbol == "ETH" ?
              SvgPicture.asset("assets/images/etherum.svg") : 
              coin.symbol == "BNB" ?
              SvgPicture.asset("assets/images/bnb-bnb-logo.svg", width: 32, height: 32,) : 
              coin.symbol == "XRP" ?
              SvgPicture.asset("assets/images/xrp-xrp-logo.svg", width: 30, height: 30,)  : Text(""),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coin.symbol == "BTC" ?
              Text("Bitcoin", style: const TextStyle(fontWeight: FontWeight.bold)) : 
              coin.symbol == "ETH" ?
              Text("Etherum", style: const TextStyle(fontWeight: FontWeight.bold)) : 
              coin.symbol == "BNB" ?
              Text("BNB", style: const TextStyle(fontWeight: FontWeight.bold)) : 
              coin.symbol == "XRP" ?
              Text("XRP", style: const TextStyle(fontWeight: FontWeight.bold)) : Text(""),
              Text(coin.symbol, style: const TextStyle(color: Colors.white70)),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(currencyFormat.format(coin.price), style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '${isPositive ? '+' : ''}${coin.priceChangePercent.toStringAsFixed(2)}%',
                style: TextStyle(color: isPositive ? Colors.green : Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}