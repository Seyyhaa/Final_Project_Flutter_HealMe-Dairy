// import '../database/database_support.dart';
// import '../models/diagnostic_rule.dart';

// class LogicEngine {
//   final DatabaseSupport _db = DatabaseSupport.instance;

//   final Map<int, List<DiagnosticRule>> knowledgeBase = {
//     10: [
//       DiagnosticRule(
//         symptomId: 10,
//         checkItemId: 1,
//         threshold: 1,
//         mustBeHigher: false,
//         points: 60,
//         cause: 'Caffeine Withdrawal',
//       ),
//       DiagnosticRule(
//         symptomId: 10,
//         checkItemId: 2,
//         threshold: 2,
//         mustBeHigher: false,
//         points: 50,
//         cause: 'Dehydration',
//       ),
//     ],
//     11: [
//       DiagnosticRule(  
//         symptomId: 11,
//         checkItemId: 3,
//         threshold: 0,
//         mustBeHigher: true,
//         points: 80,
//         cause: 'Spicy Food Irritation',
//       ),
//       DiagnosticRule(
//         symptomId: 11,
//         checkItemId: 7,
//         threshold: 2,
//         mustBeHigher: true,
//         points: 40,
//         cause: 'Sugar Bloating',
//       ),
//     ],
//     12: [
//       DiagnosticRule(
//         symptomId: 12,
//         checkItemId: 5,
//         threshold: 0,
//         mustBeHigher: true,
//         points: 90,
//         cause: 'Blue Light Exposure',
//       ),
//       DiagnosticRule(
//         symptomId: 12,
//         checkItemId: 1,
//         threshold: 2,
//         mustBeHigher: true,
//         points: 60,
//         cause: 'Excess Caffeine',
//       ),
//     ],
//   };

//   Future<String> analyze(int symptomId) async {
//     final rules = knowledgeBase[symptomId];
//     String dailyResult = "No specific cause found based on today's logs.";
//     if (rules != null && rules.isNotEmpty) {
//       Map<String, int> scoreboard = {};
//       for (var rule in rules) {
//         int userCount = await _db.getCountToday(rule.checkItemId);

//         if (rule.evaluate(userCount)) {
//           int currentScore = scoreboard[rule.cause] ?? 0;
//           scoreboard[rule.cause] = currentScore + rule.points;
//         }
//       }
//       dailyResult = calculateVerdict(scoreboard);
//     }

//     String patternAdvice = await _checkLongTermPatterns(symptomId);
//     return "$dailyResult\n\n$patternAdvice";
//   }

//   Future<String> _checkLongTermPatterns(int symptomId) async {
//     int weeklyCount = await _db.getCountLast7Days(symptomId);
//     if (weeklyCount >= 3) {
//       return " CHRONIC PATTERN DETECTED\n"
//           "You have had this symptom $weeklyCount times this week.\n\n"
//           " Advice: ${_getAdvice(symptomId)}";
//     }

//     return "No chronic pattern detected (Happened $weeklyCount times this week).";
//   }

//   String _getAdvice(int id) {
//     switch (id) {
//       case 10:
//         return "Try tracking your sleep schedule and water intake more strictly. Consider seeing a doctor if this persists.";
//       case 11:
//         return "Avoid spicy foods for 3 days and try drinking warm tea. Check if you have a food allergy.";
//       case 12:
//         return "Turn off all screens 1 hour before bed. Your sleep schedule seems inconsistent.";
//       default:
//         return "Monitor this closely and consult a professional.";
//     }
//   }

//   String calculateVerdict(Map<String, int> scores) {
//     if (scores.isEmpty) {
//       return "Your logs look healthy! No specific triggers found today.";
//     }
//     var winner = scores.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));
//     var topCause = winner.first;
//     return "Most Likely Cause:\n${topCause.key}\n(Confidence: ${topCause.value}%)";
//   }
// }

import 'package:healme_dairy/models/diagnostic_rule.dart';
import 'package:healme_dairy/models/tracker_item.dart';
import '../database/database_support.dart';

class LogicEngine {
  final List<DiagnosisRule> _rules = [
    DiagnosisRule(
      symptomId: 10,
      activityId: 5,
      message:
          "Staring at screens (Late Phone) causes Digital Eye Strain, a common trigger for headaches.",
    ),
    DiagnosisRule(
      symptomId: 10,
      activityId: 1,
      message:
          "Caffeine is a diuretic. If you drink Coffee without enough water, dehydration can trigger a headache.",
    ),
    DiagnosisRule(
      symptomId: 11,
      activityId: 3,
      message:
          "Spicy foods contain capsaicin, which irritates the stomach lining and causes pain.",
    ),
    DiagnosisRule(
      symptomId: 11,
      activityId: 7,
      message: "Excess Sugar can cause bloating and inflammation in the gut.",
    ),

    DiagnosisRule(
      symptomId: 12,
      activityId: 1,
      message:
          "Caffeine stays in your system for 8 hours. Drinking Coffee late is a major cause of insomnia.",
    ),
    DiagnosisRule(
      symptomId: 12,
      activityId: 5,
      message:
          "Blue light from phones suppresses melatonin, making it hard to fall asleep.",
    ),
  ];



  Future<String> analyze(int symptomId) async {
    final db = DatabaseSupport.instance;
    for (var rule in _rules) {
  if (rule.symptomId == symptomId) {
    var logs = await db.getTodayLogsForActivity(rule.activityId);

    if (logs.isNotEmpty) {
      // Access object properties if needed
      return "Flash Detected: ${rule.message}";
    }
  }
}
    return await smartAnalysis(symptomId, db);
  }

}




Future<String> smartAnalysis(int symptomId, DatabaseSupport db) async {
  List<String> sickDays = await db.getDatesForSymptom(symptomId);
  int totalSickDays = sickDays.length;
  if (totalSickDays < 3) return "Not enough data yet.";

  Map<TrackerItem, int> suspectsOnSickDays = {};

  for (String date in sickDays) {
    var activities = await db.getActivitiesOnDate(date);
    for (var item in activities) {
      suspectsOnSickDays[item] = (suspectsOnSickDays[item] ?? 0) + 1;
    }
  }

  if (suspectsOnSickDays.isEmpty) return "No Enough Data to find the cause.";

  TrackerItem? primeSuspect;
  double highestRisk = 0;

  for (var entry in suspectsOnSickDays.entries) {
    TrackerItem item = entry.key;
    int sickCooccurrence = entry.value;
    var logs = await db.getLogsForItem(item.id);
    int totalHistory = logs.length;
    if (totalHistory == 0) continue;

    double risk = sickCooccurrence / totalHistory;
    double consistency = sickCooccurrence / totalSickDays;

    if (risk > highestRisk && consistency > 0.3) {
      highestRisk = risk;
      primeSuspect = item;
    }
  }

  if (primeSuspect == null) return "Analysis Inconclusive. No prime suspect found.";

  double riskPercent = (highestRisk * 100).toDouble();

  if (highestRisk > 0.75) {
    return "High Probability Trigger: ${primeSuspect.name}\n\n"
        "Pattern: When you log '${primeSuspect.name}', you report this symptom ${riskPercent.toStringAsFixed(0)}% of the time.\n"
        "Advice: Try avoiding it tomorrow.";
  } else if (highestRisk > 0.4) {
    return "Possible Link: ${primeSuspect.name}\n\n"
        "Pattern: There is a moderate connection (${riskPercent.toStringAsFixed(0)}%) between '${primeSuspect.name}' and this symptom.";
  } else {
    return "Analysis Inconclusive.\n\n"
        "Top Suspect: ${primeSuspect.name}, but the data is weak. Keep tracking!";
  }



}
