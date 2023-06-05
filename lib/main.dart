import 'package:flutter/material.dart';
import 'package:heros_handbook/criarpersonagem.dart';
import 'Data/connection.dart';
import 'Data/data_container.dart';
import 'magias.dart';
import 'Data/character_entity.dart';
import 'Data/character_sql.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heros Handbook',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Personagens'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<CharacterEntity>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = _loadCharacters();
  }

  Future<List<CharacterEntity>> _loadCharacters() async {
    final characters = await CharacterSQL().getAllCharacters();
    return characters;
  }

  Future<void> _deleteCharacter(CharacterEntity character) async {
    await CharacterSQL().deleteCharacter(character.id_character);
    setState(() {
      _charactersFuture = _loadCharacters().then((characters) {
        // Remove the deleted character from the list
        characters.remove(character);
        return characters;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/oldpaper.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Personagens'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _Body(
            charactersFuture: _charactersFuture,
            onDeleteCharacter:
                _deleteCharacter, // Pass the delete function to the _Body widget
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
            onPressed: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const criarpersonagem();
              }));
              if (result == true) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const MyHomePage(title: 'Personagens');
                }));
              }
            },
            tooltip: 'Criar personagem',
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

class _Body extends StatelessWidget {
  final Future<List<CharacterEntity>> charactersFuture;
  final Function(CharacterEntity)
      onDeleteCharacter; // Function to delete a character

  const _Body({
    Key? key,
    required this.charactersFuture,
    required this.onDeleteCharacter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
      child: FutureBuilder<List<CharacterEntity>>(
        future: charactersFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<CharacterEntity>> snapshot) {
          if (snapshot.hasData) {
            final characters = snapshot.data!;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: characters.length,
              itemBuilder: (BuildContext context, int index) {
                final character = characters[index];
                return Dismissible(
                  key: Key(character.id_character
                      .toString()), // Provide a unique key for each character
                  direction: DismissDirection
                      .endToStart, // Swipe from right to left to dismiss
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) => onDeleteCharacter(
                      character), // Call the delete function when dismissed
                  child: card(context, character),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Erro ao carregar os personagens');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Widget card(BuildContext context, CharacterEntity character) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return magias(characterId: character.id_character!);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/nymeria.png"), // Use the character's image path
          ),
          title: Text(character.st_name ?? ''),
          subtitle: Text(character.st_class ?? ''),
        ),
      ),
    ),
  );
}
