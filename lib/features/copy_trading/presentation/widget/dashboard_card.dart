import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final String url;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient, required this.url,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: gradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:AppColors.darkBackground,
            ),
            child: Image.asset(url),
          ),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.darkBackground)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.darkBackground), overflow: TextOverflow.ellipsis,)),
              const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.darkBackground),
            ],
          ),
        ],
      ),
    );
  }
}