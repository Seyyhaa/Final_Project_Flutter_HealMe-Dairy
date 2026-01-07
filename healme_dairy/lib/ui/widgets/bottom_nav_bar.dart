import 'package:flutter/material.dart';
import 'buttom_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          NavBarItem(
            icon: Icons.add_circle_outline,
            label: 'Log',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          NavBarItem(
            icon: Icons.show_chart,
            label: 'Statistics',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          NavBarItem(
            icon: Icons.access_time,
            label: 'History',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}
