import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaPage extends StatefulWidget {
  //atributo
  final String email;

  ListaPage({required this.email});

  @override
  _ListaPageState createState() => _ListaPageState(email: email);
}

class _ListaPageState extends State<ListaPage> {
  late SharedPreferences _prefs;
  final String email;
  List<String> tasks = [];
  List<bool> taskChecked = []; // Lista de estados dos checkboxes
  final TextEditingController _controller = TextEditingController();

  _ListaPageState({required this.email});

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

Future<void> _loadPreferences() async {
  _prefs = await SharedPreferences.getInstance();
  setState(() {
    tasks = _prefs.getStringList('${email}tasks') ?? [];
    taskChecked = List<bool>.generate(tasks.length, (index) => false); // Inicializa com false
  });
}

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('${email}tasks', tasks);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: taskChecked[index] ?? false, // Use o estado armazenado ou false se não houver
              onChanged: (bool? newValue) {
                setState(() {
                  taskChecked[index] = newValue ?? false; // Atualize o estado
                  saveTasks();
                });
              },
            ),
            title: Text(tasks[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editTask(context, index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      tasks.removeAt(index);
                      taskChecked.removeAt(index); // Remova o estado correspondente
                      saveTasks();
                    });
                  },
                ),
              ],
            ),
          );
        },
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
                      setState(() {
                        tasks.add(_controller.text);
                        taskChecked.add(false); // Adicione um novo estado
                        saveTasks();
                        _controller.clear();
                        Navigator.of(context).pop();
                      });
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
