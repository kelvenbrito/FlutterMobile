import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

class CityDbController {
  List<City> _cities = [];
  final CityDataBaseService _dbService = CityDataBaseService();

  List<City> cities() => _cities;

  Future<List<City>> listCities() async {
    List<Map<String, dynamic>> maps = (await _dbService.getAllCities()).cast<Map<String, dynamic>>();
    _cities = maps.map<City>((e) => City.fromMap(e)).toList();
    return _cities;
  }

  Future<void> addCities(City city) async {
    _dbService.insertCity(city);
  }

  Future<void> addToFavorites(City city, Function() setStateCallback) async {
    
    await _dbService.updateCity(city);
    // Atualiza a lista localmente
    int index = _cities.indexWhere((element) => element.cityName == city.cityName);
    if (index != -1) {
      _cities[index] = city;
    }
    setStateCallback(); // Chama o callback para atualizar o estado no widget pai
  }
}
