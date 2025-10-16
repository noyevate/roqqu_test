import 'dart:ffi';

class TransactionData {
  final int amount;
  final int fee;
  final String proTraderName;

  TransactionData({
    required this.amount,
    required this.fee,
    required this.proTraderName,
  });

  int get amountAfterFee => amount - fee;
}