import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});
  

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.13, 
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BottomAppBar(
            color: AppColors.bottomContainerBackground,
            shape: const CircularNotchedRectangle(), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem("assets/images/home.png", 'Home', 0, hasNotification: true),
                _buildNavItem("assets/images/wallet.png", 'Wallet', 1),
                const SizedBox(width: 48), 
                _buildNavItem("assets/images/transaction.png", 'History', 3),
                _buildNavItem("assets/images/profile.png", 'Profile', 4),
              ],
            ),
          ),
          Positioned(
            top: screenHeight / 5000,
            child: Container(
              height: 64,
              width: 64,
              
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Image.asset("assets/images/floating_action.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String imageAssetPath, String label, int index, {bool hasNotification = false}) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  imageAssetPath,
                  height: 24, 
                  width: 24,  
                  color: isSelected ? Colors.white : Colors.white70, 
                ),
                if (hasNotification)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.bottomContainerBackground, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}