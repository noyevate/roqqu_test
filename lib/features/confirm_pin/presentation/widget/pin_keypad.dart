import 'package:flutter/material.dart';

import 'pin_keypad_button.dart';

class PinKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  const PinKeypad({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      children: [
        PinKeypadButton(text: '1', onTap: () => onKeyPressed('1')),
        PinKeypadButton(text: '2', onTap: () => onKeyPressed('2')),
        PinKeypadButton(text: '3', onTap: () => onKeyPressed('3')),
        PinKeypadButton(text: '4', onTap: () => onKeyPressed('4')),
        PinKeypadButton(text: '5', onTap: () => onKeyPressed('5')),
        PinKeypadButton(text: '6', onTap: () => onKeyPressed('6')),
        PinKeypadButton(text: '7', onTap: () => onKeyPressed('7')),
        PinKeypadButton(text: '8', onTap: () => onKeyPressed('8')),
        PinKeypadButton(text: '9', onTap: () => onKeyPressed('9')),
        PinKeypadButton(text: '.', onTap: () => onKeyPressed('.')),
        PinKeypadButton(text: '0', onTap: () => onKeyPressed('0')),
        PinKeypadButton(icon: Icons.arrow_back, onTap: () => onKeyPressed('del')),
      ],
    );
  }
}