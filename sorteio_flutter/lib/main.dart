import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(SorteioApp());
}

class SorteioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sorteio(),
    );
  }
}

class Sorteio extends StatefulWidget {
  @override
  _SorteioState createState() => _SorteioState();
}

class _SorteioState extends State<Sorteio> {
  TextEditingController _controllerNumero = TextEditingController();
  String _resultado = '';
  late Random random;
  late int _numeroAleatorio;

  @override
  void initState() {
    super.initState();
    random = Random();
    _numeroAleatorio = random.nextInt(101); // Gera um número aleatório entre 0 e 100.
  }

  void _adivinhar() {
    int numero = int.tryParse(_controllerNumero.text) ?? 0;

    setState(() {
      if (numero == _numeroAleatorio) {
        _resultado = "Você adivinhou o número correto!";
      } else {
        if (numero > _numeroAleatorio) {
          _resultado =
              "Você errou! Tente novamente!\nO número que você digitou é maior que o número sorteado.";
        } else {
          _resultado =
              "Você errou! Tente novamente!\nO número que você digitou é menor que o número sorteado.";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorteio Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerNumero,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _adivinhar,
              child: Text('Adivinhar'),
            ),
            SizedBox(height: 10.0),
            Text(_resultado,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
