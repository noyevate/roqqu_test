
import 'package:flutter/material.dart';

class PinKeypadButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;

  const PinKeypadButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24), 
      child: Center(
        child: icon != null
            ? Icon(icon, size: 28, color: Colors.white)
            : Text(
                text!,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}