import 'package:listacompras_flutter/ProdutosController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosScreen extends StatelessWidget {
  TextEditingController _codigo = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _quantidade = TextEditingController();
  TextEditingController _preco = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _codigo,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Codigo'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descricao,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _quantidade,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Quantidade'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _preco,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Preço'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "Adicionar"
                  int? quantidade = int.tryParse(_quantidade.text);
                  double? preco = double.tryParse(_preco.text);

                  if (quantidade != null && preco != null) {
                    Provider.of<ProdutosController>(context, listen: false)
                        .adicionarProduto(
                            _codigo.text, _descricao.text, quantidade, preco);

                    _codigo.clear();
                    _descricao.clear();
                    _quantidade.clear();
                    _preco.clear();
                  } else {
                    print('Erro: Valor inválido para quantidade ou preço.');
                  }
                },
                child: Text('Adicionar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "Editar"
                  // ...
                },
                child: Text('Editar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "Excluir"
                  // ...
                },
                child: Text('Excluir'),
              ),
            ],
          ),

          Expanded(
            child: Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Consumer<ProdutosController>(
                  builder: (context, model, child) {
                    return DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Código'),
                        ),
                        DataColumn(
                          label: Text('Descrição'),
                        ),
                        DataColumn(
                          label: Text('Quantidade'),
                        ),
                        DataColumn(
                          label: Text('Preço'),
                        ),
                      ],
                      rows: model.produtos.map((produto) {
                        return DataRow(
                          cells: [
                            DataCell(Text('${produto.codigo}')),
                            DataCell(Text('${produto.descricao}')),
                            DataCell(Text('${produto.quantidade}')),
                            DataCell(Text('${produto.preco}')),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
