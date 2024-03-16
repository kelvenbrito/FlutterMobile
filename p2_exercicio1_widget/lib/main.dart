// Layout Básico:
// Crie um aplicativo Flutter com um layout básico contendo um Container, uma Column e uma Row.
// Adicione alguns widgets (por exemplo, Text, Icon, Image) dentro desses layouts para criar
// uma estrutura visual simples.


import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Básico',
      home: Layout(),
    );
  }
}

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Layout Básico'),
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 158, 44, 44),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Exercicio 6',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Icon(
                Icons.favorite,
                size: 50.0,
                color: Colors.red,
              ),
              SizedBox(height: 20.0),
              Image.asset(
                 'img/imagem2.png',
                width: 100.0,
                height: 100.0,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 30.0,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Avaliação: 5 estrelas',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

