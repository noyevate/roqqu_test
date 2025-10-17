import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';
import 'package:roqqu_test/core/widget/custom_nav_bar_1.dart';
import 'package:roqqu_test/features/risk_profile/presentation/pages/risk_profile_screen.dart';
import '../widgets/onboarding_page_content.dart';
import '../widgets/progress_indicator_bar.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Do less, Win more",
      "subtitle":
          "Streamline your approach to trading and increase your winning potential effortlessly.",
      "image": "assets/images/onboarding_1.png",
    },
    {
      "title": "Copy PRO traders",
      "subtitle":
          "Leverage expert strategies from professional traders to boost your trading results.",
      "image": "assets/images/onboarding_2.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () {
            // Handle back navigation
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Copy trading',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
             SizedBox(height: 16),
            ProgressIndicatorBar(
              pageCount: onboardingData.length,
              currentPage: _currentPage,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPageContent(
                    title: onboardingData[index]['title']!,
                    subtitle: onboardingData[index]['subtitle']!,
                    imagePath: onboardingData[index]['image']!,
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle "Watch video" action
              },
              child: const Text(
                'Watch a how to video',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar1(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RiskProfileScreen()));
      }),
    );
  }
}
