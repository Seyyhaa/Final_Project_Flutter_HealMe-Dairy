import 'package:flutter/material.dart';
import 'package:healme_dairy/data/users_pref.dart';
import 'package:healme_dairy/ui/screens/enter_name_page.dart';
import 'package:healme_dairy/ui/screens/healme_tab.dart';

class SpashPage extends StatefulWidget {
  const SpashPage({super.key});

  @override
  State<SpashPage> createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> {
  @override
  void initState() {
    super.initState();
    checkUserName();
  }

  void checkUserName() async {
    await Future.delayed(const Duration(seconds: 2));
    String? userName = await UsersPref.getName();
    if (!mounted) return;
    if (userName != null && userName.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HealmeTab()),
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
          style: TextStyle(
            fontSize: 30,
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
