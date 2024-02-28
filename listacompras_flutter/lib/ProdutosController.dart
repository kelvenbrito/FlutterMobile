import 'package:flutter/material.dart';
import 'package:listacompras_flutter/ProdutosModel.dart';

class ProdutosController extends ChangeNotifier {
  //Lista de produtos
  List<Produtos> _produtos = [];
  //Getter para acessar as lista de produtos
  List<Produtos> get produtos => _produtos;
  //Método para adicionar uma nova tarefa á lista
  void adicionarProduto(
      String codigo, String descricao, String quantidade, String preco) {
    if (codigo.trim().isNotEmpty && descricao.trim().isNotEmpty && quantidade.trim().isNotEmpty && preco.trim().isNotEmpty ) {
      int? quantidadeInt = int.tryParse(quantidade);
      double? precoDouble = double.tryParse(preco);

      if (quantidadeInt != null && precoDouble != null) {
        _produtos.add(
            Produtos(codigo, descricao, false, quantidadeInt, precoDouble));
        notifyListeners();
      } else {
        mostrarAviso('Erro: No campo quantidade ou preço deve usar numeros.');
      }
    }else {
        mostrarAviso('Erro: verifique se há algum vampo vazio.');
      }
  }

  void editarProduto(String novoCodigo, String novaDescricao,
      String novaQuantidade, String novoPreco) {
    if (novoCodigo.trim().isNotEmpty && novaDescricao.trim().isNotEmpty && novaQuantidade.trim().isNotEmpty && novoPreco.trim().isNotEmpty )  {
      int? novaQuantidadeInt = int.tryParse(novaQuantidade);
      double? novoPrecoDouble = double.tryParse(novoPreco);

      if (novaQuantidadeInt != null && novoPrecoDouble != null) {
        for (int i = 0; i < _produtos.length; i++) {
          if (_produtos[i].codigo == novoCodigo) {
            _produtos[i].descricao = novaDescricao;
            _produtos[i].quantidade = novaQuantidadeInt;
            _produtos[i].preco = novoPrecoDouble;
          }else{
            mostrarAviso('Erro: O codigo não foi encontrado na lista caso queira adicionar um novo produto clique no botão adicionar.');
          }
        }
        notifyListeners();
      } else {
        mostrarAviso('Erro: No campo Quantidade ou preço deve usar numeros.');
      }
    }else {
        mostrarAviso('Erro: verifique se há algum vampo vazio.');
      }
  }

  //Método para excluir uma tarefa com base no índice
  void excluirProduto(String codigoDigitado) {
    for (int i = 0; i < _produtos.length; i++) {
      if (_produtos[i].codigo == codigoDigitado) {
        _produtos.removeWhere((produto) => produto.codigo == codigoDigitado);
      } else {
        mostrarAviso('Erro: O codigo não esta na lista, digite um codigo valido para excluir.');
      }
      //Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  BuildContext myBuildContext;

  ProdutosController(this.myBuildContext);
  void mostrarAviso(String mensagem) {
    // Exibe um SnackBar com a mensagem de aviso
    ScaffoldMessenger.of(myBuildContext).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(seconds: 5), // Tempo de exibição do SnackBar
      ),
    );
  }
}
