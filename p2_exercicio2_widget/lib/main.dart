// Listagem Dinâmica:
// Desenvolva um aplicativo que utilize o widget ListView.builder para exibir uma lista
// dinâmica de itens.
// Os itens podem ser representados por widgets simples, como Card, contendo
// informações fictícias.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListViewBuilder(),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  // Lista fictícia de itens
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Builder Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          // Construir o Card para cada item na lista
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(items[index]), // Título do item
              subtitle:
                  Text('Descrição do ${items[index]}'), // Descrição fictícia
              leading: CircleAvatar(
                // Ícone à esquerda do item (opcional)
                backgroundColor: Colors.blue,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                // Ação ao clicar no item (opcional)
                print('Item ${items[index]} clicado');
              },
            ),
          );
        },
      ),
    );
  }
}
