import 'package:flutter/material.dart';

class CopyTradingBanner extends StatelessWidget {
  const CopyTradingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF6DD5FA), Color(0xFF2980B9)]),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Copy Trading', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('Discover our latest feature. Follow and watch the PRO traders closely and win like a PRO! We are rooting for you!'),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset('assets/images/crown_icon.png', height: 80),
        ],
      ),
    );
  }
}