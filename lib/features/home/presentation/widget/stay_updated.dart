import 'package:flutter/material.dart';
import 'notice_card.dart'; // Import the card widget

// Place the NoticeItem class here or in its own file
class NoticeItem {
  final String url;
  final String title;
  final String subtitle;
  final String? tag;
  final Color? tagColor;
  const NoticeItem({required this.url, required this.title, required this.subtitle, this.tag, this.tagColor});
}

class StayUpdatedSection extends StatefulWidget {
  const StayUpdatedSection({super.key});

  @override
  State<StayUpdatedSection> createState() => _StayUpdatedSectionState();
}

class _StayUpdatedSectionState extends State<StayUpdatedSection> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    const mainContentPadding = 10.0 * 1.9; 
    final cardWidthFraction = (screenWidth - mainContentPadding) / screenWidth;

    _pageController = PageController(
      viewportFraction: cardWidthFraction, 
    );

    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  final List<NoticeItem> _notices = const [
    NoticeItem(
      url: "assets/images/notication_2.png",
      title: 'Delisting coins',
      subtitle: 'View the list of coins we are delisting',
      tag: 'Urgent Notice',
      tagColor: Colors.redAccent,
    ),
    NoticeItem(
      url: "assets/images/coin_swap_icon.png",
      title: 'New Pairs Added',
      subtitle: 'Trade new and exciting crypto pairs',
      // tag: 'Announcement',
      tagColor: Colors.blueAccent,
    ),
    NoticeItem(
      url: "assets/images/notication_2.png",
      title: 'Security Update',
      subtitle: 'Update your app for the latest security',
      // tag: 'Important',
      tagColor: Colors.orange,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100, 
          child: PageView.builder(
            controller: _pageController,
            itemCount: _notices.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: NoticeCard(item: _notices[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_notices.length, (index) {
            return _PageIndicator(isActive: index == _currentPage);
          }),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;
  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 16.0 : 8.0, // Active dot is wider
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        // borderRadius: BorderRadius.circular(12),
        shape: BoxShape.circle
      ),
    );
  }
}