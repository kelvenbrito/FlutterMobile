import 'package:app_carros/Model.dart';
import 'package:flutter/material.dart';

class TelaDetalheCarro extends StatelessWidget {
final Carro carro;
TelaDetalheCarro(this.carro);
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Detalhes do Carro"),
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.network(carro.imagemUrl),
SizedBox(height: 20),
Text("Modelo: ${carro.modelo}"),
Text("Ano: ${carro.ano}"),
],
),
),
);
}
}