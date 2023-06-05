class MagicEntity {
  late int? id_magic;
  String? st_name;
  String? st_type;
  String? st_description;
  late int? id_character;

  MagicEntity({
    this.id_magic,
    this.st_name,
    this.st_type,
    this.st_description,
    this.id_character,
  });

  @override
  String toString() {
    return '$id_magic - $st_name - $st_type - $st_description';
  }

  Map<String, dynamic> toMap() {
    return {
      'id_magic': id_magic,
      'st_name': st_name,
      'st_type': st_type,
      'st_description': st_description,
      'id_character': id_character,
    };
  }
}
