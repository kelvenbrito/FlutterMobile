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

          ElevatedButton(
            onPressed: () {
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

          // Lista de produtos usando um Consumer do Provider para atualização automática
          Expanded(
            child: Card(
              child: Consumer<ProdutosController>(
                builder: (context, model, child) {
                  itemCount:
                  model.produtos.length;
                  itemBuilder:
                  (context, index) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${model.produtos[index].codigo}')),
                        DataCell(Text('${model.produtos[index].descricao}')),
                        DataCell(Text('${model.produtos[index].quantidade}')),
                        DataCell(Text('${model.produtos[index].preco}')),
                      ],
                    );
                  };
                },
              ),
            ),
          ),

          DataTable(
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
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('1')),
                  DataCell(Text('Produto A')),
                  DataCell(Text('10')),
                  DataCell(Text('20.00')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('2')),
                  DataCell(Text('Produto B')),
                  DataCell(Text('5')),
                  DataCell(Text('15.00')),
                ],
              ),
              // Adicione mais linhas conforme necessário
            ],
          )
        ],
      ),
    );
  }
}