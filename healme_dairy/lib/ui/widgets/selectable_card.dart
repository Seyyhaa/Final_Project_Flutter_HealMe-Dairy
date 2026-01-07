import 'package:flutter/material.dart';
import '../../models/log_item.dart';

class SelectableCard extends StatelessWidget {
  final LogItem item;
  final bool selected;
  final VoidCallback onTap;

  const SelectableCard({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Colors.blueAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 40, color: selected ? Colors.white : Colors.black),
            const SizedBox(height: 10),
            Text(
              item.label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
