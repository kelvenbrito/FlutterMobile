import 'package:app_carros/Contoller.dart';
import 'package:app_carros/TelaDetalheCarro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class telaListaCarros extends StatelessWidget {
  final CarroController controllerCarros;
  telaListaCarros(this.controllerCarros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Meus Carros'),
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          // Campo de texto para adicionar novos carros

          // Lista de tarefas usando um Consumer do Provider para atualização automática
          Expanded(
            child: 
            //Consumer<CarroController>(
             // builder: (context, modntel, child) {
                //return 
                ListView.builder(
                  itemCount: controllerCarros.listarCarros.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // Exibe os carros listados no controle
                      title: Text(controllerCarros.listarCarros[index].modelo),
                      //quando clicado o carro vai abrir a tela descricao carro
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TelaDetalheCarro(controllerCarros.listarCarros[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
             // },
           // ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: showDialog(builder: ),),
    );
  }
}

class telaDetalheCarro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
