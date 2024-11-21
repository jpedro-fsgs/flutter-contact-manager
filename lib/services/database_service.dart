import 'package:agenda/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _contactsTableName = "contacts";
  final String _idColumnName = "id";
  final String _nameColumnName = "name";
  final String _numberColumnName = "number";
  final String _emailColumnName = "email";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_contactsTableName (
              $_idColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
              $_nameColumnName TEXT NOT NULL,
              $_numberColumnName TEXT,
              $_emailColumnName TEXT
              )''');
      },
    );
    return database;
  }

  Future<List<Contact>> getContacts() async {
    // await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Erro');
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(_contactsTableName);
    return data
        .map((contact) => Contact(
            id: contact["id"],
            name: contact["name"],
            number: contact["number"],
            email: contact["email"]))
        .toList();
  }

  void addContact(String name, String? number, String? email) async {
    final db = await database;
    await db.insert(_contactsTableName, {
      _nameColumnName: name,
      _numberColumnName: number,
      _emailColumnName: email
    });
  }

  void updateContact(int id, String name, String? number, String? email) async {
    final db = await database;

    await db.update(
        _contactsTableName,
        {
          _nameColumnName: name,
          _numberColumnName: number,
          _emailColumnName: email
        },
        where: '$_idColumnName = ?',
        whereArgs: [id]);
  }

  void removeContact(int id) async {
    final db = await database;
    await db.delete(_contactsTableName,
        where: '$_idColumnName = ?', whereArgs: [id]);
  }
}
