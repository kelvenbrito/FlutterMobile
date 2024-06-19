import 'dart:convert';



import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AudioService {
  List<AudioModel> _list = [];
  List<AudioModel> get list => _list;

  final String url = "http://192.168.56.1:3000/audios";

  //fetchList()
  Future<List<AudioModel>> fetchList() async{
    final Response  response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final List<dynamic> list = json.decode(response.body);
      _list.clear();
      _list.addAll(list.map((e) => AudioModel.fromJson(e)).toList());
      return _list;
    }
    return [];

  }
}