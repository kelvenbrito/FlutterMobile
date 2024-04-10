class CadastroModel {
  //atributos
  int? id;
  String nome;
  String email;
  String senha;
  String dataNasc;
  String telefone;

  CadastroModel({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.dataNasc,
    required this.telefone,
  });

  //mapeamento
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'datanasc': dataNasc,
      'telefone': telefone,
    };
  }

  factory CadastroModel.fromMap(Map<String, dynamic> map) {
    return CadastroModel(
        id: map['id'],
        nome: map['nome'],
        email: map['email'],
        senha: map[' senha'],
        dataNasc: map['dataNasc'],
        telefone: map['telefone']);
  }
}
