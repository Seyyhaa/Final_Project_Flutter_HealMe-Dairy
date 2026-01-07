import 'package:flutter/material.dart';
import 'package:healme_dairy/data/symptom_repository.dart';
import 'package:healme_dairy/models/log_item.dart';
import 'package:healme_dairy/ui/widgets/stat_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userLogs = SymptomRepository.getAll();
    final totalLogs = userLogs.length;
    final painLogs = userLogs.where((log) => log.severity != null).toList();
    double avgPain = 0.0;

    if (painLogs.isNotEmpty) {
      final sumSeverity = painLogs.fold(
        0,
        (sum, log) => sum + (log.severity ?? 0),
      );
      avgPain = sumSeverity / painLogs.length;
    }

    final symptomCount = userLogs
        .where((l) => l.logItem.type == Type.symptom)
        .length;
    final activityCount = userLogs
        .where((l) => l.logItem.type == Type.activity)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          "Health Overview",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.0,
                children: [
                  // Card 1: Total Logs
                  StatCard(
                    title: "Total Records",
                    value: totalLogs.toString(),
                    icon: Icons.history,
                    color: Colors.blue,
                  ),
                  StatCard(
                    title: "Avg Pain Level",
                    value: avgPain.toStringAsFixed(
                      1,
                    ), // Formats to 1 decimal (e.g. "4.5")
                    icon: Icons.sick,
                    color: Colors.redAccent,
                  ),
                  StatCard(
                    title: "Symptoms",
                    value: symptomCount.toString(),
                    icon: Icons.healing,
                    color: Colors.orange,
                  ),
                  StatCard(
                    title: "Activities",
                    value: activityCount.toString(),
                    icon: Icons.directions_run,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
