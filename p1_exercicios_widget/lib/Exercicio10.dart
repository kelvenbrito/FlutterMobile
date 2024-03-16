// Interface com Animação:
// Integre animações simples em elementos do seu layout.
// Por exemplo, faça um widget mover-se ou mudar de cor ao ser clicado.

import 'package:flutter/material.dart';

import 'dart:math' as math; // Importando o pacote dart:math e renomeando-o para math


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Example',
  
      home: Animacao(),
    );
  }
}

class Animacao extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<Animacao> {
  Color _containerColor = Colors.blue; // Cor inicial do container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              // Ao ser clicado, altera a cor do container para uma cor aleatória
              _containerColor = _generateRandomColor();
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1), // Duração da animação
            width: 200.0,
            height: 200.0,
            color: _containerColor, // Cor do container
            curve: Curves.easeInOut, // Curva de animação
          ),
        ),
      ),
    );
  }

  // Função para gerar uma cor aleatória
  Color _generateRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }
}
