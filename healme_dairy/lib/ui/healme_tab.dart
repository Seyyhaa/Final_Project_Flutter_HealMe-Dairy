import 'package:flutter/material.dart';
import 'package:healme_dairy/ui/tabs/history_page.dart';
import 'package:healme_dairy/ui/tabs/home_page.dart';
import 'package:healme_dairy/ui/tabs/log_page.dart';
import 'package:healme_dairy/ui/tabs/statistic_page.dart';

class HealmeTab extends StatefulWidget {
  const HealmeTab({super.key, required this.tabs, required this.initialTab});

  final String tabs;
  final AppTab initialTab;

  @override
  State<HealmeTab> createState() => _HealmeTabState();
}

enum AppTab { homeTab, logTab, statisticTab, historyTab }

class _HealmeTabState extends State<HealmeTab> {
  late AppTab _currentTab;
  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          HomePage(tab: widget.tabs),
          LogPage(tab: widget.tabs),
          StatisticPage(tab: widget.tabs),
          HistoryPage(tab: widget.tabs),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        currentIndex: _currentTab.index,
        onTap: (index) {
          setState(() {
            _currentTab = AppTab.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'log'),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_array_outlined),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
