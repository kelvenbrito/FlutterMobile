import 'package:exemplo_api/screen.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(const Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Exemplo API",
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    home: WeatherScreen()
    );
  }
}