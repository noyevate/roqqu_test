import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterAmoutTextField extends StatelessWidget {
  const EnterAmoutTextField({
    super.key,
    required TextEditingController amountController,
    required FocusNode focusNode,
  }) : _amountController = amountController, _focusNode = focusNode;

  final TextEditingController _amountController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      focusNode: _focusNode,
      autofocus: false,
      keyboardType: TextInputType.number, 
      inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
      enableSuggestions: false,
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }
}