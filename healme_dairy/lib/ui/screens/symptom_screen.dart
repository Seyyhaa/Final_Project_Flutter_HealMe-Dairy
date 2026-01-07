import 'package:flutter/material.dart';

import '../../models/log_item.dart';
import '../widgets/selectable_grid.dart';
import 'log_detail_screen.dart';

class SymptomScreen extends StatelessWidget {
  const SymptomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final symptoms = [
      LogItem("Headache", Icons.psychology, Type.symptom),
      LogItem('Stomachache', Icons.sick, Type.symptom),
      LogItem('Fatigue', Icons.battery_alert, Type.symptom),
      LogItem('Body Pain', Icons.accessibility_new, Type.symptom),
      LogItem('Nausea', Icons.sentiment_dissatisfied, Type.symptom), 
      LogItem('Dizziness', Icons.explore, Type.symptom),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Symptoms", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SelectableGrid(
        items: symptoms,
        selected: const {},
        onTap: (label) {
          final symptom = symptoms.firstWhere((item) => item.label == label);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LogDetailScreen(symptom: symptom),
            ),
          );
        },
      ),
    );
  }
}
