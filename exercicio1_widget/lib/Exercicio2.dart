// Organização com Row e Column:
// Desenvolva uma interface que faça uso dos widgets Row e Column para organizar
// elementos de forma horizontal e vertical.
// Adicione diversos widgets (como Text, Icon e Image) para demonstrar a organização.

// Importa o pacote de material Flutter
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Função principal que inicializa a aplicação Flutter
void main() {
// Inicia a execução da aplicação com o widget MyApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exercicio 2'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(children: [
                      Text('coluna 1'),
                      Icon(Icons.star),
                      Image.network(
                        'https://imgs.search.brave.com/wFmDt-vWjQyGggws9vTjLmmNS4vchlH6D0EeKb4a1io/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTY3/OTMzNjk2OS9wdC92/ZXRvcmlhbC9zd2Fy/bS1vZi1kcm9uZXMt/b3Zlci1hLWNpdHku/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PXRYOF9GNVVucDdQ/MkZQXzR3NnFxdTZH/LVdQNFRwYkpCbnZZ/LWxYbTdPcFE9',
                        width: 50,
                        height: 50,
                      ),
                    ]),
                    Column(children: [
                      Text('coluna 2'),
                      Image.asset('img/imagem2.jpg'),
                      Icon(Icons.access_alarm),
                    ]),
                  ],
                ),
                Row(children: [
                  Column(children: [
                    Text('coluna 1'),
                    Icon(Icons.beach_access_outlined),
                    Image.asset('assets/img/imagem3.jpg'),
                  ]),
                    Column(children: [
                    Text('coluna 2'),
                    Icon(Icons.beach_access_outlined),
                    Image.asset('assets/img/imagem3.jpg'),
                  ]),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
