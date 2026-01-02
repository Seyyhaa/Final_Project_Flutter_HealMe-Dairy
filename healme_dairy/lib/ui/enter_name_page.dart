import 'package:flutter/material.dart';
import 'package:healme_dairy/models/users_pref.dart';
import 'package:healme_dairy/ui/healme_tab.dart';
import 'package:healme_dairy/ui/tabs/home_page.dart';

class EnterNamePage extends StatefulWidget {
  const EnterNamePage({super.key});

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  final TextEditingController _nameController = TextEditingController();
  void onSubmit() async {
    String nameInput = _nameController.text.trim();

    if (nameInput.isNotEmpty) {
      await UsersPref.saveName(nameInput);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HealmeTab(tabs: '',initialTab: AppTab.homeTab,)),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please Enter your Name')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HealMe Dairy', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Title(
              color: Colors.white,
              child: Text(
                'How should I call you?',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                 controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
             
              onPressed: onSubmit,
             
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Enter',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
