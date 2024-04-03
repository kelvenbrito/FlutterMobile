
import 'package:exemplo_sqllite/View.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo SQLLite",
      theme: ThemeData(
       primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}