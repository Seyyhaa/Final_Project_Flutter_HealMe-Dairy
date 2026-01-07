import 'package:flutter/material.dart';
enum Type { 
  symptom(color: Colors.red, icon: Icons.healing),
  activity(color: Colors.green, icon: Icons.directions_run);
  final Color color;
  final IconData icon;
  const Type({required this.color, required this.icon});
}

class LogItem {
  final String label;
  final IconData icon;
  final Type type;
  LogItem(this.label, this.icon, this.type);
}




