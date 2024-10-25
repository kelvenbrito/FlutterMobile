import 'dart:convert';

import 'package:projeto_apirest_2/models/produto.dart';
import 'package:http/http.dart' as http;

class ProdutosController {
  List<Produto> _listProdutos = [];
  List<Produto> get listProdutos => _listProdutos;
    final String url = "http://10.0.2.2/produtos";

  //getProdutofromJson
 Future<List<Produto>> getProdutos() async {
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> produtos = json.decode(response.body);
      _listProdutos = produtos.map((prod) => Produto.fromJson(prod)).toList();
      return _listProdutos;
    } else {
      print("Erro: ${response.statusCode}");
    }
  } catch (e) {
    print("Erro ao buscar produtos: $e");
  }
  return [];
}

  //postProdutoToJson
  Future<String> postProduto(Produto produto) async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2/produtos"),
        body: json.encode(produto.toJson()),
        headers: {'Content-Type': 'application/json'}
        );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Não foi possível conectar com o servidor');
    }
  }


  Future<bool> updateProduto(int id, Produto produto) async {
    var response = await http.put(
      Uri.parse("$url/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(produto.toJson()[0]),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteProduto(int id) async {
    var response = await http.delete(
      Uri.parse("$url/$id"),
    );
    return response.statusCode == 200;
  }


}