import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class ActionListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isNew;
  final void Function()? onTap;
  

  const ActionListItem({
    super.key,
    required this.icon,
    required this.title,
    this.isNew = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.accentBlue.withOpacity(0.1),
              child: Icon(icon, color: AppColors.accentBlue, size: 20),
            ),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            const Spacer(),
            if (isNew)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('New', style: TextStyle(color: Colors.orange, fontSize: 12)),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}