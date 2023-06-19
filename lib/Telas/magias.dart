import 'package:flutter/material.dart';
import 'package:heros_handbook/Telas/criarmagia.dart';
import 'package:heros_handbook/Telas/personagens.dart';
import 'descricaomagia.dart';
import 'package:heros_handbook/Data/magic_entity.dart';
import 'package:heros_handbook/Data/magic_sql.dart';
import 'package:heros_handbook/main.dart';

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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/personages');
              },
            ),
          ),
          body: ListaMagias(characterId: characterId),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
            onPressed: () async {
              final result = await Navigator.push<bool>(context,
                  MaterialPageRoute(builder: (context) {
                return criarmagia(characterId: characterId);
              }));
              if (result == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListaMagias(characterId: characterId)),
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

  Future<void> _deleteMagia(MagicEntity magia) async {
    await MagicSQL().deleteMagic(magia.id_magic);
    setState(() {
      _magiasFuture = _loadMagias().then((magias) {
        magias.remove(magia);
        return magias;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: FutureBuilder<List<MagicEntity>>(
        future: _magiasFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<MagicEntity>> snapshot) {
          if (snapshot.hasData) {
            final magias = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              itemCount: magias.length,
              itemBuilder: (BuildContext context, int index) {
                final magia = magias[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.transparent,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  onDismissed: (direction) => _deleteMagia(magias[index]),
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/descricaomagia',
                            arguments: magia);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/images/magic.png"), // Use the character's image path
                          ),
                          title: Text(magia.st_name ?? ''),
                          subtitle: Text(magia.st_type ?? ''),
                        ),
                      ),
                    ),
                  ),
                );
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
