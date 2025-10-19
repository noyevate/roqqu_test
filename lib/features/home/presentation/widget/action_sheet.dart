import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'action_list_item.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, 
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 15),
          decoration:  BoxDecoration(
            color: AppColors.darkBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)

            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Trade'),
                _buildSectionContainer(
                  children: const [
                    ActionListItem(icon: Icons.download, title: 'Buy'),
                    ActionListItem(icon: Icons.upload, title: 'Sell'),
                    ActionListItem(icon: Icons.swap_horiz, title: 'Swap'),
                    ActionListItem(icon: Icons.arrow_upward, title: 'Send'),
                    ActionListItem(icon: Icons.arrow_downward, title: 'Receive'),
                    ActionListItem(icon: Icons.pie_chart, title: 'Invest', isNew: true),
                  ],
                ),
                _buildSectionHeader('Earn'),
                _buildSectionContainer(
                  children: [
                    ActionListItem(icon: Icons.sync_alt, title: 'Roqq\'n\'roll', isNew: true),
                    ActionListItem(icon: Icons.savings_outlined, title: 'Savings'),
                    ActionListItem(icon: Icons.savings, title: 'Savings'),
                    ActionListItem(icon: Icons.flag_outlined, title: 'Missions', isNew: true),
                    ActionListItem(icon: Icons.copy, title: 'Copy trading', isNew: true, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
                    },),
                  ],
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white70)),
    );
  }
  
  Widget _buildSectionContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.bottomContainerBackground,
        
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }
}