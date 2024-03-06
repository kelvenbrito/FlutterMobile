// Importa o pacote de material Flutter
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Função principal que inicializa a aplicação Flutter
void main() {
// Inicia a execução da aplicação com o widget MyApp
  runApp(MyApp());
}

// Definindo a classe MyApp que herda de StatelessWidget
class MyApp extends StatelessWidget {
// Método build, obrigatório em StatelessWidget, retorna a árvore de widgets da aplicação
  @override
  Widget build(BuildContext context) {
// Retorna um MaterialApp, que é o widget raiz da aplicação Flutter
    return MaterialApp(
// Configura a tela inicial como um Scaffold
      home: Scaffold(
// Barra superior da tela (AppBar)
        appBar: AppBar(
// Título da barra superior
          title: Text('Exemplo de Árvore de Widgets'),
        ),
// Corpo da tela, composto por um Column (coluna vertical) de widgets
        body: Column(
          children: [
// Texto simples como primeiro filho da coluna
            Text('Primeiro Filho'),
// Container contendo um Row (linha horizontal) de dois Textwidgets

            Container(
              color: Colors.lightBlue, // Cor de fundo do Container
              padding: EdgeInsets.all(16.0), // Espaçamento interno do Containe
              child: Row(
                children: [
                  Column(children: [
                    Text('Filho Aninhado 1.1'),
                    Text('Filho Aninhado 1.2')
                  ]),
                  SizedBox(width: 50),
                  Column(children: [Text('Filho Aninhado 2')]),
                ],
              ),
            ),

// Texto simples como segundo filho da coluna
            Text('Segundo Filho'),
          ],
        ),
      ),
    );
  }
}
