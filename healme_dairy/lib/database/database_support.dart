import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tracker_item.dart';

class DatabaseSupport {
  static final DatabaseSupport instance = DatabaseSupport._init();
  static Database? _database;

  DatabaseSupport._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('healme_final_v1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tracker_items (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        type TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE daily_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        item_id INTEGER, 
        date TEXT, 
        FOREIGN KEY (item_id) REFERENCES tracker_items (id) ON DELETE CASCADE
      )
    ''');

    await _seedItems(db);
  }

  Future<void> _seedItems(Database db) async {
    final List<Map<String, dynamic>> items = [
      {'id': 1, 'name': 'Coffee', 'type': 'Activity'},
      {'id': 2, 'name': 'Water', 'type': 'Activity'},
      {'id': 3, 'name': 'Spicy Food', 'type': 'Activity'},
      {'id': 4, 'name': 'Good Sleep', 'type': 'Activity'},
      {'id': 5, 'name': 'Late Phone', 'type': 'Activity'},
      {'id': 7, 'name': 'Sugar', 'type': 'Activity'},
      
      {'id': 10, 'name': 'Headache', 'type': 'Symptom'},
      {'id': 11, 'name': 'Stomach Pain', 'type': 'Symptom'},
      {'id': 12, 'name': 'Insomnia', 'type': 'Symptom'},
    ];

    for (var item in items) {
      await db.insert('tracker_items', item, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }


  Future<List<TrackerItem>> getItems() async {
    final db = await instance.database;
    final result = await db.query('tracker_items');
    return result.map((json) => TrackerItem.fromMap(json)).toList();
  }

  Future<bool> logItem(TrackerItem item) async {
    final db = await instance.database;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    
    // Prevent duplicate symptoms on the same day
    if (item.type == 'Symptom') {
      final check = await db.rawQuery(
        "SELECT COUNT(*) FROM daily_logs WHERE item_id = ? AND date LIKE ?",
        [item.id, '$today%']
      );
      int count = Sqflite.firstIntValue(check) ?? 0;
      if (count > 0) return false; 
    }
    
    await db.insert('daily_logs', {
      'item_id': item.id,
      'date': DateTime.now().toIso8601String(),
    });
    
    return true; 
  }

  Future<List<Map<String, dynamic>>> getHistoryLogs() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT 
        daily_logs.id, 
        daily_logs.item_id, 
        daily_logs.date, 
        tracker_items.name, 
        tracker_items.type 
      FROM daily_logs 
      JOIN tracker_items ON daily_logs.item_id = tracker_items.id 
      ORDER BY daily_logs.date DESC
      LIMIT 100
    ''');
  }

  Future<void> deleteLog(int id) async {
    final db = await instance.database;
    await db.delete('daily_logs', where: 'id = ?', whereArgs: [id]);
  }

  // --- 2. UI SUPPORT METHODS ---

  // For LogPage Green/Red buttons
  Future<Map<int, int>> getTodayCounts() async {
    final db = await instance.database;
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final result = await db.rawQuery(
      'SELECT item_id, COUNT(*) as count FROM daily_logs WHERE date LIKE ? GROUP BY item_id',
      ['$today%']
    );

    Map<int, int> counts = {};
    for (var row in result) {
      counts[row['item_id'] as int] = row['count'] as int;
    }
    return counts;
  }

  // For Home Page Warnings
  Future<List<Map<String, dynamic>>> getTodaySymptoms() async {
    final db = await instance.database;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return await db.rawQuery('''
      SELECT daily_logs.id, tracker_items.name, tracker_items.id as item_id, daily_logs.date
      FROM daily_logs
      JOIN tracker_items ON daily_logs.item_id = tracker_items.id
      WHERE tracker_items.type = 'Symptom' 
      AND daily_logs.date LIKE '$today%'
      ORDER BY daily_logs.date DESC
    ''');
  }


  Future<int> getCountToday(int itemId) async {
    final db = await instance.database;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    
    final result = await db.rawQuery(
      "SELECT COUNT(*) FROM daily_logs WHERE item_id = ? AND date LIKE ?",
      [itemId, '$today%'],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  
  Future<List<String>> getDatesForSymptom(int itemId) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      "SELECT date FROM daily_logs WHERE item_id = ?",
      [itemId]
    );
    return result.map((row) => (row['date'] as String).substring(0, 10)).toList();
  }

  Future<List<Map<String, dynamic>>> getActivitiesOnDate(String dateStr) async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT t.name, t.id 
      FROM daily_logs d
      JOIN tracker_items t ON d.item_id = t.id
      WHERE d.date LIKE ? AND t.type = 'Activity'
    ''', ['$dateStr%']);
  }

  Future<int> getGlobalFrequency(int itemId) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM daily_logs WHERE item_id = ?', 
      [itemId]
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
  Future<List<Map<String, dynamic>>> getStats(String filter) async {
    final db = await instance.database;
    String whereClause = "";
    
    if (filter == 'Today') {
      String today = DateTime.now().toIso8601String().substring(0, 10);
      whereClause = "WHERE daily_logs.date LIKE '$today%'";
      
    } else if (filter == 'Weekly') {
      String sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7)).toIso8601String();
      whereClause = "WHERE daily_logs.date >= '$sevenDaysAgo'";
    }
    
    return await db.rawQuery('''
      SELECT tracker_items.name, tracker_items.type, COUNT(daily_logs.id) as frequency
      FROM daily_logs
      JOIN tracker_items ON daily_logs.item_id = tracker_items.id
      $whereClause
      GROUP BY tracker_items.id
      ORDER BY frequency DESC
    ''');

  }

  Future<void> restoreLog(int id, int itemId, String date) async {
    final db = await instance.database;
    await db.insert('daily_logs', {
      'id': id, 
      'item_id': itemId,
      'date': date
    });
  }
}