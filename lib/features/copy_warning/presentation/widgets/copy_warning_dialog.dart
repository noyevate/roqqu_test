import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/core/theme/gradient_button.dart';
import 'package:roqqu_test/features/enter_amount/presentation/pages/enter_amount_screen.dart';
import 'package:roqqu_test/features/risk_discloure/presentation/widgets/risk_disclosure_bottomsheet.dart';

class CopyWarningBottomSheet extends StatefulWidget {
  const CopyWarningBottomSheet({super.key});

  @override
  State<CopyWarningBottomSheet> createState() => _CopyWarningBottomSheetState();
}

class _CopyWarningBottomSheetState extends State<CopyWarningBottomSheet> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.bottomContainerBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ).copyWith(
                    bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    'assets/images/Important_Message.png',
                    height: screenHeight * 0.12,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Important message!',
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.bodyLarge?.copyWith(height: 1.5),
                      children: [
                        const TextSpan(
                          style: TextStyle(fontSize: 16),
                          text:
                              "Don't invest unless you're prepared and understand the risks involved in copy trading. ",
                        ),
                        TextSpan(
                          text: 'Learn more',
                          style: const TextStyle(
                            color: AppColors.accentBlue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) {
                                  return const RiskDisclosureBottomSheet();
                                },
                              );
                            },
                        ),
                        const TextSpan(text: ' about the risks.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _toggleCheckbox,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) => _toggleCheckbox(),
                          side: const BorderSide(
                            color: AppColors.tertiaryBackground,
                            width: 2,
                          ),
                          activeColor: AppColors.accentBlue,
                        ),
                        Expanded(
                          child: Text(
                            'Check this box to agree to Roqqu\'s copy trading policy',
                            style: textTheme.bodyLarge?.copyWith(
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isChecked
                      ? GradientButton(
                          text: 'Proceed to copy trade',
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EnterAmountScreen())),
                          
                        )
                      : Container(
                          width: double.infinity,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: AppColors.unselectedGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Proceed to copy trade',
                            style: textTheme.labelLarge?.copyWith(
                              color: Colors.white54,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
