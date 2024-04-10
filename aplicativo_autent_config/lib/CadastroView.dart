import 'package:aplicativo_autent_config/CadastroModel.dart';
import 'package:aplicativo_autent_config/Controller.dart';
import 'package:aplicativo_autent_config/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final dbHelper = BancoDadosUsuario();
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _dataNascController = TextEditingController();
  


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira sua Senha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataNascController,
                decoration: InputDecoration(labelText: 'Data de Nascimento'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira sua data de nascimento';
                  }
                  return null;
                },
              ),
                 SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
        
            _addContact();
      
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    
                  );
          }
              
            },
            child: Text('Cadastrar'),
          ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para adicionar um novo contato ao banco de dados
  void _addContact() {
    final newContact = CadastroModel(
      id: null,
      nome: _nomeController.text,
      email: _emailController.text,
      telefone: _telefoneController.text,
      senha: _senhaController.text,
      dataNasc: _dataNascController.text, 
      
    );

    dbHelper.create(newContact);
    setState(() {
      // Atualiza a lista de contatos
    });
  }

  
}