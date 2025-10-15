import 'package:flutter/material.dart';

class ProgressIndicatorBar extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const ProgressIndicatorBar({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 4.0,
            decoration: BoxDecoration(
              color: index == currentPage ? Colors.blueAccent : Colors.grey[800],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
      ),
    );
  }
}