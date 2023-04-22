import 'package:flutter/material.dart';
import 'package:heros_handbook/criarmagia.dart';

import 'descricaomagia.dart';

// ignore: camel_case_types
class magias extends StatelessWidget {
  const magias({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          title: const Text('Magias'),
          backgroundColor: Colors.transparent,
          elevation: 0, //
        ),
        body: const ListaMagias(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return criarmagia();
            }));
          },
          tooltip: 'Criar magia',
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(224, 223, 213, 1),
          ),
        ),
      ),
    ]);
  }
}

class ListaMagias extends StatefulWidget {
  const ListaMagias({super.key});

  @override
  State<ListaMagias> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ListaMagias> {
  final List<int> _items = List<int>.generate(3, (int index) => index);
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)
          Card(
            key: Key('$index'),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const descricaomagia();
                }));
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  leading: Icon(Icons.auto_fix_high_outlined),
                  title: Text('Bola de Fogo'),
                  subtitle: Text('Arcano - 2'),
                ),
              ),
            ),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}
