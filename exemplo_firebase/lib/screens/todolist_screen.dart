import 'package:flutter/material.dart';
import 'package:exemplo_firbbase/controllers/todolist_controller.dart';
import 'package:exemplo_firbbase/models/todolist.dart';
import 'package:exemplo_firbbase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service = AuthService(); // Instância do serviço de autenticação
  final TodolistController _controller = TodolistController(); // Instância do controlador da lista de tarefas
  final _tituloController = TextEditingController(); // Controlador para o campo de título da tarefa
  bool _isList = false;

  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid); // Busca a lista de tarefas do usuário atual
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Firebase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _service.logoutUsuario(); // Chama o método de logout do serviço de autenticação
              Navigator.pushReplacementNamed(context, '/home'); // Navega de volta para a tela inicial após logout
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _getList(), // Define o futuro para carregar a lista de tarefas
                  builder: (context, snapshot) {
                    if (_controller.list.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _controller.list.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_controller.list[index].titulo), // Título da tarefa
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditDialog(_controller.list[index]); // Abre o diálogo de edição da tarefa
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await _controller.delete(_controller.list[index].id); // Deleta a tarefa
                                    _getList(); // Recarrega a lista após a exclusão
                                    setState(() {}); // Atualiza a UI
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString()); // Exibe erro se ocorrer um ao carregar a lista
                    } else {
                      return Center(
                        child: CircularProgressIndicator(), // Indicador de carregamento enquanto busca a lista
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Nova Tarefa"),
                content: TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(hintText: "Digite a tarefa"),
                ),
                actions: [
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                  ),
                  TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                      Todolist novaTarefa = Todolist(
                        id: (_controller.list.length + 1).toString(),
                        titulo: _tituloController.text,
                        userId: widget.user.uid,
                        timestamp: DateTime.now(),
                      );
                      _controller.add(novaTarefa); // Adiciona a nova tarefa
                      _getList(); // Recarrega a lista após adicionar a nova tarefa
                      setState(() {}); // Atualiza a UI
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(Todolist task) {
    _tituloController.text = task.titulo; // Preenche o campo de texto com o título atual da tarefa
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Tarefa"),
          content: TextFormField(
            controller: _tituloController,
            decoration: InputDecoration(hintText: "Digite a tarefa"),
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text("Salvar"),
              onPressed: () async {
                // Cria uma cópia da tarefa atualizada
                final tarefaAtualizada = Todolist.fromMap(task.toMap(), task.id);
                tarefaAtualizada.titulo = _tituloController.text;

                await _controller.update(tarefaAtualizada); // Atualiza a tarefa
                _getList(); // Recarrega a lista após atualizar a tarefa
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }
}


// void _showEditDialog(Todolist task) {
//   _tituloController.text = task.titulo; // Preenche o campo de texto com o título atual

//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("Editar Tarefa"),
//         content: TextFormField(
//           controller: _tituloController,
//           decoration: InputDecoration(hintText: "Digite a tarefa"),
//         ),
//         actions: [
//           TextButton(
//             child: Text("Cancelar"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text("Salvar"),
//             onPressed: () async {
//               // Cria uma cópia do objeto task
//               final updatedTask = Todolist(
//                 id: task.id,
//                 titulo: _tituloController.text,
//                 userId: task.userId,
//                 timestamp: Timestamp.fromDate(DateTime.now()), // Convertendo DateTime para Timestamp
//               );

//               updatedTask.timestamp = Timestamp.fromDate(task.timestamp); // Mantendo o timestamp original

//               await _controller.update(updatedTask);
//               _getList();
//               Navigator.of(context).pop(); // Fecha o diálogo
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
