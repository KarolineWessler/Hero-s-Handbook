import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'magic_entity.dart';
import 'connection.dart';
import 'data_container.dart';

class MagicSQL {
  Future<void> insertMagic(
      String name, String type, String description, int characterId) async {
    final db = await Connection.getConexaoDB();
    final magicEntity = MagicEntity(
      st_name: name,
      st_type: type,
      st_description: description,
      id_character: characterId,
    );

    int? magicId = await db.rawInsert('''
    INSERT INTO $MAGIC_TABLE_NAME (
      $MAGIC_COLUMN_NAME,
      $MAGIC_COLUMN_TYPE,
      $MAGIC_COLUMN_DESCRIPTION,
      $MAGIC_COLUMN_CHARACTER_ID
    )
    VALUES (?, ?, ?, ?)
  ''', [
      magicEntity.st_name,
      magicEntity.st_type,
      magicEntity.st_description,
      magicEntity.id_character,
    ]);

    magicEntity.id_magic = magicId;
    print(magicEntity);
  }

  Future<List<MagicEntity>> getAllMagic() async {
    Database db = await Connection.getConexaoDB();
    List<Map> dbResult = await db.rawQuery('SELECT * FROM $MAGIC_TABLE_NAME');

    List<MagicEntity> magicList = [];
    for (var row in dbResult) {
      MagicEntity magic = MagicEntity(
        id_magic: row['id_magic'],
        st_name: row['st_name'],
        st_type: row['st_type'],
        st_description: row['st_description'],
        id_character: row['id_character'],
      );
      magicList.add(magic);
    }
    return magicList;
  }

  Future<List<MagicEntity>> getMagicByCharacter(int characterId) async {
    final db = await Connection.getConexaoDB();
    final List<Map<String, dynamic>> maps = await db.query(
      MAGIC_TABLE_NAME,
      where: '$MAGIC_COLUMN_CHARACTER_ID = ?',
      whereArgs: [characterId],
    );
    return List.generate(maps.length, (index) {
      return MagicEntity(
        id_magic: maps[index]['id_magic'],
        st_name: maps[index]['st_name'],
        st_type: maps[index]['st_type'],
        st_description: maps[index]['st_description'],
        id_character: maps[index]['id_character'],
      );
    });
  }

  Future<void> deleteMagic(int? magicId) async {
    Database db = await Connection.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $MAGIC_TABLE_NAME WHERE $MAGIC_COLUMN_ID = ?', [magicId]);
    });
  }

  Future<void> deleteAllMagic() async {
    Database db = await Connection.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate('DELETE FROM $MAGIC_TABLE_NAME');
    });
  }

  Future<void> updateMagic(MagicEntity magic) async {
    Database db = await Connection.getConexaoDB();
    await db.update(
      MAGIC_TABLE_NAME,
      magic.toMap(),
      where: '$MAGIC_COLUMN_ID = ?',
      whereArgs: [magic.id_magic],
    );
  }
}
