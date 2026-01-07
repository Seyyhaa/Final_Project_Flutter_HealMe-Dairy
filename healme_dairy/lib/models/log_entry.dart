import 'package:uuid/uuid.dart';
import 'log_item.dart';

class LogEntry {
  final String id;
  final String title;
  final String descriptions;
  final DateTime date;
  final LogItem logItem;
  final int? severity;

  LogEntry({
    String? id,             
    required this.title,
    this.severity,
    required this.date,
    required this.logItem,
    this.descriptions = "",
  }) : id = id ?? const Uuid().v4(); 
}

// EntryLog l = EntryLog(title: title, date: date, logItem: logItem)



