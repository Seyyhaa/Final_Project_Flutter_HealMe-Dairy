import 'package:healme_dairy/models/tracker_item.dart';

class DailyLog {
  final int? id;
  final DateTime date;
  final TrackerItem item;  

  DailyLog({required this.id, required this.item, required this.date});

  factory DailyLog.fromMap(Map<String, dynamic> map) {
    return DailyLog(
      id: map['id'],
      date: DateTime.parse(map['date']),
      item: TrackerItem.fromMap(map), 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'item_id': item.id,
      'date': date.toIso8601String(),
    };
  }
}
