
import 'package:aplicativo_autent_config/main.dart';
import 'package:flutter/material.dart';


class InternaPage extends StatefulWidget {
  const InternaPage({Key? key});

  @override
  State<InternaPage> createState() => _InternaPageState();
}

class _InternaPageState extends State<InternaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
      body: Center(
        child: Text(
          'Página Interna',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
   ),
   );
}
}