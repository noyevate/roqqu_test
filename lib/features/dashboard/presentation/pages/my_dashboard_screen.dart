import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/utils/label_formatters.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/current_trade_item.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/trade_history_item.dart';
import 'package:roqqu_test/features/dashboard/domain/entities/trading_stats.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/custom_tabbar.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/my_trader.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/my_trader_card.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/stat_row.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/trading_history_card.dart';
import 'package:roqqu_test/features/dashboard/presentation/widgets/trading_pair_chip.dart'
    show TradingPairChip;
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
      myTraders: const [
      MyTrader(name: 'Jaykay Kayode', initials: 'JK', totalVolume: 996.28, tradingProfit: 278.81),
      MyTrader(name: 'Okobi Laura', initials: 'OL', totalVolume: 996.28, tradingProfit: 278.81),
      MyTrader(name: 'Tosin Lasisi', initials: 'TL', totalVolume: 996.28, tradingProfit: 278.81),
    ],
      stats: const TradingStats(
        proTraders: 17,
        tradingDays: 43,
        profitShare: 15,
        totalOrders: 56,
        averageLosses: 0.0,
        totalCopyTrades: 72,
        tradingPairs: [
          'BTCUSDT',
          'ETHUSDT',
          'XRPUSDT',
          'TIAUSDT',
          'DOGEUSDT',
          'PERPUSDT',
          'TIAUSDT',
          'DOGEUSDT',
          'PERPUSDT',
          'TIAUSDT',
          'DOGEUSDT',
          'PERPUSDT',
        ],
      ),

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
      currentTrades: const [
        CurrentTradeItem(
          pair: 'BTCUSDT',
          leverage: '10X',
          roi: 3.28,
          proTrader: 'BTC master',
          entryPrice: 1.9661,
          marketPrice: 1.9728,
          entryTime: '01:22 PM',
        ),
        CurrentTradeItem(
          pair: 'ETHUSDT',
          leverage: '5X',
          roi: 1.52,
          proTrader: 'ETH King',
          entryPrice: 150.45,
          marketPrice: 152.80,
          entryTime: '11:58 AM',
        ),
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
      appBar: AppBar(title: const Text('My dashboard')),
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: AppColors.darkBackground,
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF22262B), width: 1),
                    ),
                  ),
                  child: CustomTabBar(
                    controller: _tabController,
                    tabs: const [
                      'Chart',
                      'Current trades',
                      'Stats',
                      'My traders',
                    ],
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildScrollableTab(_buildChartTabView(data)),

                      _buildScrollableTab(_buildCurrentTradesTabView(data)),

                      _buildStatsTabView(data),

                      _buildMyTradersTabView(data)
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(color: AppColors.innerBackground),
                    child: Row(
                      children: [
                        Image.asset('assets/images/bitcoin.png', height: 24),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Text(
                              '${item.pair}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              ' - ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              '${item.leverage}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.accentBlue,
                              ),
                            ),
                          ],
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
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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

Widget _buildCurrentTradesTabView(DashboardData data) {
  return Column(
    children: data.tradeHistory.map((item) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(color: AppColors.innerBackground),
            child: Row(
              children: [
                Image.asset('assets/images/bitcoin.png', height: 24),
                const SizedBox(width: 8),
                Row(
                  children: [
                    Text(
                      '${item.pair}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),

                    Text(
                      ' - ',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),

                    Text(
                      '${item.leverage}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ],
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
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TradingHistoryCard(item: item),
          ),
          const SizedBox(height: 12),
        ],
      );
    }).toList(),
  );
}

Widget _buildStatsTabView(DashboardData data) {
  final stats = data.stats;
  return ListView(
    padding: const EdgeInsets.all(16.0),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Trading statistics',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.innerBackground,
              border: Border.all(color: AppColors.tertiaryBackground),
              borderRadius: BorderRadius.circular(8),
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
      const SizedBox(height: 8),
      StatRow(label: 'PRO traders', value: '${stats.proTraders}', valueColor: AppColors.accentBlue,),
      StatRow(label: 'Trading days', value: '${stats.tradingDays}'),
      StatRow(label: 'Profit-share', value: '${stats.profitShare}%'),
      StatRow(label: 'Total orders', value: '${stats.totalOrders}'),
      StatRow(
        label: 'Average losses',
        value: '${stats.averageLosses.toStringAsFixed(2)} USDT',
        valueColor: Colors.redAccent,
      ),
      StatRow(label: 'Total copy trades', value: '${stats.totalCopyTrades}'),

      const SizedBox(height: 24),
      const Text(
        'Trading pairs',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      const SizedBox(height: 16),
      Wrap(
        spacing: 12.0, 
        runSpacing: 12.0,
        children: stats.tradingPairs
            .map((pair) => TradingPairChip(pair: pair))
            .toList(),
      ),
    ],
  );
}

Widget _buildMyTradersTabView(DashboardData data) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search for PRO traders',
            suffixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: AppColors.innerBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          itemCount: data.myTraders.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return MyTraderCard(trader: data.myTraders[index]);
          },
        ),
      ],
    );
  }
