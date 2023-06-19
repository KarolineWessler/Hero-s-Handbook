import 'package:flutter/material.dart';
import 'package:heros_handbook/Telas/magias.dart';
import 'package:heros_handbook/Data/magic_entity.dart';
import 'package:heros_handbook/Data/connection.dart';
import 'package:heros_handbook/Data/data_container.dart';

// ignore: camel_case_types
class criarmagia extends StatefulWidget {
  final int characterId;

  const criarmagia({Key? key, required this.characterId}) : super(key: key);

  @override
  State<criarmagia> createState() => _CriarMagiaState();
}

class _CriarMagiaState extends State<criarmagia> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/oldpaper.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Nova magia'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _Body(
            nameController: _nameController,
            typeController: _typeController,
            descriptionController: _descriptionController,
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
            foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
            onPressed: () async {
              await createMagic();
            },
            tooltip: 'Criar magia',
            label: const Text('Criar'),
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<void> createMagic() async {
    final String magicName = _nameController.text;
    final String magicType = _typeController.text;
    final String magicDescription = _descriptionController.text;

    if (magicName.isNotEmpty &&
        magicType.isNotEmpty &&
        magicDescription.isNotEmpty) {
      final db = await Connection.getConexaoDB();
      final magicEntity = MagicEntity(
        st_name: magicName,
        st_type: magicType,
        st_description: magicDescription,
        id_character: widget.characterId,
      );

      await db.insert(MAGIC_TABLE_NAME, magicEntity.toMap());

      _showSuccessMessage('Magia criada com sucesso!');

      _nameController.clear();
      _typeController.clear();
      _descriptionController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => magias(characterId: widget.characterId)),
      );
    } else {
      _showErrorMessage('Por favor, preencha todos os campos');
    }
  }

  _showSuccessMessage(message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _showErrorMessage(message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _Body extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController descriptionController;

  const _Body({
    Key? key,
    required this.nameController,
    required this.typeController,
    required this.descriptionController,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: magicName(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: magicType(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: magicDescription(),
          ),
        ),
      ],
    );
  }

  Widget magicName() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      height: 10,
      child: TextField(
        controller: widget.nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Color.fromRGBO(117, 0, 0, 1),
          labelText: 'Nome da magia',
        ),
      ),
    );
  }

  Widget magicType() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 55, right: 55),
      child: TextField(
        controller: widget.typeController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Tipo e nível',
        ),
      ),
    );
  }

  Widget magicDescription() {
    return Container(
      height: 390,
      padding: const EdgeInsets.only(top: 0, left: 55, right: 55),
      child: TextField(
        controller: widget.descriptionController,
        minLines: 6,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Descrição',
        ),
      ),
    );
  }
}
