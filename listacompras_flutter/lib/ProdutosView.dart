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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "Adicionar"
                    Provider.of<ProdutosController>(context, listen: false)
                        .adicionarProduto(
                            _codigo.text, _descricao.text, _quantidade.text, _preco.text);

                    _codigo.clear();
                    _descricao.clear();
                    _quantidade.clear();
                    _preco.clear();
                 
                },
                child: Text('Adicionar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "editar"
                    Provider.of<ProdutosController>(context, listen: false)
                        .editarProduto(
                            _codigo.text, _descricao.text, _quantidade.text, _preco.text);
                    
                      _codigo.clear();
                    _descricao.clear();
                    _quantidade.clear();
                    _preco.clear();
                            
                
               
                },
                child: Text('Editar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "Excluir"

                  Provider.of<ProdutosController>(context, listen: false)
                      .excluirProduto(_codigo.text);
                      
                    _codigo.clear();
                    _descricao.clear();
                    _quantidade.clear();
                    _preco.clear();
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
