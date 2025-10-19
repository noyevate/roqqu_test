import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryText,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text('Crypto', style: TextStyle(color: Colors.black)),
                Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black),
              ],
            ),
          ),

          Row(
            children: [
              Icon(Icons.search, color: AppColors.primaryBackground,),
              SizedBox(width: 20,),
              Image.asset("assets/images/headphones.png"),
              SizedBox(width: 20,),
              Stack(
                children: [
                  Positioned(
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: AppColors.appBarNotification,
                      radius: 5,
                    ),
                  ),
                  Image.asset("assets/images/Notification.png"),
                ],
              ),
              SizedBox(width: 20,),
              Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset("assets/images/US.png", height: 15, width: 15,),
                SizedBox(width: 5,),
                Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black),
              ],
            ),
          ),
            ],
          )
        ],
      ),
    );
  }
}
