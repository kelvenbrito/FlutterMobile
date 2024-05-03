// Layout Responsivo com MediaQuery:
// Torne o seu layout responsivo utilizando o widget MediaQuery.
// Adapte o conteúdo para diferentes tamanhos de tela e orientações.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLayout(),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Responsivo'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600 ) {
              // Para telas menores que 600 pixels de largura
              return _buildContent(Colors.red, 'Pequeno');
            } else if (constraints.maxWidth < 900) {
              // Para telas entre 600 e 900 pixels de largura
              return _buildContent(Colors.green, 'Médio');
            } else {
              // Para telas maiores que 900 pixels de largura
              return _buildContent(Colors.blue, 'Grande');
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(Color color, String sizeText) {
    return Container(
      color: color,
      child: Center(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        
            Text(
              'Tamanho da Tela: $sizeText',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
