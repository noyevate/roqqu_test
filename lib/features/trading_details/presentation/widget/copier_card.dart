import 'package:flutter/material.dart';
import 'package:roqqu_test/core/utils/color_generator.dart';
import 'package:roqqu_test/features/copy_trading/presentation/widget/trader_avatar.dart';
import 'package:roqqu_test/features/trading_details/domain/entities/copier.dart';

class CopierCard extends StatelessWidget {
  final Copier copier;
  const CopierCard({super.key, required this.copier});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),      
      child: Column(
        
        children: [
          Row(
            children: [
              TraderAvatar(
                initials: copier.initials,
                baseColor: ColorGenerator.fromName(copier.name),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Text(copier.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric('Total volume', '${copier.totalVolume.toStringAsFixed(2)} USDT'),
              _buildMetric('Trading profit', '${copier.tradingProfit.toStringAsFixed(2)} USDT', alignment: CrossAxisAlignment.end),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, {CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }
}