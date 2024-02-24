import 'package:flutter/material.dart';
import 'package:listacompras_flutter/ProdutosModel.dart';

class ProdutosController extends ChangeNotifier {
    //Lista de produtos
  List<Produtos> _produtos = [];
    //Getter para acessar as lista de produtos
  List<Produtos> get produtos=> _produtos;
   //Método para adicionar uma nova tarefa á lista
  void adicionarProduto(String codigo, String descricao, int quantidade, double preco ){
    if(descricao.trim().isNotEmpty){
    _produtos.add(Produtos(codigo, descricao, false, quantidade, preco));
    }
    //Notifica os ouvintes (Widgets) sobre a mudança no estado
  notifyListeners();
  }
  
   // Metodos para marcar uma tarefa como concluida com base no indice
  void marcarComoConcluida(int indice){
    if (indice >= 0 && indice < _produtos.length) {
       _produtos[indice].concluida == false ? _produtos[indice].concluida = true: _produtos[indice].concluida = false;
      
      
      //Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

   //Método para excluir uma tarefa com base no índice
  void excluirProduto(int indice){
    if (indice >= 0 && indice < _produtos.length) {
      _produtos.removeAt(indice);
      //Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

}