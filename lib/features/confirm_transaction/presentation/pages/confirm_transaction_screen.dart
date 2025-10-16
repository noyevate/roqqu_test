import 'package:flutter/material.dart';
import 'package:roqqu_test/core/widget/custom_nav_bar_1.dart';
import 'package:roqqu_test/features/confirm_pin/presentation/pages/confirm_pin_screen.dart';
import 'package:roqqu_test/features/confirm_transaction/domain/entities/transaction_data.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/confirm_transaction/presentation/widget/transaction_detail_row.dart';

class ConfirmTransactionScreen extends StatelessWidget {
  final TransactionData transactionData;

  const ConfirmTransactionScreen({
    super.key,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm transaction'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06)
            .copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColors.bottomContainerBackground,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Image.asset("assets/images/US.png", height: 60, width: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'Copy trading amount',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '${transactionData.amount} USD',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 40, color: Colors.white12),
                  TransactionDetailRow(
                    label: 'PRO trader',
                    value: transactionData.proTraderName,
                  ),
                  TransactionDetailRow(
                    label: 'What you get',
                    value: '${transactionData.amountAfterFee} USD',
                  ),
                  TransactionDetailRow(
                    label: 'Transaction fee',
                    value: '${transactionData.fee.toStringAsFixed(2)} USD',
                  ),
                ],
              ),
            ),

          ],
        ),
        
      ),
      bottomNavigationBar: CustomNavBar1(onPressed: () {
        Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConfirmPinScreen(),
      ),
    );
      },text: "Confirm transaction",),
    );
  }
}