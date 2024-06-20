import 'package:exemplo_audio_player/services/audio_service.dart';
import 'package:flutter/material.dart';

import 'audio_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _service = AudioService(); // Instância da classe de serviço de áudio

  @override
  void initState() {
    super.initState();
    _getAudioList(); // Chamada para carregar a lista de áudios ao iniciar a tela
  }

  Future<void> _getAudioList() async {
    try {
      await _service.fetchList(); // Método assíncrono para buscar a lista de áudios
    } catch (e) {
      print(e.toString()); // Tratamento de erro caso ocorra uma exceção ao buscar a lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: _getAudioList(), // Define o futuro para carregar a lista de áudios
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Mostra um indicador de carregamento enquanto busca a lista
              } else if (_service.list.isEmpty) {
                return Text('Não há músicas cadastradas'); // Mensagem mostrada se a lista estiver vazia
              } else {
                return ListView.builder(
                  itemCount: _service.list.length, // Quantidade de itens na lista de áudios
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_service.list[index].title), // Título do áudio
                      subtitle: Text(_service.list[index].artist), // Artista do áudio
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPlayerScreen(
                              audios: _service.list, // Lista de áudios a ser reproduzida
                              initialIndex: index, // Índice inicial para reprodução
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
