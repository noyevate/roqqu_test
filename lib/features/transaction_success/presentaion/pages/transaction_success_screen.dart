import 'package:flutter/material.dart';
import 'package:roqqu_test/core/widget/custom_nav_bar_1.dart';
import 'package:roqqu_test/features/copy_trading/presentation/pages/copy_trading_screen.dart';

class TransactionSuccessScreen extends StatelessWidget {
  final String traderName;

  const TransactionSuccessScreen({
    super.key,
    required this.traderName,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06)
            .copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/success_icon.png',
                height: screenHeight * 0.15,
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Trade copied successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'You have successfully copied $traderName\'s trade.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: screenWidth * 0.04,
                  height: 1.5,
                ),
              ),
          
          
          
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar1(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CopyTradingScreen()));
      }, text: 'Go to dashboard',),
    );
  }
}