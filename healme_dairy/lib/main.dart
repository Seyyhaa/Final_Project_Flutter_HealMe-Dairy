import 'package:flutter/material.dart';
import 'package:healme_dairy/ui/enter_name_page.dart';
import 'package:healme_dairy/ui/spash_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EnterNamePage(),
 ); }
}