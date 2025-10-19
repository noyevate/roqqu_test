import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for keyboard input formatters
import 'package:intl/intl.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';
import 'package:roqqu_test/core/utils/string_to_int.dart';
import 'package:roqqu_test/features/confirm_transaction/domain/entities/transaction_data.dart';
import 'package:roqqu_test/features/confirm_transaction/presentation/pages/confirm_transaction_screen.dart';
import 'package:roqqu_test/features/enter_amount/presentation/widget/enter_amout_text_field.dart';

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({super.key});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  // Controller to manage the TextField's state
  final TextEditingController _amountController = TextEditingController(text: '0');
  // FocusNode to control the keyboard's visibility
  final FocusNode _focusNode = FocusNode();
  
  // Mock balance data
  final double _balance = 240.73;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      setState(() {}); // This will trigger a rebuild
    });


  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onUseMaxPressed() {
    _amountController.text = _balance.toStringAsFixed(0);
    _amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: _amountController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final String currentAmountText = _amountController.text.isEmpty ? '0' : _amountController.text;
    final int enteredAmount = safeIntParse(currentAmountText); 
    final double transactionFee = enteredAmount * 0.01;
    final bool canContinue = enteredAmount > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter amount', style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w600, fontSize: 15),),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              side: BorderSide(color: AppColors.tertiaryBackground),
              backgroundColor: AppColors.bottomContainerBackground,
              avatar: Image.asset("assets/images/US.png", height: 15, width: 15,),
              labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: const Row(
                children: [Text('USD ', style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w600, fontSize: 15),), Icon(Icons.keyboard_arrow_down, size: 16)],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
         
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: EnterAmoutTextField(amountController: _amountController, focusNode: _focusNode),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06)
                .copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                const Spacer(), 
                Text(
                  '$currentAmountText USD',
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                if (canContinue)
                  Chip(
                    side: BorderSide(color: AppColors.tertiaryBackground),
                    label: Text(
                      'Transaction fee (1%) - ${transactionFee.toStringAsFixed(2)}USD',
                      style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    backgroundColor: AppColors.bottomContainerBackground,
                  ),
                const Spacer(),                 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.009),
                  decoration: BoxDecoration(
                    color: AppColors.bottomContainerBackground,
                    border: Border.all(color: AppColors.tertiaryBackground),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('USD Balance', style: TextStyle(color: Colors.white70)),
                          Text(
                            NumberFormat.currency(locale: 'en_US', symbol: '\$').format(_balance),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: _onUseMaxPressed,
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.innerBackground,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text('Use Max', style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w400,),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                canContinue
                    ? GradientButton(text: 'Continue', onPressed: () {
                       final data = TransactionData(
      amount: enteredAmount,
      fee: safeIntParse(transactionFee),
      proTraderName: 'BTC Master', // This would come from the previous screen's data
    );
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmTransactionScreen(
          transactionData: data,
        ),
      ),
    );
                        print('Continue with amount: $currentAmountText');
                      })
                    : Container(
                        width: double.infinity,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Continue',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white54),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
