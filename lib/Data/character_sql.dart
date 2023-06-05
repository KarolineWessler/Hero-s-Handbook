import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'character_entity.dart';
import 'connection.dart';
import 'data_container.dart';
import 'dart:typed_data';

class CharacterSQL {
  Future<void> insertCharacter(String? name, String? characterClass) async {
    final db = await Connection.getConexaoDB();
    final characterEntity = CharacterEntity(
      st_name: name,
      st_class: characterClass
    );

    int? characterID = await db.rawInsert('''
      INSERT INTO $CHARACTER_TABLE_NAME (
        $CHARACTER_COLUMN_NAME,
        $CHARACTER_COLUMN_CLASS
      )
      VALUES (?, ?, ?)
    ''', [
      characterEntity.st_name,
      characterEntity.st_class
    ]);

    characterEntity.id_character = characterID;
    
  }

  Future<List<CharacterEntity>> getAllCharacters() async {
    Database db = await Connection.getConexaoDB();
    List<Map> dbResult = await db.rawQuery('SELECT * FROM $CHARACTER_TABLE_NAME');

    List<CharacterEntity> characters = [];
    for (var row in dbResult) {
      CharacterEntity character = CharacterEntity(
        id_character: row['id_character'],
        st_name: row['st_name'],
        st_class: row['st_class']
      );
      characters.add(character);
    }
    return characters;
  }

  Future<void> updateCharacter(CharacterEntity character) async {
    Database db = await Connection.getConexaoDB();
    await db.update(
      CHARACTER_TABLE_NAME,
      character.toMap(),
      where: '$CHARACTER_COLUMN_ID = ?',
      whereArgs: [character.id_character]
    );
    print('Character updated: $character');
  }

  Future<void> deleteCharacter(int? characterID) async {
    Database db = await Connection.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawDelete('DELETE FROM $CHARACTER_TABLE_NAME WHERE $CHARACTER_COLUMN_ID = ?', [characterID]);
    });
  }

  Future<void> deleteAllCharacters() async {
    Database db = await Connection.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawDelete('DELETE FROM $CHARACTER_TABLE_NAME');
    });
  }
}
