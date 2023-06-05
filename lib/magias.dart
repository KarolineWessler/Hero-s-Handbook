import 'package:flutter/material.dart';
import 'package:heros_handbook/criarmagia.dart';
import 'descricaomagia.dart';
import 'Data/magic_entity.dart';
import 'Data/magic_sql.dart';

class magias extends StatelessWidget {
  final int characterId;

  const magias({Key? key, required this.characterId}) : super(key: key);

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
            title: const Text('Magias'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListaMagias(characterId: characterId),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
            onPressed: () async {
              final result = await Navigator.push<bool>(context, MaterialPageRoute(builder: (context) {
                return criarmagia(characterId: characterId);
              }));
              if (result == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ListaMagias(characterId: characterId)),
                );
              }
            },
            tooltip: 'Criar magia',
            child: const Icon(
              Icons.add,
              color: Color.fromRGBO(224, 223, 213, 1),
            ),
          ),
        ),
      ],
    );
  }
}

class ListaMagias extends StatefulWidget {
  final int characterId;

  const ListaMagias({Key? key, required this.characterId}) : super(key: key);

  @override
  State<ListaMagias> createState() => _ListaMagiasState();
}

class _ListaMagiasState extends State<ListaMagias> {
  late Future<List<MagicEntity>> _magiasFuture;

  @override
  void initState() {
    super.initState();
    _magiasFuture = _loadMagias();
  }

  Future<List<MagicEntity>> _loadMagias() async {
    final magias = await MagicSQL().getMagicByCharacter(widget.characterId);
    return magias;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: FutureBuilder<List<MagicEntity>>(
        future: _magiasFuture,
        builder: (BuildContext context, AsyncSnapshot<List<MagicEntity>> snapshot) {
          if (snapshot.hasData) {
            final magias = snapshot.data!;
            return ReorderableListView(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              children: <Widget>[
                for (int index = 0; index < magias.length; index += 1)
                  Card(
                    key: Key('${magias[index].id_magic}'),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DescricaoMagia(magia: magias[index]);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          leading: Icon(Icons.auto_fix_high_outlined),
                          title: Text(magias[index].st_name ?? ''),
                          subtitle: Text(magias[index].st_type ?? ''),
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
                  final MagicEntity item = magias.removeAt(oldIndex);
                  magias.insert(newIndex, item);
                });
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Erro ao carregar as magias');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class DescricaoMagia extends StatelessWidget {
  final MagicEntity magia;

  const DescricaoMagia({Key? key, required this.magia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(magia.st_name ?? ''),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${magia.st_name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Tipo: ${magia.st_type}'),
            const SizedBox(height: 10),
            Text('Descrição: ${magia.st_description}'),
          ],
        ),
      ),
    );
  }
}
