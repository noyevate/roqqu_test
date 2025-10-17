import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/utils/label_formatters.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/trade_history_item.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/custom_tabbar.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/trading_history_card.dart';
import 'package:roqqu_test/features/trading_details/presentation/performace_line_chart.dart';

class MyDashboardScreen extends StatefulWidget {
  const MyDashboardScreen({super.key});

  @override
  State<MyDashboardScreen> createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<DashboardData> _fetchDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));
    return DashboardData(
      copyTradingAssets: 5564.96,
      netProfit: 5564.96,
      todaysPnl: 207.25,
      pnlChartData: const [
        50000,
        55000,
        52000,
        60000,
        58000,
        65000,
        70000,
        68000,
        75000,
        80000,
        78000,
      ],
      tradeHistory: const [
        TradeHistoryItem(
          pair: 'BTCUSDT',
          leverage: '10X',
          roi: 3.28,
          proTrader: 'BTC master',
          entryPrice: 1.9661,
          exitPrice: 1.9728,
          proTraderAmount: 1009.772,
          entryTime: '01:22 PM',
          exitTime: '01:22 PM',
        ),
        TradeHistoryItem(
          pair: 'BTCUSDT',
          leverage: '10X',
          roi: 3.28,
          proTrader: 'BTC master',
          entryPrice: 1.9661,
          exitPrice: 1.9728,
          proTraderAmount: 1009.772,
          entryTime: '01:22 PM',
          exitTime: '01:22 PM',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My dashboard'),
      ),
      body: FutureBuilder<DashboardData>(
        future: _fetchDashboardData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return _buildContent(data);
        },
      ),
    );
  }

  Widget _buildContent(DashboardData data) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return Column(
      children: [
        _buildHeader(data, currencyFormat),

        // 👇 This part expands to fill the rest of the screen
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.bottomContainerBackground,
              border: Border.all(color: AppColors.bottomContainerBackground),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Top rounded corners already handled by parent
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: AppColors.darkBackground,
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF22262B), width: 1),
                    ),
                  ),
                  child: CustomTabBar(controller: _tabController, tabs: 
                  const [
                      'Chart',
                      'Current trades',
                      'Stats',
                      'My traders',
                    ],),
                  // child: TabBar(
                  //   controller: _tabController,
                  //   labelColor: Colors.white,
                  //   unselectedLabelColor: Colors.white54,
                  //   indicatorColor: Colors.white,
                  //   tabs: const [
                  //     Tab(text: 'Chart'),
                  //     Tab(text: 'Current trades'),
                  //     Tab(text: 'Stats'),
                  //     Tab(text: 'My traders'),
  
                  //   ],
                  // ),
                ),

                // 👇 Make TabBarView fill and scroll independently
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildScrollableTab(_buildChartTabView(data)),
                      _buildScrollableTab(
                        const Center(child: Text('Current Trades')),
                      ),
                      _buildScrollableTab(const Center(child: Text('Stats'))),
                      _buildScrollableTab(
                        const Center(child: Text('My Traders')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScrollableTab(Widget child) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      child: child,
    );
  }

  Widget _buildHeader(DashboardData data, NumberFormat currencyFormat) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.bottomContainerBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderMetric(
              'Copy trading assets',
              currencyFormat.format(data.copyTradingAssets),
            ),

            Divider(color: AppColors.tertiaryBackground),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderMetric(
                  'Net profit',
                  currencyFormat.format(data.netProfit),
                ),
                Column(
                  children: [
                    const Text(
                      "Today's PNL",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Image.asset("assets/images/trending-down.png"),
                        SizedBox(width: 5),
                        Text(
                          currencyFormat.format(data.todaysPnl),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderMetric(
    String label,
    String value, {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildChartTabView(DashboardData data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The chart itself is in its own styled container now
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              // color: AppColors.tertiaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Copy trading PNL',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Text('7 days '),
                          Icon(Icons.keyboard_arrow_down, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: PerformanceLineChart(
                    data: data.pnlChartData,
                    yAxisLabelFormatter: LabelFormatters.formatPnlValue,
                    showGrid: true,
                    fillOvershoot: 5000,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trading History',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                  decoration: BoxDecoration(
                        color: AppColors.tertiaryBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                  child: const Row(
                    children: [
                      Text('7 days '),
                      Icon(Icons.keyboard_arrow_down, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Column(
          children: data.tradeHistory.map((item) {
            return Column(
              children: [
                // 🔹 Header (moved out of the card)
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.innerBackground,
                   
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/bitcoin.png', height: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${item.pair} - ${item.leverage}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '+${item.roi.toStringAsFixed(2)}% ROI',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, ),
                  child: TradingHistoryCard(item: item),
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),
        ),
      ],
      ),
    );
  }
}

// Helper class to make the TabBar stick when scrolling
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar);
  final TabBar tabBar;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}


//   Widget _buildChartTabView(DashboardData data) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: AppColors.tertiaryBackground,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Copy trading PNL',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black26,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Row(
//                         children: [
//                           Text('7 days '),
//                           Icon(Icons.keyboard_arrow_down, size: 16),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   height: 150,
//                   child: PerformanceLineChart(
//                     data: data.pnlChartData,
//                     yAxisLabelFormatter: LabelFormatters.formatPnlValue,
//                     showGrid: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Text(
//             'Trading History',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           ListView.separated(
//             itemCount: data.tradeHistory.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             separatorBuilder: (context, index) => const SizedBox(height: 16),
//             itemBuilder: (context, index) =>
//                 TradingHistoryCard(item: data.tradeHistory[index]),
//           ),
//         ],
//       ),
//     );
//   }
// }