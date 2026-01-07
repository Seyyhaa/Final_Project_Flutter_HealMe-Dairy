import 'package:flutter/material.dart';
import 'package:healme_dairy/ui/screens/log_detail_screen.dart';
import 'package:healme_dairy/ui/widgets/selectable_grid.dart';
import '../../models/log_item.dart';


class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
 final activities = [
  LogItem('Exercise', Icons.fitness_center, Type.activity),
  LogItem('Poor Sleep', Icons.bedtime, Type.activity),
  LogItem('Use Phone', Icons.phone_android, Type.activity),
  LogItem('Coffee', Icons.local_cafe, Type.activity),          
  LogItem('Skip Meal', Icons.fastfood, Type.activity),          
  LogItem('Stress', Icons.work, Type.activity),      
  LogItem('Alcohol', Icons.local_bar, Type.activity),          
  LogItem('Screen Time', Icons.computer, Type.activity),      
  LogItem('Late Night', Icons.nights_stay, Type.activity),
  LogItem('Junk Food', Icons.lunch_dining, Type.activity),
  LogItem('Long Sitting', Icons.chair, Type.activity),
];

  final selected = <String>{};

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Activities", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SelectableGrid(
        items: activities,
        selected: const {}, 
        onTap: (label) {
          final activity =
              activities.firstWhere((item) => item.label == label);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LogDetailScreen(symptom: activity),
            ),
          );
        },
      ),
    );
  }
}
