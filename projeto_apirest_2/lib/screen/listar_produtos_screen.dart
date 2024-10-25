import 'package:flutter/material.dart';
import 'package:projeto_apirest_2/controllers/produtos_controllers.dart';

import 'package:projeto_apirest_2/models/produto.dart';

class ListarProdutosScreen extends StatefulWidget {
  const ListarProdutosScreen({super.key});

  @override
  State<ListarProdutosScreen> createState() => _ListarProdutosScreenState();
}

class _ListarProdutosScreenState extends State<ListarProdutosScreen> {
  final ProdutosController _controller = ProdutosController();

  @override
  void initState() {
    super.initState();
    _getProdutos();
  }

  Future<void> _getProdutos() async {
    try {
      await _controller.getProdutos();
      setState(() {}); // Atualiza a tela após obter os produtos
    } catch (e) {
      print(e);
    }
  }

  // Método para atualizar um produto
  Future<void> _updateProduto(Produto produto) async {
    TextEditingController nomeController =
        TextEditingController(text: produto.nome);
    TextEditingController codigoController =
        TextEditingController(text: produto.codigo);
    TextEditingController precoController =
        TextEditingController(text: produto.preco.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Atualizar Produto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: codigoController,
              decoration: InputDecoration(labelText: 'Código'),
            ),
            TextField(
              controller: precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              produto.nome = nomeController.text;
              produto.codigo = codigoController.text;
              produto.preco = double.parse(precoController.text);

              await _controller.updateProduto(produto.id as int, produto);
              Navigator.pop(context);
              _getProdutos(); // Atualiza a lista de produtos após a atualização
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  // Método para deletar um produto
  Future<void> _deleteProduto(int id) async {
    await _controller.deleteProduto(id);
    _getProdutos(); // Atualiza a lista de produtos após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de Produtos"),
      ),
      body: FutureBuilder(
        future: _getProdutos(),
        builder: (context, snapshot) {
          if (_controller.listProdutos.isNotEmpty) {
            return ListView.builder(
              itemCount: _controller.listProdutos.length,
              itemBuilder: (context, index) {
                final produto = _controller.listProdutos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(
                      "Código: ${produto.codigo} - Preço: R\$ ${produto.preco}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _updateProduto(
                            produto), // Chama o método de atualização
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteProduto(
                            produto.id as int), // Chama o método de exclusão
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
