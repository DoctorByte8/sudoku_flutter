import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SudokuDB {
  static final SudokuDB instance = SudokuDB.internal();
  factory SudokuDB() => instance;
  SudokuDB.internal();

  Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await initDatabase();
    return db!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sudoku.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sudoku (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR NOT NULL,
        result INTEGER,
        date VARCHAR NOT NULL,
        level INTEGER
      )
    ''');
  }

  Future<int> insertSudoku(String name, int result, String date, int level) async {
    final db = await database;
    return await db.insert('sudoku', {
      'name': name,
      'result': result,
      'date': date,
      'level': level,
    });
  }

  Future<List<Map<String, dynamic>>> getAllSudokus() async {
    final db = await database;
    return await db.query('sudoku');
  }

  Future<Map<String, dynamic>?> getSudokuById(int id) async {
    final db = await database;
    final results = await db.query(
      'sudoku',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }
}