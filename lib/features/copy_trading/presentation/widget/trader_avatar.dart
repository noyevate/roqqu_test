import 'package:flutter/material.dart';

class TraderAvatar extends StatelessWidget {
  final String initials;
  final Color baseColor;
  final double radius; 

  const TraderAvatar({
    super.key,
    required this.initials,
    required this.baseColor,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    
    final double borderThickness = radius * 0.1; 
    final double fontSize = radius * 0.8; 
    final double badgeSize = radius * 0.75; 

    final HSLColor hslColor = HSLColor.fromColor(baseColor);
    

    return Stack(
      clipBehavior: Clip.none, 
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            
            border: Border.all(
              color: baseColor,
              width: borderThickness,
            ),
          ),
          
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: baseColor.withOpacity(0.3)
              
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -badgeSize * 0.1, 
          right: -badgeSize * 0.1, 
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6A4DFF), 
            ),
            child: Image.asset("assets/images/bage_pro.png", height: 100, width: 100,)
            
           
          ),
        ),
      ],
    );
  }
}