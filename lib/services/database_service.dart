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
  final String _imagePathColumnName = "image_path";

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
      version: 3,
      onUpgrade: _upgradeDatabase,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_contactsTableName (
              $_idColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
              $_nameColumnName TEXT NOT NULL,
              $_numberColumnName TEXT,
              $_emailColumnName TEXT,
              $_imagePathColumnName TEXT
              )''');
      },
    );
    return database;
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE $_contactsTableName ADD COLUMN $_imagePathColumnName TEXT');
    }
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(_contactsTableName);
    return data
        .map((contact) => Contact(
            id: contact["id"],
            name: contact["name"],
            number: contact["number"],
            email: contact["email"],
            imagePath: contact["image_path"]))
        .toList();
  }

  Future<void> addContact(
      String name, String? number, String? email, String? imagePath) async {
    final db = await database;
    await db.insert(_contactsTableName, {
      _nameColumnName: name,
      _numberColumnName: number,
      _emailColumnName: email,
      _imagePathColumnName: imagePath
    });
  }

  Future<void> updateContact(int id, String name, String? number, String? email,
      String? imagePath) async {
    final db = await database;
    await db.update(
        _contactsTableName,
        {
          _nameColumnName: name,
          _numberColumnName: number,
          _emailColumnName: email,
          _imagePathColumnName: imagePath
        },
        where: '$_idColumnName = ?',
        whereArgs: [id]);
  }

  Future<void> removeContact(int id) async {
    final db = await database;
    await db.delete(_contactsTableName,
        where: '$_idColumnName = ?', whereArgs: [id]);
  }
}
