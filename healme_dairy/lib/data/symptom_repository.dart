import 'package:flutter/material.dart';
import 'package:healme_dairy/models/log_item.dart';

import '../models/log_entry.dart';

class SymptomRepository {
  static final List<LogEntry> _logs = [...mockLogs];
  static LogEntry? _lastDeleted;

  /// CREATE
  static void addLog(LogEntry log) {
    _logs.add(log);
  }

  /// READ all logs
  static List<LogEntry> getAll() {
    _logs.sort((a, b) => b.date.compareTo(a.date));
    return List.from(_logs);
  }

  /// READ latest logs
  static List<LogEntry> getLatestLog({int limit = 3}) {
    _logs.sort((a, b) => b.date.compareTo(a.date));
    return _logs.take(limit).map((log) => log).toList();
  }


  static List<LogEntry> getLastestSymptomLog({int limit = 3}) {
    final symptomLog = _logs
        .where((log) => log.logItem.type == Type.symptom)
        .toList();

    symptomLog.sort((a, b) => b.date.compareTo(a.date));

    return symptomLog.take(limit).toList();
  }


  static List<LogEntry> getAllSymptomLog() {
    final symptomLog = _logs
        .where((log) => log.logItem.type == Type.symptom)
        .toList();

    symptomLog.sort((a, b) => b.date.compareTo(a.date));

    return symptomLog.toList();
  }



  static LogEntry? getById(String id) {
    try {
      return _logs.firstWhere((log) => log.id == id);
    } catch (_) {
      return null;
    }
  }



  static bool updateLog(String id, LogEntry newLog) {
    for (int i = 0; i < _logs.length; i++) {
      if (_logs[i].id == id) {
        _logs[i] = newLog;
        return true;
      }
    }
    return false;
  }


static bool deleteLog(String id) {
  try {
    final log = _logs.firstWhere((l) => l.id == id);
    _lastDeleted = log;   
    _logs.remove(log);
    return true;
  } catch (_) {
    return false;
  }
}


static bool undoDelete() {
  if (_lastDeleted == null) return false;

  _logs.add(_lastDeleted!);
  _logs.sort((a, b) => b.date.compareTo(a.date));

  _lastDeleted = null;
  return true;
}



  static bool hasData() => _logs.isNotEmpty;

  static void clearAll() => _logs.clear();


}



// Sample LogItems
final headache = LogItem('Headache', Icons.healing, Type.symptom);
final fever = LogItem('Fever', Icons.thermostat, Type.symptom);
final exercise = LogItem('Exercise', Icons.fitness_center, Type.activity);
final drinkWater = LogItem('Drink Water', Icons.local_drink, Type.activity);

// Generate mock LogEntries
final List<LogEntry> mockLogs = [
  LogEntry(
    title: 'Morning Headache',
    logItem: headache,
    date: DateTime.now().subtract(const Duration(hours: 2)),
    severity: 7,
    descriptions: 'Throbbing pain in the morning',
  ),
  LogEntry(
    title: 'Fever in Afternoon',
    logItem: fever,
    date: DateTime.now().subtract(const Duration(hours: 5)),
    severity: 5,
    descriptions: 'Temperature around 38°C',
  ),
  LogEntry(
    title: 'Morning Run',
    logItem: exercise,
    date: DateTime.now().subtract(const Duration(hours: 3)),
    descriptions: 'Ran 3 km in 25 min',
  ),
  LogEntry(
    title: 'Drink Water',
    logItem: drinkWater,
    date: DateTime.now().subtract(const Duration(hours: 1)),
    descriptions: 'Drank 500ml water',
  ),
  LogEntry(
    title: 'Evening Headache',
    logItem: headache,
    date: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    severity: 4,
    descriptions: 'Mild headache after work',
  ),
];
