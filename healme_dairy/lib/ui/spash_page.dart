import 'package:flutter/material.dart';
import 'package:healme_dairy/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacementNamed(context, "/home");
    // });

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MyApp())
    );

    return Scaffold(
      body: Center(
        child: Text("My App", style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
