import 'package:flutter/material.dart';
import 'package:heros_handbook/criarpersonagem.dart';
import 'magias.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/oldpaper.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Personagens'),
            backgroundColor: Colors.transparent,
            elevation: 0, //
          ),
          body: _Body(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const criarpersonagem();
              }));
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
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: ListView(
          children: [card(context), card2(context)],
        ));
  }
}

Widget card(context) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const magias();
        }));
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // children: <Widget>[
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/nymeria.png"),
          ),
          title: Text('Nymeria Blackmoon'),
          subtitle: Text('Mago'),
        ),
        // ],
      ),
    ),
  );
}

Widget card2(context) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const magias();
        }));
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // children: <Widget>[
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/gandalf.jpg"),
          ),
          title: Text('Gandalf the White'),
          subtitle: Text('Mago'),
        ),
        // ],
      ),
    ),
  );
}
