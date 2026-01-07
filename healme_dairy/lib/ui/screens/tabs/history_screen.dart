import 'package:flutter/material.dart';

import 'package:healme_dairy/data/symptom_repository.dart';
import 'package:healme_dairy/models/log_item.dart';
import 'package:healme_dairy/ui/widgets/empty_widget.dart';
import '../../../models/log_entry.dart';
import '../../widgets/card_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';
  List<LogEntry> latestSymptoms = [];

  @override
  void initState() {
    super.initState();
    loadLatestSymptoms();
  }

  void loadLatestSymptoms() {
    setState(() {
      latestSymptoms = SymptomRepository.getLatestLog();
    });
  }

  bool _isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

 
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return "Today";
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(date, yesterday)) {
      return "Yesterday";
    }

    return "${date.day}/${date.month}/${date.year}"; 
  }

  @override
  Widget build(BuildContext context) {
    List<LogEntry> filteredLogs = latestSymptoms.where((log) {
      if (_selectedFilter == 'Symptoms') {
        return log.logItem.type == Type.symptom;
      }
      if (_selectedFilter == 'Activities') {
        return log.logItem.type == Type.activity;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          "History Log",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, 
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView( 
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['All', 'Symptoms', 'Activities'].map((filter) {
                bool isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedFilter = filter),
                    selectedColor: Colors.blue.shade100,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Colors.grey.shade300
                      )
                    ),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue.shade800 : Colors.black54,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredLogs.isEmpty 
              ? const EmptyWidget( title: 'No History Found',subtitle: '',icon: Icons.history,) 
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs[index];
                    bool showDate = index == 0 || 
                        !_isSameDay(filteredLogs[index - 1].date, log.date);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showDate)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                            child: Text(
                              _formatDate(log.date),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        CardWidget(logEntry: log),
                      ],
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}