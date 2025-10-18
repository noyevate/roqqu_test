import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/trading_details/domain/entities/trading_details.dart';
import 'package:roqqu_test/features/trading_details/presentation/widget/nested_current_trade_card.dart';
import 'package:roqqu_test/features/trading_details/presentation/widget/nested_trade_history_card.dart';

class AllTradesTabView extends StatefulWidget {
  const AllTradesTabView({super.key, required this.details});
  final TraderDetails details;

  @override
  State<AllTradesTabView> createState() => _AllTradesTabViewState();
}

class _AllTradesTabViewState extends State<AllTradesTabView> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Row(
          children: [
            _buildSegmentedTab(),
            const SizedBox(width: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _selectedIndex == 1
                  ? Container(
                      key: const ValueKey('filter'),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.bottomContainerBackground, 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Text('7 days ', style: TextStyle(color: Colors.white70)),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 16),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bottomContainerBackground
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _selectedIndex == 0
                ? _buildCurrentTradesView(widget.details)
                : _buildHistoryView(widget.details),
          ),
        ),

        
      ],
    );
  }

  Widget _buildSegmentedTab() {
    final tabs = ['Current trades', 'History'];

    return Container(
      padding: const EdgeInsets.all(4),
      width: 220,
      decoration: BoxDecoration(
        color: AppColors.tertiaryBackground
        , // outer background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabs.length, (index) {
          final bool isSelected = index == _selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => _onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.darkBackground
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  Widget _buildCurrentTradesView(TraderDetails details) {
    return Column(
    children: details.allTradesCurrent.map((item) {
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
            child: NestedCurrentTradeCard(trade: item),
          ),
          const SizedBox(height: 12),
        ],
      );
    }).toList(),
  );
  }

  Widget _buildHistoryView(TraderDetails details) {

    return Column(
    children: details.allTradesHistory.map((item) {
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
            child: NestedTradeHistoryCard(trade: item),
          ),
          const SizedBox(height: 12),
        ],
      );
    }).toList(),
  );
    
  }
}
