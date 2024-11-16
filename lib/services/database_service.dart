import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _contatosTableName = "contatos";
  final String _idColumnName = "id";
  final String _nomeColumnName = "nome";
  final String _numeroColumnName = "numero";
  final String _emailColumnName = "email";

  DatabaseService._constructor();

  Future<Database> get database async {
    if(_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_contatosTableName (
              $_idColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
              $_nomeColumnName TEXT NOT NULL,
              $_numeroColumnName TEXT,
              $_emailColumnName TEXT,
              )''');
      },
    );
    return database;
  }

  void addContact(String nome, String? numero, String? email) async{
    final db = await database;
    await db.insert(_contatosTableName, {
      _nomeColumnName: nome,
      _numeroColumnName: numero,
      _emailColumnName: email
    });
  }

  Future<List<Map<String, Object?>>> getContacts() async {
    final db = await database;
    List<Map<String, Object?>> result = await db.query(_contatosTableName);
    return result;
  }
}
