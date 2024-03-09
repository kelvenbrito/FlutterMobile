// Página com ListView:
// Construa uma página que contenha um ListView com pelo menos 10 itens.
// Cada item deve ser representado por um card simples, exibindo informações fictícias.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(title: Text("Exercicio2")) ,
           body: Container(
                children: [
          // Campo de texto para adicionar nova tarefa
          Padding(
            padding: const EdgeInsets.all(8.0),
             ),
                ],

           ),


      ),
    );

  }
}