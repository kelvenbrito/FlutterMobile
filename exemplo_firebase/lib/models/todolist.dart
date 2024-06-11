class Todolist {
  //atributos
  String id;
  final String titulo;
  final String userId;
  final DateTime timestamp;

  Todolist({required this.titulo, required this.userId, required this.timestamp});

// tomap
Map<String, dynamic> toMap() {
  return {
    'id': id,
    'titulo': titulo,
    'userid': userId,
    'timestamp': timestamp.toIso8601String(),
  };
}

  // fromMap
  factory Todolist.fromMap(Map<String, dynamic> map) {
    return Todolist(
      id: map['id'],
      titulo: map['titulo'],
      userId: map['userid'],
      timestamp: map['timestamp'],
    );
  }
}