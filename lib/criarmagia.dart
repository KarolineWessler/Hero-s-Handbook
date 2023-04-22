// ignore_for_file: use_key_in_widget_constructors, camel_case_types
import 'package:flutter/material.dart';

// ignore: camel_case_types
class criarmagia extends StatefulWidget {
  @override
  State<criarmagia> createState() => _criarmagiaState();
}

class _criarmagiaState extends State<criarmagia> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/oldpaper.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Nova magia'),
          backgroundColor: Colors.transparent,
          elevation: 0, //
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
          foregroundColor:  const Color.fromRGBO(224, 223, 213, 1),
          onPressed: () {
          
          },
          tooltip: 'Criar magia',
          label: const Text('Criar'),
          icon: const Icon(Icons.add),
        ),
      ),
    ]);
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      magicName(),
      magicType(),
      magicDescription(),
    ]);
  }
}

Widget magicName() {
  return Container(
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      child: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Color.fromRGBO(117, 0, 0, 1),
              labelText: 'Nome da magia')));
}

Widget magicType() {
  return Container(
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      child: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Tipo e nível')));
}

Widget magicDescription() {
  return Container(
      height: 390,
      padding: const EdgeInsets.only(top: 10, left: 55, right: 55),
      child: const TextField(
          minLines: 6,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Descrição')));
}
