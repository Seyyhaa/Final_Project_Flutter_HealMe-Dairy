import 'package:flutter/material.dart';
// import 'package:healme_dairy/ui/enter_name_page.dart';
import 'package:healme_dairy/ui/spash_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpashPage(),
 ); }
}