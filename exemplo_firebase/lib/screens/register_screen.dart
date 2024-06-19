import 'package:flutter/material.dart';
import 'package:exemplo_firbbase/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _service = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Insira o email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Insira a senha";
                    } else if (value.length < 6) {
                      return "A senha deve ter pelo menos 6 caracteres";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmedPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Confirme a senha";
                    } else if (value != _passwordController.text) {
                      return "As senhas não conferem";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _registrarUser(context),
                  child: Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registrarUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await _service.registerUsuario(
        _emailController.text,
        _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário registrado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navega para a página de login após o registro
      Navigator.pushNamed(context, '/login');
    }
  }
}
