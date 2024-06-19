import 'dart:convert';
import 'package:http/http.dart' as http;

// Classe responsável por fazer requisições à API de clima do OpenWeatherMap
class WeatherService {
  // Chave de API necessária para autenticação nas requisições
  final String apiKey = 'b9ebe666087f299f5e2aad3a03d093b6';
  
  // URL base da API do OpenWeatherMap
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  // Método para obter dados climáticos com base no nome da cidade
  Future<Map<String, dynamic>> getWeather(String city) async {
    // Constrói a URL da requisição com base na cidade e na chave de API
    final url = Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey');
    
    // Faz a requisição HTTP GET para a API
    final response = await http.get(url);
    
    // Verifica se o status da resposta é 200 (OK)
    if (response.statusCode == 200) {
      // Converte a resposta JSON em um mapa e retorna
      return json.decode(response.body);
    } else {
      // Lança uma exceção se houver falha na requisição
      throw Exception('Falha ao carregar dados meteorológicos');
    }
  }

  // Método para obter dados climáticos com base na latitude e longitude
  Future<Map<String, dynamic>> getWeatherByLocation(double lat, double lon) async {
    // Constrói a URL da requisição com base na latitude, longitude e na chave de API
    final url = Uri.parse('$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey');
    
    // Faz a requisição HTTP GET para a API
    final response = await http.get(url);
    
    // Verifica se o status da resposta é 200 (OK)
    if (response.statusCode == 200) {
      // Converte a resposta JSON em um mapa e retorna
      return json.decode(response.body);
    } else {
      // Lança uma exceção se houver falha na requisição
      throw Exception('Falha ao carregar dados meteorológicos');
    }
  }
}
