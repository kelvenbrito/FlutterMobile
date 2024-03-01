import 'package:app_carros/Model.dart';

class CarroController {
  //Atributo
  List<Carro> _carrosLista = [
   Carro("Fiat Uno", 1992, "caminho da imagem"),
   Carro("Classic", 2012, "Caminho da imagem")
  ];


  //Metodos
  List<Carro> get listarCarros => _carrosLista;

  //Outros métodos
  void adicionarCarro(String modelo, int ano, String imagemUrl){
    Carro carro = Carro(modelo, ano, imagemUrl);
    _carrosLista.add(carro);
  }

}