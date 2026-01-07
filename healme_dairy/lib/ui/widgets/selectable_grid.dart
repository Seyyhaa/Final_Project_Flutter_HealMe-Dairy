import 'package:flutter/material.dart';
import '../../models/log_item.dart';
import 'selectable_card.dart';

class SelectableGrid extends StatelessWidget {
  final List<LogItem> items;
  final Set<String> selected;
  final Function(String) onTap;

  const SelectableGrid({
    super.key,
    required this.items,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      padding: const EdgeInsets.all(16),
      children: items.map((item) {
        return SelectableCard(
          item: item,
          selected: selected.contains(item.label),
          onTap: () => onTap(item.label),
        );
      }).toList(),
    );
  }
}
