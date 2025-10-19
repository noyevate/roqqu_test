import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/confirm_pin/presentation/widget/pin_input_field.dart';
import 'package:roqqu_test/features/confirm_pin/presentation/widget/pin_keypad.dart';
import 'package:roqqu_test/features/transaction_success/presentaion/pages/transaction_success_screen.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  String _pin = '';
  bool _isObscured = true;
  final int _pinLength = 6;

  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'del') {
        _pin = _pin.isNotEmpty ? _pin.substring(0, _pin.length - 1) : '';
      } else if (_pin.length < _pinLength) {
        _pin += value;
      }
    });

    if (_pin.length == _pinLength) {
      print('PIN entered: $_pin');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const TransactionSuccessScreen(
            traderName: 'BTC Master', 
          ),
        ),
      );
    }
  }

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
            Image.asset("assets/images/padlock.png"),
            const SizedBox(height: 16),
            Text(
              'Confirm Transaction',
              style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Input your 6 digit transaction PIN to confirm your transaction and authenticate your request',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.04),
            ),
            const Spacer(flex: 1),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PinInputField(pin: _pin, isObscured: _isObscured),
                  const SizedBox(width: 16),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.bottomContainerBackground,
                      border: Border.all(color: AppColors.tertiaryBackground)
                    ),
                    child: Center(child: Image.asset('assets/images/Biometrics.png'))),
                  
                ],
              ),
            ),
            const Spacer(flex: 1),
            SizedBox(
              height: screenHeight * 0.4, 
              child: PinKeypad(onKeyPressed: _onKeyPressed),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot PIN?', style: TextStyle(color: AppColors.accentBlue)),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}