import 'package:listacompras_flutter/ProdutosController.dart';
import 'package:listacompras_flutter/ProdutosView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class  ProdutosApp extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Definido a tela inicial como a Tarefa
      home: ChangeNotifierProvider(
        create: (context) => ProdutosController(context),
        child: ProdutosScreen(),
      ),
    );
  }
}