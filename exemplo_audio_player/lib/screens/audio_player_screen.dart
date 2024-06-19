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
    _playAudio(widget.audios[_currentIndex].url);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url));
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _playPause() {
    if (_isPlaying) {
      _pauseAudio();
    } else {
      _playAudio(widget.audios[_currentIndex].url);
    }
  }

  void _playNext() {
    if (_currentIndex < widget.audios.length - 1) {
      _currentIndex++;
      _playAudio(widget.audios[_currentIndex].url);
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _playAudio(widget.audios[_currentIndex].url);
    }
  }

  void _restartAudio() {
    _audioPlayer.seek(Duration.zero);
    if (!_isPlaying) {
      _playAudio(widget.audios[_currentIndex].url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audios[_currentIndex].title),
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
