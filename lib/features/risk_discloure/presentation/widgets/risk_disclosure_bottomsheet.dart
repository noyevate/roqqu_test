import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';
import 'package:roqqu_test/features/risk_discloure/domain/entities/risk_items.dart';

class RiskDisclosureBottomSheet extends StatelessWidget {
  const RiskDisclosureBottomSheet({super.key});

  // --- MOCK DATA SOURCE ---
  final List<RiskItem> riskItems = const [
    RiskItem(title: 'Market risks', content: 'The value of cryptocurrencies can be extremely volatile and change rapidly.'),
    RiskItem(title: 'Dependency on others', content: 'Your investment outcome is dependent on the performance of the trader you are copying.'),
    RiskItem(title: 'Mismatched risk profiles', content: 'The copied trader\'s risk tolerance may not align with your own financial goals.'),
    RiskItem(title: 'Control and understanding', content: 'You give up direct control over individual trading decisions.'),
    RiskItem(title: 'Emotional decisions', content: 'Poor performance can lead to emotional decisions, such as stopping a copy at an inopportune time.'),
    RiskItem(title: 'Costs involved', content: 'Fees and profit-sharing will impact your overall returns.'),
    RiskItem(title: 'Diversify', content: 'It is important to diversify your investments and not rely on a single trader.'),
    RiskItem(title: 'Execution risks', content: 'Slippage and latency can affect the price at which your trades are executed.'),
    RiskItem(title: 'Copy trading investments can be complex', content: 'Ensure you fully understand the mechanics and risks before investing.'),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: screenHeight * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06)
                .copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 50, height: 5,
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Risks involved in copy trading',
                  style: textTheme.displayLarge?.copyWith(fontSize: screenWidth * 0.055),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please make sure you read the following risks involved in copy trading before making a decision.',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: AppColors.bottomContainerBackground,
      borderRadius: BorderRadius.circular(12.0),
    ),
                    child: ListView.builder(
                      itemCount: riskItems.length,
                      itemBuilder: (context, index) {
                        final item = riskItems[index];
                        return Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                                child: Text(item.content, style: textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GradientButton(
                  text: 'I have read the risks',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}