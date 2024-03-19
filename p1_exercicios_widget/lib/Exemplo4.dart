// Barra de Navegação Personalizada:
// Implemente uma barra de navegação personalizada, utilizando o widget AppBar e ícones.
// Crie diferentes abas que levem a seções distintas da sua aplicação.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exercicio 4")),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text('Página inicial'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
          selectedItemColor: Colors.blue,
        ),
      ),
    );
  }
}
