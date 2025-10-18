import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/trading_details/domain/entities/nested_trading_history.dart';

class NestedTradeHistoryCard extends StatelessWidget {
  final NestedTradeHistory trade;
  const NestedTradeHistoryCard({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // color: AppColors.bottomContainerBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          _buildDetailRow('Entry price', '${trade.entryPrice} USDT'),
          _buildDetailRow('Exit price', '${trade.exitPrice} USDT'),
          _buildDetailRow('Copiers', '${trade.copiers}'),
          _buildDetailRow('Copiers amount', '${trade.copiersAmount.toStringAsFixed(3)} USDT'),
          _buildDetailRow('Entry time', trade.entryTime),
          _buildDetailRow('Exit time', trade.exitTime),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}