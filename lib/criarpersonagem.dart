import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class criarpersonagem extends StatefulWidget {
  const criarpersonagem({super.key});

  @override
  State<criarpersonagem> createState() => _criarpersonagemState();
}

// ignore: camel_case_types
class _criarpersonagemState extends State<criarpersonagem> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/criarpersonagem.png"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Criar personagem'),
          backgroundColor: Colors.transparent,
          elevation: 0, //
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
          foregroundColor:  const Color.fromRGBO(224, 223, 213, 1),
          onPressed: () {
          
          },
          tooltip: 'Criar personagem',
          label: const Text('Criar'),
          icon: const Icon(Icons.add),
        ),
      ),
    ]);
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        characterName(),
        characterClass(),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(117, 0, 0, 1),
              foregroundColor: const Color.fromRGBO(224, 223, 213, 1),
            ),
            onPressed: _openImagePicker,
            child: const Text('Selecione a imagem do personagem'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(181, 176, 166, 1),
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 150,
              height: 150,
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : const Icon(Icons.person)),
        ),
      ],
    ));
  }
}

Widget characterName() {
  return Container(
      padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
      child: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), 
              fillColor:  Color.fromRGBO(117, 0, 0, 1),
              labelText: 'Nome')));
}

Widget characterClass() {
  return Container(
      width: 300,
      padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
      child: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Classe')));
}
