import 'dart:typed_data';

class CharacterEntity {
  late int? id_character;
  String? st_name;
  String? st_class;

  CharacterEntity({
    this.id_character,
    this.st_name,
    this.st_class,
  });

  @override
  String toString() {
    return '$id_character - $st_name - $st_class';
  }

  Map<String, dynamic> toMap() {
    return {
      'id_character': id_character,
      'st_name': st_name,
      'st_class': st_class,
    };
  }
}
