import 'package:flutter/material.dart';
import 'package:healme_dairy/models/users_pref.dart';
import 'package:healme_dairy/ui/enter_name_page.dart';
import 'package:healme_dairy/ui/healme_tab.dart';
// import 'package:healme_dairy/ui/tabs/home_page.dart';

class SpashPage extends StatefulWidget {
  const SpashPage({super.key});

  @override
  State<SpashPage> createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> {
  @override
  void initState() {
    super.initState();
    _checkUserName();
  }

  void _checkUserName() async {
    await Future.delayed(const Duration(seconds: 2));

    String? userName = await UsersPref.getName();

    if (!mounted) return;

    if (userName != null && userName.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const HealmeTab(tabs: '', initialTab: AppTab.homeTab),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EnterNamePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome, to HealMe Dairy ",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
