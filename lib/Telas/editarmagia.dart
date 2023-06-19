import 'package:flutter/material.dart';
import 'descricaomagia.dart';
import 'package:heros_handbook/Data/magic_entity.dart';
import 'package:heros_handbook/Data/magic_sql.dart';

class editarmagia extends StatefulWidget {
  final MagicEntity magia;

  const editarmagia({Key? key, required this.magia}) : super(key: key);

  @override
  State<editarmagia> createState() => _editarmagiaState();
}

class _editarmagiaState extends State<editarmagia> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.magia.st_name ?? '';
    _typeController.text = widget.magia.st_type ?? '';
    _descriptionController.text = widget.magia.st_description ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _salvarMagia() async {
    String name = _nameController.text;
    String type = _typeController.text;
    String description = _descriptionController.text;

    MagicEntity editedMagia = MagicEntity(
      id_magic: widget.magia.id_magic,
      st_name: name,
      st_type: type,
      st_description: description,
      id_character: widget.magia.id_character,
    );

    MagicSQL magicSQL = MagicSQL();
    await magicSQL.updateMagic(editedMagia);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => descricaomagia(
          magia: editedMagia,
        ),
      ),
      (Route<dynamic> route) => false,
    );
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Editar magia'),
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
            onPressed: _salvarMagia,
            tooltip: 'Salvar magia',
            label: const Text('Salvar'),
            icon: const Icon(Icons.save_alt),
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: magicName(nameController),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: magicType(typeController),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: magicDescription(descriptionController),
          ),
        ),
      ],
    );
  }
}

Widget magicName(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
    child: TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Color.fromRGBO(117, 0, 0, 1),
        labelText: 'Nome da magia',
      ),
    ),
  );
}

Widget magicType(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
    child: TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Tipo e nível',
      ),
    ),
  );
}

Widget magicDescription(TextEditingController controller) {
  return Container(
    height: 390,
    padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
    child: TextField(
      controller: controller,
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
