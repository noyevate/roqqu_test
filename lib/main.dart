import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_theme.dart';
import 'package:roqqu_test/features/onboarding/presentation/pages/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roqq_',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      
      home: OnboardingScreen(),
    );
  }
}


