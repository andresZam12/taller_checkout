import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/card_model.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('checkout.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardNumber TEXT,
        cardHolder TEXT,
        expiryDate TEXT,
        cvv TEXT
      )
    ''');
  }

  Future<int> insertCard(CardModel card) async {
    final db = await instance.database;
    return await db.insert('cards', card.toMap());
  }

  Future<List<CardModel>> getCards() async {
    final db = await instance.database;
    final result = await db.query('cards');

    return result.map((json) => CardModel.fromMap(json)).toList();
  }
}