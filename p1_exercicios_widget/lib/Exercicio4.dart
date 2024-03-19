import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exercicio 4" )),
        body: Center(
                child:Container(
            padding: const EdgeInsets.all(16.0),
          child:
           Text('Pagina inicial',   style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 0, 0, 0), ),)
        ),),
        bottomNavigationBar: BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
          selectedItemColor: Colors.blue,
        ),
      ),
    );
  }
}
