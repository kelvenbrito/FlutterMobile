// Layout Básico com Container:
// Crie um aplicativo Flutter que utilize o widget Container para criar um layout básico.
// Adicione pelo menos três widgets filhos dentro do Container com diferentes estilos e
// cores.

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
              title: Text('Exercicio 1'),
            ),

            // Corpo da tela, composto por um Column (coluna vertical) de widgets
            body: Center(
                child: Column(
              children: [
                Container(
                    color: Colors.lightBlue, // Cor de fundo do Container
                    padding:
                        EdgeInsets.all(20.0), // Espaçamento interno do Containe
                    child: Text(
                      'Widget 1',
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0), ),
                    )),

                SizedBox(height: 20), // Espaço entre os widgets

                // Segundo widget filho
                Container(
                    color: Color.fromARGB(
                        255, 56, 197, 24), // Cor de fundo do Container
                    padding:
                        EdgeInsets.all(40.0), // Espaçamento interno do Containe
                    child: Text(
                      'Widget 2',
                      style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 0, 0, 0)),
                    )),

                SizedBox(height: 20), // Espaço entre os widgets
                // terceiro widget filho
                Container(
                    color: Color.fromARGB(
                        255, 220, 57, 13), // Cor de fundo do Container
                    padding:
                        EdgeInsets.all(80), // Espaçamento interno do Containe
                    child: Text(
                      'Widget 3',
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                    )),
              ],
            ))));
  }
}
