import 'package:flutter/material.dart';
import 'tabs/home_screen.dart';
import 'tabs/log_screen.dart';
import 'tabs/statistics_screen.dart';
import 'tabs/history_screen.dart';

class HealmeTab extends StatefulWidget {
  const HealmeTab({super.key});

  @override
  State<HealmeTab> createState() => _HealmeTabState();
}

class _HealmeTabState extends State<HealmeTab> {
  int _index = 0;

  final screens = const [
    HomeScreen(),
    LogScreen(),
    StatisticsScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        currentIndex: _index,
        onTap: (newIndex) {
          setState(() {
            _index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
