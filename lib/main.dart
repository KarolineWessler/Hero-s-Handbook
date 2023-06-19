import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Habilitar o suporte ao Material 3
      ),
      onGenerateRoute: Routes.generateRoutes,
      initialRoute: '/',
    );
  }
}
