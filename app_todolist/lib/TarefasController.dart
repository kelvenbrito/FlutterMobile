
import 'package:app_todolist/TarefasModel.dart';
import 'package:flutter/material.dart';

class TarefasController extends ChangeNotifier{
  //Lista de tarefas
  List<Tarefas> _tarefas = [];
  //Getter para acessar as lista de tarefas
  List<Tarefas> get tarefas => _tarefas;

  //Método para adicionar uma nova tarefa á lista
  void adicionarTarefa(String descricao, DateTime){
    if(descricao.trim().isNotEmpty){
    _tarefas.add(Tarefas(descricao, false,getData()));
    }
    //Notifica os ouvintes (Widgets) sobre a mudança no estado
  notifyListeners();
  }

  //Metodos para marcar uma tarefa como concluida com base no indice
  void marcarComoConcluida(int indice){
    if (indice >= 0 && indice < _tarefas.length) {
       _tarefas[indice].concluida == false ? _tarefas[indice].concluida = true: _tarefas[indice].concluida = false;
      
      
      //Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  //Método para excluir uma tarefa com base no índice
  void excluirTarefa(int indice){
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas.removeAt(indice);
      //Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }
  String getData(){
    return DateFormat('dd/MM/yy');
  }
}

