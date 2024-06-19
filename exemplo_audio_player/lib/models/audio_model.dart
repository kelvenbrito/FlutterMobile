class AudioModel {
  //atributos
  final String title;
  final String artist;
  final String url;

  AudioModel(this.title, this.artist, this.url);

  //fromMap
  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return new AudioModel(json['title'], json['artist'], json['url']);
  }
}