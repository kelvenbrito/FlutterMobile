import 'package:projeto_api_geo/Model/weather_model.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class WeatherController {
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];
   List<String> _favoriteCities = [];

  List<Weather> get weatherList => _weatherList;

  List<String> get favoriteCities => _favoriteCities;

Future<bool> findCity(String city) async {
  try {
    Weather weather = Weather.fromJson(await _service.getWeather(city));
    if (weather != null) {
      _weatherList.clear(); // Limpa a lista atual
      _weatherList.add(weather); // Adiciona o novo resultado
      return true; // Retorna true se a cidade foi encontrada
    } else {
      return false; // Retorna false se a cidade não foi encontrada
    }
  } catch (e) {
    print(e);
    _weatherList.clear(); // Limpa a lista em caso de erro
    return false; // Retorna false se ocorreu um erro
  }
}



  Future<void> getWeatherByLocation(double lat, double lon) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeatherByLocation(lat, lon));
      _weatherList.clear(); // Limpa a lista atual
      _weatherList.add(weather); // Adiciona o novo resultado
    } catch (e) {
      print(e);
      _weatherList.clear(); // Limpa a lista em caso de erro
    }
  }

  Future<void> getWeather(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      _weatherList.clear(); // Limpa a lista atual
      _weatherList.add(weather); // Adiciona o novo resultado
    } catch (e) {
      print(e);
      _weatherList.clear(); // Limpa a lista em caso de erro
    }
  }

  
    void addToFavorites(String city) {
    if (!_favoriteCities.contains(city)) {
      _favoriteCities.add(city);
    }
  }

   void removeFromFavorites(String city) {
    _favoriteCities.remove(city);
  }

    void removeFavorite(int index) {
    _weatherList.removeAt(index);
  }
}

