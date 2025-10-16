import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class InfoChip extends StatefulWidget {
  const InfoChip({super.key, required this.label});
  final String label;


  @override
  State<InfoChip> createState() => _InfoChipState();
}

class _InfoChipState extends State<InfoChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.infoChipColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
