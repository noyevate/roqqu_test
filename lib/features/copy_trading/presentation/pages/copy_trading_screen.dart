import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/utils/color_generator.dart';
import 'package:roqqu_test/features/copy_trading/domain/entities/pro_trader.dart';
import 'package:roqqu_test/features/copy_trading/presentation/widget/dashboard_card.dart';
import 'package:roqqu_test/features/copy_trading/presentation/widget/spackline_chart.dart';
import 'package:roqqu_test/features/copy_trading/presentation/widget/trader_avatar.dart';

class CopyTradingScreen extends StatefulWidget {
  const CopyTradingScreen({super.key});

  @override
  State<CopyTradingScreen> createState() => _CopyTradingScreenState();
}

class _CopyTradingScreenState extends State<CopyTradingScreen> {

  
  Future<List<ProTrader>> _fetchProTraders() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      const ProTrader(initials: 'JI', name: 'Jay Isiaou', copiers: 500, roi: 120.42, pnl: 38667.29, winRate: 100, aum: 38667.29, chartData: [1, 4,1.5, 2, 3, 2, 4, 3, 5, 4]),
      const ProTrader(initials: 'LO', name: 'Laura Okobi', copiers: 500, roi: 120.42, pnl: 38667.29, winRate: 100, aum: 38667.29, chartData: [2,2.1, 1, 4, 2, 5, 3, 4]),
      const ProTrader(initials: 'BM', name: 'BTC Master', copiers: 500, roi: 120.42, pnl: 38667.29, winRate: 100, aum: 38667.29, chartData: [3, 2, 5, 4, 6, 5, 7]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Copy trading')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Image.asset( "assets/images/dashboard_2.png")),
                // Expanded(child: DashboardCard(url:"assets/images/icon_1.png", title: 'My dashboard', subtitle: 'View trades', icon: Icons.dashboard, gradient: AppColors.dashboardLinearGradient)),
                const SizedBox(width: 16),

                Expanded(child: Image.asset( "assets/images/dashboard_1.png")),
                // Expanded(child: DashboardCard(url:"assets/images/icon_1.png", title: 'Become a PRO trader', subtitle: 'Apply Now', icon: Icons.workspace_premium, gradient: AppColors.dashboardLinearGradient_2)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('PRO Traders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            FutureBuilder<List<ProTrader>>(
              future: _fetchProTraders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load data'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No traders found'));
                }
                final traders = snapshot.data!;
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(), // Important for nested list
                  shrinkWrap: true,
                  itemCount: traders.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildProTraderCard(traders[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProTraderCard(ProTrader trader) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.06;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.bottomContainerBackground,
            border: Border.all(color: AppColors.tertiaryBackground),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          
          child: Column(
            children: [
              Row(
                children: [
                  // CircleAvatar(child: Text(trader.initials)),
                  TraderAvatar(
                initials: trader.initials,
                baseColor: ColorGenerator.fromName(trader.name),
                radius: avatarRadius,
              ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trader.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(children: [Image.asset("assets/images/user_alt.png"), Text(' ${trader.copiers}')]),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child:  Text('Copy', style: TextStyle(color: AppColors.tertiaryText, fontSize: 14, fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
               const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ROI', style: TextStyle(color: Colors.grey)),
                        Text('+${trader.roi.toStringAsFixed(2)}%', style: TextStyle(color: Color(0xFF00C853), fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Total PNL: ${currencyFormat.format(trader.pnl)}'),
                      ],
                    ),
                  ),
                  Expanded(flex: 3, child: SizedBox(height: 50, child: SpacklineChart(data: trader.chartData, chartColor: Colors.greenAccent,))),
                ],              ),
              
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.tertiaryBackground),
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Win rate: ${trader.winRate}%'),
                  Row(children: [Icon(Icons.info_outline, size: 14, color: Colors.grey), Text(' AUM: ${currencyFormat.format(trader.aum)}')]),
                ],
              ),
        )
      ],
    );
  }
}