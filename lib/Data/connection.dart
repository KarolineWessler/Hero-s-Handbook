import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'data_container.dart';

class Connection {
  static Database? _database;
  static const int DATABASE_VERSION = 1; // Defina o número da versão do banco de dados aqui

  static Future<Database> getConexaoDB() async {
    if (_database == null) {
      String databasesPath = join(await getDatabasesPath(), DATABASE_NAME);
      _database = await openDatabase(databasesPath, version: DATABASE_VERSION,
          onCreate: (Database db, int version) async {
        await db.execute(CREATE_CHARACTER_TABLE_SCRIPT);
        await db.execute(CREATE_MAGIC_TABLE_SCRIPT);
      });
    }
    return _database!;
  }
}
