import 'package:aplicativo_autent_config/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override 
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage>{
  final dbHelper = BancoDadosUsuario();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
appBar: AppBar(title: Text('Login')),
body: Container(),
    );
  }
}