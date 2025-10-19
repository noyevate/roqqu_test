import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/home/presentation/widget/app_bar_widget.dart';
import 'package:roqqu_test/features/home/presentation/widget/coin_list_section.dart';
import 'package:roqqu_test/features/home/presentation/widget/custom_container.dart';
import 'package:roqqu_test/features/home/presentation/widget/stay_updated.dart';
import 'package:roqqu_test/features/shell/presentation/pages/main_shell.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.09),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(gradient: AppColors.hompageGradient),
          child: SafeArea(child: AppbarWidget()),
        ),
      ),
      body: HomeBody(
        onSeeMoreTapped: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false, 
              pageBuilder: (context, animation, secondaryAnimation) => const MainShell(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
      ), 
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.onSeeMoreTapped});
   final VoidCallback onSeeMoreTapped;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.5,
            decoration: BoxDecoration(gradient: AppColors.hompageGradient),
            child: Row(children: [Text("data")]),
          ),
          CustomContainer(
            containerContent: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Your GBP Balance", style: TextStyle( fontSize: 13, color: AppColors.tertiaryText),),
                    SizedBox(width: 5),
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.tertiaryText,
                      size: 15,
                    ),
                  ],
                ),
                SizedBox(height: 10),

                _buildAmountText(),

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.bottomContainerBackground,
                          border: Border.all(color: AppColors.innerBackground),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ActionsCircleAvatar(
                              screenHeight: screenHeight,
                              imageUrl: "assets/images/deposit_icon.png",
                              text: "Deposit",
                            ),
                            ActionsCircleAvatar(
                              screenHeight: screenHeight,
                              imageUrl: "assets/images/buy_icon.png",
                              text: "Buy",
                            ),
                            ActionsCircleAvatar(
                              screenHeight: screenHeight,
                              imageUrl: "assets/images/withdraw_icon.png",
                              text: "Withdraw",
                            ),
                            ActionsCircleAvatar(
                              screenHeight: screenHeight,
                              imageUrl: "assets/images/sell_icon.png",
                              text: "Sell",
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: onSeeMoreTapped,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: AppColors.bottomContainerBackground,
                            border: Border.all(color: AppColors.innerBackground),
                          ),
                          child: Text("See More", style: TextStyle(color: AppColors.accentBlue),),
                        ),
                      ),

                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(
                          // horizon,tal: 10,
                          // vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.copTradingAdGradient,
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.bottomContainerBackground,
                          border: Border.all(color: AppColors.innerBackground),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 1,
                              left: screenWidth / 1.3,
                              child: Image.asset("assets/images/copy_trading_crown.png"),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset("assets/images/copy_trading_crown.png", color: Colors.transparent,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Copy Trading", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.darkBackground),),
                                    
                                    Text("Discover our latest feature. Follow and watch\nthe PRO traders closely and win like a PRO!\nWe are rooting for you!", style: TextStyle(fontSize: 12, color: AppColors.darkBackground),)
                                  ],
                                ),
                              ),
                            ),
                            
                            
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stay Updated", style: TextStyle(fontWeight: FontWeight.bold, ),),
                          SizedBox(height: 10,),
                          StayUpdatedSection(),
                        ],
                      ),

                      CoinListSection()
                       
                    ],
                  ),
                ),

                 
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionsCircleAvatar extends StatelessWidget {
  const ActionsCircleAvatar({
    super.key,
    required this.screenHeight,
    required this.imageUrl,
    required this.text,
  });

  final double screenHeight;
  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: screenHeight * 0.03,
          backgroundColor: AppColors.darkBackground,
          child: Center(child: Image.asset(imageUrl)),
        ),
        SizedBox(height: 5),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class _buildAmountText extends StatelessWidget {
  const _buildAmountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
        ),
        children: [
          const TextSpan(
            text: '£0', 
            style: TextStyle(fontSize: 30       , height: 1.0),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Transform.translate(
              offset: const Offset(0, 2), 
              child: Text(
                '.00',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}