import 'package:aplicativo_autent_config/CadastroView.dart';
import 'package:aplicativo_autent_config/LoginView.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp  extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Pagina inicial",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: LoginPage(),
    );
  }
}