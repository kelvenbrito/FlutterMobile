// Página com ListView:
// Construa uma página que contenha um ListView com pelo menos 10 itens.
// Cada item deve ser representado por um card simples, exibindo informações fictícias.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item ${index + 1}');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exercicio 3")),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child:
              // Campo de texto para adicionar nova tarefa

              ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(items[index]),
                          subtitle: Text('texto'),
                          leading: Icon(Icons.info),
                          
                        ));
                  }),
        ),
      ),
    );
  }
}
