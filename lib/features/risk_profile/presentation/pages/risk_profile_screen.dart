import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';
import 'package:roqqu_test/core/widget/custom_nav_bar_1.dart';
import 'package:roqqu_test/features/copy_trading/presentation/pages/copy_trading_screen.dart';
import 'package:roqqu_test/features/risk_profile/domain/entities/risk_profile.dart';
import 'package:roqqu_test/features/risk_profile/presentation/widget/risk_profile_card.dart';

class RiskProfileScreen extends StatefulWidget {
  const RiskProfileScreen({super.key});

  @override
  State<RiskProfileScreen> createState() => _RiskProfileScreenState();
}

class _RiskProfileScreenState extends State<RiskProfileScreen> {
  int _selectedProfileIndex = 0;

  final List<RiskProfile> _profiles = const [
    RiskProfile(
      title: 'Conservative profile',
      description: 'Conservative profile involves stable returns from proven strategies with minimal volatility.',
    ),
    RiskProfile(
      title: 'Steady growth profile',
      description: 'Steady growth involves balanced gains with moderate fluctuations in strategy performance.',
    ),
    RiskProfile(
      title: 'Exponential growth profile',
      description: 'It has potentials for significant gains or losses due to aggressive trading and market exposure.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
      title: const Text('Copy trading'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Text(
              'What risk level are you comfortable exploring?',
              style: textTheme.displayLarge?.copyWith(fontSize: 24),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Choose a level',
              style: textTheme.bodyLarge,
            ),
            SizedBox(height: screenHeight * 0.04),
            Expanded(
              child: ListView.separated(
                itemCount: _profiles.length,
                separatorBuilder: (context, index) =>  SizedBox(height: screenHeight * 0.025),
                itemBuilder: (context, index) {
                  final profile = _profiles[index];
                  return RiskProfileCard(
                    title: profile.title,
                    description: profile.description,
                    isSelected: _selectedProfileIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedProfileIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      
      ),

      bottomNavigationBar: CustomNavBar1(onPressed: () {
        print('Selected profile: ${_profiles[_selectedProfileIndex].title}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => CopyTradingScreen()));
      }),
      
    );
  }
}
