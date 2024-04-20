import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Controller.dart';
import 'Model.dart';
import 'ViewCadastro.dart';
import 'ViewLista.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  TextEditingController _emailController = TextEditingController(); // Controlador para o campo de email
  TextEditingController _senhaController = TextEditingController(); // Controlador para o campo de senha
  bool _loading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) { // Verifica se a chave é válido
      String email = _emailController.text; // Obtém o valor do campo de email
      String senha = _senhaController.text; // Obtém o valor do campo de senha

      setState(() {
        _loading = true; // Define o _loading como verdadeiro durante o login
      });

      BancoDadosCrud bancoDados = BancoDadosCrud(); // Instancia a classe de controle de banco de dados
      try {
        User? user = await bancoDados.getUser(email, senha); // Obtém o usuário do banco de dados
        if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login realizado com sucesso!')),
    );
          Navigator.push(
            context,
            MaterialPageRoute(
              // Navega para a página de lista após o login bem-sucedido
              builder: (context) => ListaPage(email: user.email),   
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // Exibe uma mensagem se o email ou senha estiverem incorretos
            content: Text('Email ou senha incorretos'),
          ));
        }
      } catch (e) {
        print('Erro  no login: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // Exibe uma mensagem se o email ou senha estiverem incorretos
          content: Text('Erro no login. Tente novamente.'),
        ));
      } finally {
        setState(() {
          _loading = false; // Define o loading como falso após o login
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey, // Associa a chave global ao formulário
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Acessar'),
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()),
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);  // Verifica se o email é válido
  }
}