import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color darkBackground = Color(0xFF1C2127);
  static const Color primaryText = Colors.white;
  static const Color secondaryText = Color(0xFF9E9E9E);
  static const Color bottomContainerBackground = Color(0xFF20252B);
  static const Color tertiaryBackground = Color(0xFF262932);
  static const Color primaryBackground = Color(0xFF1C2127);
  static const Color tertiaryText = Color(0xFFA7B1BC);
  static const Color infoChipColor = Color.fromRGBO(167, 177, 188, 0.08);
  static const Color innerBackground = Color(0xFF2A2F36);
  static const Color homepageAppbarCryptoBg = Color.fromRGBO(118, 118, 128, 0.5);
  static const Color appBarNotification = Color(0xffF04438);

// rgba(118, 118, 128, 0.12)


  
  static const Color primaryGradientStart = Color(0xFF6A3DFF);
  static const Color primaryGradientEnd = Color(0xFFF23D78);

  static const Color accentBlue = Color(0xFF85D1F0);
  static const Color inactiveGrey = Color(0xFF424242);

  static LinearGradient get dashboardLinearGradient => const LinearGradient(
        colors: [Color(0xffABE2F3), Color(0xffBDE4E5), Color(0xffEBE9D0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.5, 1.0],
      );

      static LinearGradient get dashboardLinearGradient_2 => const LinearGradient(
        colors: [Color(0xffC0CFFE), Color(0xffF3DFF4), Color(0xffF9D8E5)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.5, 1.0],
      );

      static LinearGradient get unselectedGradient => const LinearGradient(
        colors: [Color.fromRGBO(221, 86, 141, 1), Color.fromRGBO(120, 71, 225, 1), Color.fromRGBO(62, 50, 193, 1)],
        begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        stops: [0.0, 0.5, 1.0],
      );

      static LinearGradient get hompageGradient => const LinearGradient(
        colors: [Color(0xffC0CFFE), Color(0xffF3DFF4), Color(0xffF9D8E5)]
      );

      static LinearGradient get copTradingAdGradient => const LinearGradient(
        colors: [Color(0xffABE2F3), Color(0xffBDE4E5), Color(0xffEBE9D0)]
      );

      static LinearGradient get floatingAcctionLinearGradient => const LinearGradient(
        colors: [Color(0xff2764FFE), Color(0xff1D3573), Color(0xffF9D8E5)],
        begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
      );
}