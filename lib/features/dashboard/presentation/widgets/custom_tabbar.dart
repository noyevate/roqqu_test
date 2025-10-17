import 'package:flutter/material.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';

class CustomTabBar extends StatefulWidget {
  final TabController controller;
  final List<String> tabs;

  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    // rebuild when tab changes or animation completes
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> tabWidths = [70, 120, 50, 90];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        border: Border(
          bottom: BorderSide(color: Color(0xFF22262B), width: 1),
        ),
      ),
      child: Row(
        children: List.generate(widget.tabs.length, (index) {
          final isActive = _controller.index == index;

          return SizedBox(
          width: tabWidths[index],
            child: GestureDetector(
              onTap: () {
                _controller.animateTo(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? Colors.white : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white54,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
