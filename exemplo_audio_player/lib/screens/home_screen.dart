import 'package:exemplo_audio_player/services/audio_service.dart';
import 'package:flutter/material.dart';

import 'audio_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _service = AudioService();

  @override
  void initState() {
    super.initState();
    _getAudioList();
  }

  Future<void> _getAudioList() async {
    try {
      await _service.fetchList();
    } catch (e) {
      print(e.toString());
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
            future: _getAudioList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (_service.list.isEmpty) {
                return Text('Não há músicas cadastradas');
              } else {
                return ListView.builder(
                  itemCount: _service.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_service.list[index].title),
                      subtitle: Text(_service.list[index].artist),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPlayerScreen(
                              audios: _service.list,
                              initialIndex: index,
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
