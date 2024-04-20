import 'package:flutter/material.dart';
import 'package:sa3_mobile/ViewLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaPage extends StatefulWidget {
  final String email;

  ListaPage({required this.email});

  @override
  _ListaPageState createState() => _ListaPageState(email: email);
}

class _ListaPageState extends State<ListaPage> {
  //atributos
  late SharedPreferences _prefs;
  final String email;
  List<String> tasks = []; // Lista de tarefas
  List<bool> taskChecked = []; // Lista de estados dos checkboxes
  // Controlador de texto para o campo de entrada de nova tarefa
  final TextEditingController _controller = TextEditingController();
  bool _showOnlyChecked =
      false; // Estado para controlar se mostrar apenas as tarefas marcadas

  _ListaPageState({required this.email});

  //Métodos
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // Carrega as tarefas armazenadas ou uma lista vazia se não houver tarefas
      tasks = _prefs.getStringList('${email}tasks') ?? [];
      taskChecked = List<bool>.generate(
          tasks.length, (index) => false); // Inicializa com false
    });
  }

  Future<void> saveTasks() async {
    // Obtém as preferências compartilhadas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Salva a lista de tarefas nas preferências compartilhadas
    await prefs.setStringList('${email}tasks', tasks);
  }

  // Método para editar a tarefa
  void _editTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        String editedTask = tasks[index];
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            onChanged: (value) {
              editedTask = value;
            },
            controller: TextEditingController(text: tasks[index]),
            decoration: InputDecoration(
              hintText: 'Digite a tarefa',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index] = editedTask;
                  saveTasks();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza de que deseja excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancela a exclusão
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.removeAt(index); // Remove a tarefa da lista
                  taskChecked.removeAt(index); // Remove o estado correspondente
                  saveTasks(); // Salva as tarefas atualizadas
                  Navigator.of(context).pop(true); // Confirma a exclusão
                });
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tarefa excluída com sucesso!')),
        );
      }
    });
  }

  void _toggleShowOnlyChecked() {
    setState(() {
      _showOnlyChecked = !_showOnlyChecked;
    });
  }

  void _logout() {
    // Limpa as preferências de email
    _prefs.remove('email');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout realizado sucesso!')),
    );
    // Navega de volta para a página de login
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredTasks = _showOnlyChecked
        ? tasks.where((task) => taskChecked[tasks.indexOf(task)]).toList()
        : tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Mostrar tarefas concluidas'),
              Switch(
                value: _showOnlyChecked,
                onChanged: (value) {
                  _toggleShowOnlyChecked();
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                int originalIndex = tasks.indexOf(filteredTasks[index]);
                return ListTile(
                  leading: Checkbox(
                    value: taskChecked[originalIndex],
                    onChanged: (bool? newValue) {
                      setState(() {
                        taskChecked[originalIndex] = newValue ?? false;
                        saveTasks();
                      });
                    },
                  ),
                  title: Text(filteredTasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(context, originalIndex);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(context, originalIndex);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Nova Tarefa'),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Digite a tarefa',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (_controller.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Por favor, insira uma tarefa válida')),
                        );
                      } else {
                        setState(() {
                          tasks.add(_controller.text);
                          taskChecked.add(false);
                          saveTasks();
                          _controller.clear();
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}