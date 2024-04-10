import 'package:aplicativo_autent_config/CadastroView.dart';
import 'package:aplicativo_autent_config/Controller.dart';
import 'package:aplicativo_autent_config/Interna.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginForm(),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  // Navegar para a página de cadastro quando o botão é pressionado
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroPage()),
                  );
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Obtém o nome de usuário e senha do TextFormField
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Chama o método acessoInterno para verificar as credenciais no banco de dados
                bool loginSuccess =
                    await BancoDadosUsuario().acessoInterno(username, password);

                // Verifica se o login foi bem-sucedido
                if (loginSuccess) {
                  // Faça algo após um login bem-sucedido, como navegar para outra tela
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InternaPage()),
                  );
                } else {
                  // Exibe uma mensagem de erro se o login não foi bem-sucedido
                  print('Invalid username or password');
                }
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
