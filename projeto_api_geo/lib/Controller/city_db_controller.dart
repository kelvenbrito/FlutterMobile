import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';


class CityDbController {
  // Atributo
  List<City> _cities = [];
  final CityDataBaseService _dbService = CityDataBaseService();

  // Getter
  List<City> get cities => _cities;

  // Métodos
  // Listar Cidades
  Future<List<City>> listCities() async {
    try {
      List<Map<String, dynamic>> maps = await _dbService.getAllCities();
      _cities = maps.map((map) {
        try {
          return City.fromMap(map);
        } catch (e) {
          // Log and handle the error for debugging
          print("Error mapping city: $e");
          return null;
        }
      }).where((city) => city != null).cast<City>().toList();
      return _cities;
    } catch (e) {
      // Log and handle the error for debugging
      print("Error listing cities: $e");
      return [];
    }
  }

  // Adicionar Cidade
  Future<void> addCities(City city) async {
    try {
      await _dbService.insertCity(city);
      // Atualizar lista local após inserção
      await listCities();
    } catch (e) {
      // Log and handle the error for debugging
      print("Error adding city: $e");
    }
  }

  // Remover Cidade
  Future<void> deleteCity(City city) async {
    try {
      await _dbService.deleteCity(city.cityName);
      // Atualizar lista local após exclusão
      await listCities();
    } catch (e) {
      // Log and handle the error for debugging
      print("Erro ao excluir cidade: $e");
    }
  }
}