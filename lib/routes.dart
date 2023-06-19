import 'package:flutter/material.dart';
import 'package:heros_handbook/Telas/personagens.dart';
import 'package:heros_handbook/Telas/criarpersonagem.dart';
import 'package:heros_handbook/Telas/magias.dart';
import 'package:heros_handbook/Telas/criarmagia.dart';
import 'package:heros_handbook/Telas/descricaomagia.dart';
import 'package:heros_handbook/Telas/editarmagia.dart';

import 'Data/magic_entity.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => personagens());
      case '/criarpersonagem':
        return MaterialPageRoute(builder: (_) => criarpersonagem());
      case '/magias':
        if (args is int) {
          final int characterId = args;
          return MaterialPageRoute(builder: (_) => magias(characterId: characterId));
        }
        break;
      case '/criarmagia':
        return MaterialPageRoute(builder: (_) => criarmagia(characterId: args));
      case '/descricaomagia':
        if (args is MagicEntity) {
          final MagicEntity magia = args;
          return MaterialPageRoute(builder: (_) => descricaomagia(magia: magia));
        }
        break;
      case '/editarmagia':
        if (args is MagicEntity) {
          final MagicEntity magia = args;
          return MaterialPageRoute(builder: (_) => editarmagia(magia: magia));
        }
        break;
    }

    return MaterialPageRoute(builder: (_) => personagens());
  }
}
