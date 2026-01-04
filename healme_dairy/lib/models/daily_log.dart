class DailyLog {
  final int id;
  final DateTime date;
  final int itemId;

  DailyLog({required this.id, required this.itemId, required this.date});



  factory DailyLog.fromMap(Map<String, dynamic> map) {
    return DailyLog(
      id: map['id'],
      itemId: map['item_id'], 
      date: DateTime.parse(map['date']), 
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_id': itemId, 
      'date': date.toIso8601String(), 
    };
  }
}


