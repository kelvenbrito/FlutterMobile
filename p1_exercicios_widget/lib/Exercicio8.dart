// Criação de Cards:
// Desenvolva uma tela que utilize o widget Card para exibir informações de produtos fictícios.
// Os cards devem conter uma imagem, título e descrição.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 8',
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ProductCard(
            image: AssetImage('img/imagem2.png'),
            title: 'Produto 1',
            description: 'Descrição do Produto 1.',
            imageWidth: 100, // Definindo a largura da imagem
            imageHeight: 100, // Definindo a altura da imagem
          ),
          ProductCard(
            image: AssetImage('img/imagem2.jpg'),
            title: 'Produto 2',
            description: 'Descrição do Produto 2.',
            imageWidth: 100, // Definindo a largura da imagem
            imageHeight: 100, // Definindo a altura da imagem
          ),
          ProductCard(
            image: AssetImage('img/imagem3.jpg'),
            title: 'Produto 3',
            description: 'Descrição do Produto 3.',
            imageWidth: 100, // Definindo a largura da imagem
            imageHeight: 100, // Definindo a altura da imagem
          ),
          // Adicione mais ProductCards conforme necessário
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ImageProvider<Object> image;
  final String title;
  final String description;
  final double imageWidth; // Nova propriedade para definir a largura da imagem
  final double imageHeight; // Nova propriedade para definir a altura da imagem

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.imageWidth, 
    required this.imageHeight, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image(
              image: image,
              fit: BoxFit.cover,
              width: imageWidth, // Definindo a largura da imagem
              height: imageHeight, // Definindo a altura da imagem
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
