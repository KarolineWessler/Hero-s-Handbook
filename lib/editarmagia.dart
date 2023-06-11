// // ignore_for_file: use_key_in_widget_constructors, camel_case_types
// import 'package:flutter/material.dart';
// import 'package:heros_handbook/descricaomagia.dart';

// // ignore: camel_case_types
// class editarmagia extends StatefulWidget {
//   @override
//   State<editarmagia> createState() => _editarmagiaState();
// }

// class _editarmagiaState extends State<editarmagia> {
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
//           title: const Text('Editar magia'),
//           backgroundColor: Colors.transparent,
//           elevation: 0, //
//         ),
//         body: _Body(),
//         floatingActionButton: FloatingActionButton.extended(
//           backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
//           foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
//           onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return descricaomagia();
//             }));
//           },
//           tooltip: 'Salvar magia',
//           label: const Text('Salvar'),
//           icon: const Icon(Icons.save_alt),
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


