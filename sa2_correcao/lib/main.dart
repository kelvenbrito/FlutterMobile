import 'package:flutter/material.dart';
import 'package:sa2_correcao/ViewLogin.dart';

void main(){
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA2",
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}