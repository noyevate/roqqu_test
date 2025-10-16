import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';

import 'package:roqqu_test/core/utils/color_generator.dart';
import 'package:roqqu_test/core/utils/label_formatters.dart';
import 'package:roqqu_test/features/copy_trading/domain/entities/pro_trader.dart';
import 'package:roqqu_test/features/copy_trading/presentation/widget/trader_avatar.dart';
import 'package:roqqu_test/features/trading_details/domain/entities/trading_details.dart';
import 'package:roqqu_test/features/trading_details/presentation/performace_line_chart.dart';
import 'package:roqqu_test/features/trading_details/presentation/widget/asset_allocation_donut_chart.dart';
import 'package:roqqu_test/features/trading_details/presentation/widget/holding_period_scatter_chart.dart';
import 'package:roqqu_test/features/trading_details/presentation/widget/info_chip.dart';

class TradingDetailsScreen extends StatefulWidget {
  const TradingDetailsScreen({super.key});

  @override
  State<TradingDetailsScreen> createState() => _TradingDetailsScreenState();
}

class _TradingDetailsScreenState extends State<TradingDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  Future<TraderDetails> _fetchTraderDetails() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return TraderDetails(
      trader: const ProTrader(initials: 'BM', name: 'BTC Master', copiers: 500, roi: 123, pnl: 0, winRate: 0, aum: 0, chartData: []),
      tradingDays: 43,
      profitShare: 15,
      totalOrders: 56,
      // roiChartData: const [10, 12, 11, 15, 18, 16, 20, 22, 25, 23],
      roiChartData: const [110, 112, 111, 115, 118, 116, 120, 122, 125, 123],
      // pnlChartData: const [50, 55, 60, 58, 65, 70, 68, 75, 80, 78],
      pnlChartData: const [50000, 55000, 60000, 58000, 65000, 70000, 68000, 75000, 80000, 78000],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TraderDetails>(
        future: _fetchTraderDetails(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final details = snapshot.data!;
          return _buildContent(details);
        },
      ),
      bottomNavigationBar: _buildPersistentFooter(context),
    );
  }

  Widget _buildContent(TraderDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Trading details'),
          pinned: true,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTraderHeader(details.trader, screenWidth),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildInfoChips(details)),
                const SizedBox(height: 20),
                _buildCertifiedBanner(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          delegate: _SliverTabBarDelegate(
            TabBar(
              labelColor: AppColors.primaryText,
              padding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              controller: _tabController,
              isScrollable: true,
              tabs: const [Tab(text: 'Chart'), Tab(text: 'Stats'), Tab(text: 'All Trades'), Tab(text: 'Copiers')],
            ),
          ),
          pinned: true,
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildChartTabView(details),
              const Center(child: Text('Stats View')),
              const Center(child: Text('All Trades View')),
              const Center(child: Text('Copiers View')),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTraderHeader(ProTrader trader, double screenWidth) {
    return Row(
      children: [
        TraderAvatar(
          initials: trader.initials,
          baseColor: ColorGenerator.fromName(trader.name),
          radius: screenWidth * 0.07,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trader.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Row(
              children: [
                Image.asset("assets/images/user_alt.png"),
                // Icon(FontAwesomeIcons.users, size: 12, color: Colors.grey[400]),
                 SizedBox(width: 6),
                Text('${trader.copiers} Copiers', style: TextStyle(color: AppColors.accentBlue)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChips(TraderDetails details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InfoChip(label: '${details.tradingDays} trading days'),
        SizedBox(width: 5,),
        InfoChip(label: '${details.profitShare}% profit-share'),
        SizedBox(width: 5,),
        InfoChip(label: '${details.totalOrders} total orders'),
      ],
    );
  }
  
  Widget _buildTag({required String text, required IconData icon, required Color color, required String urls}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(urls, color: color,),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCertifiedBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bottomContainerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryBackground)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/images/certified_world.png"),
              Image.asset("assets/images/verified.png")
            ],
          ),
          const Text('Certified PROtrader', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTag(text: 'High win rate', icon: Icons.analytics, color: Colors.green, urls: "assets/images/chart.png"),
              const SizedBox(width: 12),
              _buildTag(text: 'Great risk control', icon: FontAwesomeIcons.chartLine, color: Colors.orange, urls: "assets/images/Vector.png"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartTabView(TraderDetails details) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildChartCard('ROI', details.roiChartData, LabelFormatters.formatRoiPercentage, fillOvershoot: 3, backgroundColor: Colors.transparent),
          const SizedBox(height: 5),
          _buildChartCard('PNL', details.pnlChartData,  LabelFormatters.formatPnlValue, fillOvershoot: 5000, ),
          const SizedBox(height: 5),
          _buildAssetsAllocationCard(),
          const SizedBox(height: 5),
          _buildHoldingPeriodCard(),
        ],
      ),
    );
  }
  
  Widget _buildChartCard(String title, List<double> data, YAxisLabelFormatter formatter, {
    Color? backgroundColor, double fillOvershoot = 0.0,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      
      decoration: BoxDecoration(
        color: AppColors.bottomContainerBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.tertiaryBackground, borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [Text('7 days '), Icon(Icons.keyboard_arrow_down, size: 16)],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(height: 150, child: PerformanceLineChart(data: data, yAxisLabelFormatter: formatter, chartBackgroundColor: backgroundColor, fillOvershoot: fillOvershoot,)),
        ],
      ),
    );
  }

  Widget _buildAssetsAllocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bottomContainerBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Assets allocation', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.tertiaryBackground, borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [Text('7 days '), Icon(Icons.keyboard_arrow_down, size: 16)],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const AssetsAllocationDonutChart(),
        ],
      ),
    );
  }

  Widget _buildHoldingPeriodCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bottomContainerBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Holding period', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.tertiaryBackground, borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [Text('7 days '), Icon(Icons.keyboard_arrow_down, size: 16)],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 120, child: HoldingPeriodScatterChart()),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(Colors.green, 'Profit'),
              const SizedBox(width: 24),
              _buildLegendItem(Colors.red, 'Loss'),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _buildPersistentFooter(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3546), // Match card background
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewPadding.bottom + 16,
      ),
      child: GradientButton(text: 'Copy trade', onPressed: () {}),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar);
  final TabBar tabBar;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Theme.of(context).scaffoldBackgroundColor, child: tabBar);
  }
  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}