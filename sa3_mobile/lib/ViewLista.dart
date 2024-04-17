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
  //Atributos
  late SharedPreferences _prefs;
  final String email;
  List<String> tasks = []; // Lista de tarefas
  
  final TextEditingController _controller =
      TextEditingController(); // Controlador de texto para o campo de entrada de nova tarefa
   
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
      tasks = _prefs.getStringList('${email}tasks') ??
          []; // Carrega as tarefas armazenadas ou uma lista vazia se não houver tarefas
    });
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtém as preferências compartilhadas
    await prefs.setStringList('${email}tasks',
        tasks); // Salva a lista de tarefas nas preferências compartilhadas
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

  @override
  Widget build(BuildContext context) {
     bool checked = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'), // Título da barra de aplicativos
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: checked,
              onChanged: (bool? newvalue) {
                setState(() {
                  checked = newvalue!;
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
                title: Text('Nova Tarefa'), // Título do diálogo de nova tarefa
                content: TextField(
                  controller:
                      _controller, // Controlador de texto para o campo de entrada
                  decoration: InputDecoration(
                      hintText: 'Digite a tarefa'), // Dica no campo de entrada
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        tasks.add(
                            _controller.text); // Adiciona a nova tarefa à lista
                        saveTasks(); // Salva as tarefas atualizadas
                        _controller.clear(); // Limpa o campo de entrada
                        Navigator.of(context).pop(); // Fecha o diálogo
                      });
                    },
                    child: Text('Adicionar'), // Botão para adicionar a tarefa
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add), // Ícone do botão de adicionar
      ),
    );
  }
}
