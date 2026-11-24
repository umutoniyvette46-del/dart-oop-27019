import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  // STATIC: These starter goals are inserted once when the goals table is made.
  static const List<Map<String, Object>> _initialGoals = [
    {'subject': 'Mathematics', 'hours': 2.0, 'done': 0},
    {'subject': 'Biology', 'hours': 1.5, 'done': 0},
    {'subject': 'English', 'hours': 1.0, 'done': 0},
  ];

  Future<Database> initDatabase() async {
    if (_database != null) return _database!;

    final databaseDirectory = await getDatabasesPath();
    final databasePath = join(databaseDirectory, 'goals.db');
    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE goals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            subject TEXT NOT NULL,
            hours REAL NOT NULL,
            done INTEGER NOT NULL
          )
        ''');

        final batch = database.batch();
        for (final goal in _initialGoals) {
          batch.insert('goals', goal);
        }
        await batch.commit(noResult: true);
      },
    );
    return _database!;
  }

  Future<int> insertGoal(Map<String, dynamic> goal) async {
    final database = await initDatabase();
    return database.insert('goals', {
      'subject': goal['subject'] as String,
      'hours': (goal['hours'] as num).toDouble(),
      'done': goal['done'] == true ? 1 : 0,
    });
  }

  Future<List<Map<String, dynamic>>> getGoals() async {
    final database = await initDatabase();
    final rows = await database.query('goals', orderBy: 'id ASC');
    return rows
        .map(
          (row) => <String, dynamic>{
            'id': row['id'] as int,
            'subject': row['subject'] as String,
            'hours': (row['hours'] as num).toDouble(),
            'done': row['done'] == 1,
          },
        )
        .toList();
  }

  Future<int> updateGoal(Map<String, dynamic> goal) async {
    final database = await initDatabase();
    return database.update(
      'goals',
      {
        'subject': goal['subject'] as String,
        'hours': (goal['hours'] as num).toDouble(),
        'done': goal['done'] == true ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [goal['id'] as int],
    );
  }

  Future<int> deleteGoal(int id) async {
    final database = await initDatabase();
    return database.delete('goals', where: 'id = ?', whereArgs: [id]);
  }
}
