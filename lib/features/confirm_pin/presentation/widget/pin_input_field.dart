import 'package:flutter/material.dart';

class PinInputField extends StatelessWidget {
  final String pin;
  final bool isObscured;
  final int pinLength;

  const PinInputField({
    super.key,
    required this.pin,
    this.isObscured = true,
    this.pinLength = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pinLength, (index) {
          bool hasValue = index < pin.length;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasValue ? Colors.white : Colors.white.withOpacity(0.2),
            ),
            child: isObscured || !hasValue
                ? null
                : Center(
                    child: Text(
                      pin[index],
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}