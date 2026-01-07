import 'package:flutter/material.dart';
import 'package:healme_dairy/data/users_pref.dart';
import 'package:healme_dairy/ui/screens/healme_tab.dart';
import 'package:healme_dairy/ui/widgets/save_button.dart';

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
          MaterialPageRoute(builder: (context) => const HealmeTab()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('What should I call you?')));
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
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SaveButton(onPressed: onSubmit),
          ],
        ),
      ),
    );
  }
}
