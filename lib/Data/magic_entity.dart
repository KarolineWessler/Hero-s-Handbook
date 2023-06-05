class MagicEntity {
  late int? id_magic;
  String? st_name;
  String? st_description;
  int? id_character;

  MagicEntity({
    this.id_magic,
    this.st_name,
    this.st_description,
    this.id_character,
  });

  @override
  String toString() {
    return '$id_magic - $st_name - $st_description';
  }

  Map<String, dynamic> toMap() {
    return {
      'id_magic': id_magic,
      'st_name': st_name,
      'st_description': st_description,
      'id_character': id_character,
    };
  }
}
