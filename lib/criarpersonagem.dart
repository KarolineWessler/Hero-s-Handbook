import 'package:flutter/material.dart';
import 'package:heros_handbook/main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'Data/character_entity.dart';
import 'Data/connection.dart';
import 'Data/data_container.dart';

class criarpersonagem extends StatefulWidget {
  const criarpersonagem({Key? key}) : super(key: key);

  @override
  State<criarpersonagem> createState() => _criarpersonagemState();
}

class _criarpersonagemState extends State<criarpersonagem> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _classController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/criarpersonagem.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Criar personagem'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _Body(
            nameController: _nameController,
            classController: _classController,
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
            foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
            onPressed: () async {
              _insertCharacter;
              var result = await _insertCharacter();
              _showSuccessMessage("Personagem criado com sucesso!");
              if (result > 0) {
                Navigator.pop(context, true);
                main();
              }
            },
            tooltip: 'Criar personagem',
            label: const Text('Criar'),
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<int> _insertCharacter() async {
    final String name = _nameController.text;
    final String characterClass = _classController.text;

    // Insert the character into the database
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
      VALUES (?, ?)
    ''', [
      characterEntity.st_name,
      characterEntity.st_class
    ]);

    characterEntity.id_character = characterID;
    print(characterEntity);

    // Clear the text fields
    _nameController.clear();
    _classController.clear();

    // Return a value indicating success
    if (characterID != null) {
      return 1;
    } else {
      return 0;
    }
  }

  _showSuccessMessage(message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _Body extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController classController;

  const _Body({
    Key? key,
    required this.nameController,
    required this.classController,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          characterName(),
          characterClass(),
        ],
      ),
    );
  }

  Widget characterName() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
      child: TextField(
        controller: widget.nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          fillColor: const Color.fromRGBO(117, 0, 0, 1),
          labelText: 'Nome',
        ),
      ),
    );
  }

  Widget characterClass() {
    return Container(
      width: 300,
      padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
      child: TextField(
        controller: widget.classController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Classe',
        ),
      ),
    );
  }
}
