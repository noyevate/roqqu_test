import 'package:flutter/material.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/current_trade_item.dart';

class CurrentTradeCard extends StatelessWidget {
  final CurrentTradeItem item;
  const CurrentTradeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          
         
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow('PRO trader', item.proTrader, hasAvatar: true),
                _buildDetailRow('Entry price', '${item.entryPrice} USDT'),
                _buildDetailRow('Market price', '${item.marketPrice} USDT'),
                _buildDetailRow('Entry time', item.entryTime),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool hasAvatar = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Row(
            children: [
              if (hasAvatar) ...[
                const CircleAvatar(radius: 10, child: Icon(Icons.person, size: 12)),
                const SizedBox(width: 8),
              ],
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}