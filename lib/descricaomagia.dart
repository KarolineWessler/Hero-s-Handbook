import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'editarmagia.dart';

// ignore: camel_case_types
class descricaomagia extends StatefulWidget {
  const descricaomagia({super.key});

  @override
  State<descricaomagia> createState() => _descricaomagiaState();
}

// ignore: camel_case_types
class _descricaomagiaState extends State<descricaomagia> {
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
          foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return editarmagia();
            }));
          },
          tooltip: 'Editar magia',
          label: const Text('Editar'),
          icon: const Icon(Icons.edit),
        ),
      ),
    ]);
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: ListView(
          children: [
            magicTitle(),
            magicSubtitle(),
            magicDescription(),
          ],
        ));
  }
}

Widget magicTitle() {
  return Container(
    alignment: Alignment.center,
    child: Text(
      "Bola de Fogo",
      style: GoogleFonts.unifrakturMaguntia(
          textStyle: const TextStyle(
        color: Color.fromRGBO(117, 0, 0, 1),
        fontSize: 48,
      )),
    ),
  );
}

Widget magicSubtitle() {
  return Container(
    alignment: Alignment.center,
    child: Text(
      "Arcano - 2",
      style: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 20,
      )),
    ),
  );
}

Widget magicDescription() {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
    child: Text(
      "Execução padrão, alcance médio, atinge área de uma esfera com 6m de raio. Duração instantânea, teste de resistência reflexos reduz à metade. Poderosa explosão, causando 6d6 pontos de dano de fogo em TODAS as criaturas e objetos livres na área.",
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 18,
      )),
    ),
  );
}
