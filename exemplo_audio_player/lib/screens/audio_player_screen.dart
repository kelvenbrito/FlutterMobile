import 'package:audioplayers/audioplayers.dart';
import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<AudioModel> audios;
  final int initialIndex;

  const AudioPlayerScreen({Key? key, required this.audios, required this.initialIndex}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  late int _currentIndex;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex;
    _playAudio(widget.audios[_currentIndex].url); // Inicia a reprodução da primeira faixa ao iniciar a tela.
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Libera os recursos do AudioPlayer ao descartar a tela.
    super.dispose();
  }

  void _playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url)); // Inicia a reprodução da faixa atual.
    setState(() {
      _isPlaying = true; // Atualiza o estado para indicar que está reproduzindo.
    });
  }

  void _pauseAudio() async {
    await _audioPlayer.pause(); // Pausa a reprodução da faixa atual.
    setState(() {
      _isPlaying = false; // Atualiza o estado para indicar que está pausado.
    });
  }

  void _playPause() {
    if (_isPlaying) {
      _pauseAudio(); // Alterna entre pausar e retomar a reprodução.
    } else {
      _playAudio(widget.audios[_currentIndex].url); // Inicia a reprodução se estiver pausado.
    }
  }

  void _playNext() {
    if (_currentIndex < widget.audios.length - 1) {
      _currentIndex++;
      _playAudio(widget.audios[_currentIndex].url); // Move para a próxima faixa e inicia a reprodução.
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _playAudio(widget.audios[_currentIndex].url); // Move para a faixa anterior e inicia a reprodução.
    }
  }

  void _restartAudio() {
    _audioPlayer.seek(Duration.zero); // Reinicia a faixa atual para o início.
    if (!_isPlaying) {
      _playAudio(widget.audios[_currentIndex].url); // Se não estiver reproduzindo, inicia a reprodução.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audios[_currentIndex].title), // Exibe o título da faixa atual na app bar.
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.skip_previous),
              onPressed: _playPrevious,
              iconSize: 50,
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _playPause,
              iconSize: 64.0,
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: _playNext,
              iconSize: 50,
            ),
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: _restartAudio,
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
