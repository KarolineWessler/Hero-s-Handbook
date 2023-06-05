// // ignore_for_file: use_key_in_widget_constructors, camel_case_types
// import 'package:flutter/material.dart';

// // ignore: camel_case_types
// class criarmagia extends StatefulWidget {
//   @override
//   State<criarmagia> createState() => _criarmagiaState();
// }

// class _criarmagiaState extends State<criarmagia> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//                 "assets/images/oldpaper.jpg"), // <-- BACKGROUND IMAGE
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: const Text('Nova magia'),
//           backgroundColor: Colors.transparent,
//           elevation: 0, //
//         ),
//         body: _Body(),
//         floatingActionButton: FloatingActionButton.extended(
//           backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
//           foregroundColor:  const Color.fromRGBO(224, 223, 213, 1),
//           onPressed: () {

//           },
//           tooltip: 'Criar magia',
//           label: const Text('Criar'),
//           icon: const Icon(Icons.add),
//         ),
//       ),
//     ]);
//   }
// }

// class _Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       magicName(),
//       magicType(),
//       magicDescription(),
//     ]);
//   }
// }

// Widget magicName() {
//   return Container(
//       padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
//       child: const TextField(
//           decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               fillColor: Color.fromRGBO(117, 0, 0, 1),
//               labelText: 'Nome da magia')));
// }

// Widget magicType() {
//   return Container(
//       padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
//       child: const TextField(
//           decoration: InputDecoration(
//               border: OutlineInputBorder(), labelText: 'Tipo e nível')));
// }

// Widget magicDescription() {
//   return Container(
//       height: 390,
//       padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
//       child: const TextField(
//           minLines: 6,
//           maxLines: null,
//           keyboardType: TextInputType.multiline,
//           decoration: InputDecoration(
//               border: OutlineInputBorder(), labelText: 'Descrição')));
// }

// ignore_for_file: use_key_in_widget_constructors, camel_case_types
// import 'package:flutter/material.dart';

// import 'Data/magic_entity.dart';
// import 'Data/magic_sql.dart';

// class criarmagia extends StatefulWidget {
//   final int characterId;

//   const criarmagia({required this.characterId});

//   @override
//   State<criarmagia> createState() => _criarmagiaState();
// }

// class _criarmagiaState extends State<criarmagia> {
//   String? magicName;
//   String? magicType;
//   String? magicDescription;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/oldpaper.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             title: const Text('Nova magia'),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: _Body(
//             onMagicNameChanged: (value) {
//               magicName = value;
//             },
//             onMagicTypeChanged: (value) {
//               magicType = value;
//             },
//             onMagicDescriptionChanged: (value) {
//               magicDescription = value;
//             },
//           ),
//           floatingActionButton: FloatingActionButton.extended(
//             backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
//             foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
//             onPressed: () {
//               createMagic();
//             },
//             tooltip: 'Criar magia',
//             label: const Text('Criar'),
//             icon: const Icon(Icons.add),
//           ),
//         ),
//       ],
//     );
//   }

//   void createMagic() {
//     if (magicName != null && magicType != null && magicDescription != null) {
//       final magicEntity = MagicEntity(
//         st_name: magicName,
//         st_type: magicType,
//         st_description: magicDescription,
//         id_character: widget.characterId,
//       );

//       MagicSQL().insertMagic(
//         magicEntity.st_name!,
//         magicEntity.st_description!,
//         magicEntity.st_type!,
//         magicEntity.id_character!,
//       );

//       Navigator.pop(context);
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Erro'),
//             content: const Text('Preencha todos os campos.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }

// class _Body extends StatelessWidget {
//   final ValueChanged<String>? onMagicNameChanged;
//   final ValueChanged<String>? onMagicTypeChanged;
//   final ValueChanged<String>? onMagicDescriptionChanged;

//   const _Body({
//     Key? key,
//     this.onMagicNameChanged,
//     this.onMagicTypeChanged,
//     this.onMagicDescriptionChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         magicName(onChanged: onMagicNameChanged),
//         magicType(onChanged: onMagicTypeChanged),
//         magicDescription(onChanged: onMagicDescriptionChanged),
//       ],
//     );
//   }
// }

// Widget magicName({ValueChanged<String>? onChanged}) {
//   return Container(
//     padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
//     child: TextField(
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         fillColor: const Color.fromRGBO(117, 0, 0, 1),
//         labelText: 'Nome da magia',
//       ),
//     ),
//   );
// }

// Widget magicType({ValueChanged<String>? onChanged}) {
//   return Container(
//     padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
//     child: TextField(
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Tipo e nível',
//       ),
//     ),
//   );
// }

// Widget magicDescription({ValueChanged<String>? onChanged}) {
//   return Container(
//     height: 390,
//     padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
//     child: TextField(
//       onChanged: onChanged,
//       minLines: 6,
//       maxLines: null,
//       keyboardType: TextInputType.multiline,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Descrição',
//       ),
//     ),
//   );
// }

// ignore_for_file: use_key_in_widget_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:heros_handbook/magias.dart';
import 'package:heros_handbook/main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'Data/magic_entity.dart';
import 'Data/connection.dart';
import 'Data/data_container.dart';

class criarmagia extends StatefulWidget {
  final int characterId;

  const criarmagia({Key? key, required this.characterId}) : super(key: key);

  @override
  State<criarmagia> createState() => _CriarMagiaState();
}

class _CriarMagiaState extends State<criarmagia> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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
        magicName(),
        magicType(),
        magicDescription(),
      ],
    );
  }

  Widget magicName() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      child: TextField(
        controller: widget.nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          fillColor: const Color.fromRGBO(117, 0, 0, 1),
          labelText: 'Nome da magia',
        ),
      ),
    );
  }

  Widget magicType() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      child: TextField(
        controller: widget.typeController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Tipo e nível',
        ),
      ),
    );
  }

  Widget magicDescription() {
    return Container(
      height: 390,
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      child: TextField(
        controller: widget.descriptionController,
        minLines: 6,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Descrição',
        ),
      ),
    );
  }
}
