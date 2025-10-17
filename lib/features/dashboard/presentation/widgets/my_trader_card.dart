import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/utils/color_generator.dart';
import 'package:roqqu_test/features/copy_trading/presentation/widget/trader_avatar.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/my_trader.dart';

class MyTraderCard extends StatelessWidget {
  final MyTrader trader;
  const MyTraderCard({super.key, required this.trader});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  TraderAvatar(
                    initials: trader.initials,
                    baseColor: ColorGenerator.fromName(trader.name),
                    radius: 24, 
                  ),
                  const SizedBox(width: 12),
                  Text(trader.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  Image.asset('assets/images/bage_pro.png', height: 40), 
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMetric('Total volume', '${trader.totalVolume.toStringAsFixed(2)} USDT'),
                  _buildMetric('Trading profit', '${trader.tradingProfit.toStringAsFixed(2)} USDT', alignment: CrossAxisAlignment.end),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.primaryBackground),
      ],
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