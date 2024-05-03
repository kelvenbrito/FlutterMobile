import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obter o tamanho da tela
    final Size screenSize = MediaQuery.of(context).size;

    // Definir a largura máxima para exibição do conteúdo
    double contentWidth = screenSize.width > 600 ? 600 : screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Layout'),
      ),
      body: Center(
        child: Container(
          width: contentWidth * 0.8, // 80% da largura disponível
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Seu conteúdo aqui!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Clique Aqui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}