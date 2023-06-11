import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heros_handbook/criarpersonagem.dart';

import 'Data/magic_entity.dart';
import 'editarmagia.dart';
import 'main.dart';

// ignore: camel_case_types
class descricaomagia extends StatefulWidget {
  final MagicEntity magia;
  
  const descricaomagia({Key? key, required this.magia}) : super(key: key);
  

  @override
  State<descricaomagia> createState() => _descricaomagiaState();
}

class _descricaomagiaState extends State<descricaomagia> {
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
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _Body(magia: widget.magia),
          // floatingActionButton: FloatingActionButton.extended(
          //   backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
          //   foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       // return editarmagia(magia: widget.magia);
          //       return editarmagia(magia: widget.magia);
          //     }));
          //   },
          //   tooltip: 'Editar magia',
          //   label: const Text('Editar'),
          //   icon: const Icon(Icons.edit),
          // ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final MagicEntity magia;

  const _Body({Key? key, required this.magia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
      child: ListView(
        children: [
          magicTitle(magia.st_name ?? ''),
          magicSubtitle(magia.st_type ?? ''),
          magicDescription(magia.st_description ?? ''),
        ],
      ),
    );
  }
}

Widget magicTitle(String title) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      title,
      style: GoogleFonts.unifrakturMaguntia(
        textStyle: const TextStyle(
          color: Color.fromRGBO(117, 0, 0, 1),
          fontSize: 48,
        ),
      ),
    ),
  );
}

Widget magicSubtitle(String subtitle) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      subtitle,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget magicDescription(String description) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
    child: Text(
      description,
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}
