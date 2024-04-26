

class Produto {
  //Atributos
  final int id;
  final String nome;
  final String descricao;
  final int quantidade;
  final String foto;
  final double preco;
  final List<String> categorias;

  //Construtor
  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.foto,
    required this.quantidade,
    required this.preco,
    required this.categorias,
  });

  //Métodos (toJson / fromJson)
  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'foto': foto,
        'quantidade': quantidade,
        'preco': preco,
        'categorias': categorias
      };
    
    factory Produto.fromJson(Map<String,dynamic> json) => Produto(
      id: json['id'],
      nome: json['nome'],
      descricao :json['descricao'],
      foto: json['foto'],
      quantidade: json['quantidade'],
      preco: json['preco'],
      categorias:List<String>.from(json['categorias']),
    );

}
