import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/View/favoritos_screen.dart';

// Tela principal para exibir a previsão do tempo
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherController _controller = WeatherController();

  @override
  void initState() {
    // Inicializa a tela e busca a previsão do tempo para a localização atual
    super.initState();
    _getWeatherInit();
  }

  // Método para obter a previsão do tempo inicial
  Future<void> _getWeatherInit() async {
    try {
      // Obtém a posição atual do dispositivo
      Position position = await Geolocator.getCurrentPosition();
      // Obtém a previsão do tempo para a localização atual
      await _controller.getWeatherByLocation(
        position.latitude, position.longitude
      );
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previsão do Tempo"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                // Botão para navegar para a tela de pesquisa
                ElevatedButton(
                  onPressed: () {Navigator.pushNamed(context,'/search');}, 
                  child: const Text("Procurar")
                ),
                // Botão para exibir os favoritos
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FavoritesScreen(),
                      ),
                    );
                  }, 
                  child: const Text("Favoritos")
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Verifica se a lista de previsões está vazia
            _controller.weatherList.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Erro de Conexão"),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        _getWeatherInit();
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    // Exibe o nome da cidade
                    Text(_controller.weatherList.last.name),
                    const SizedBox(height: 10),
                    // Exibe o tipo de clima principal
                    Text(_controller.weatherList.last.main),
                    const SizedBox(height: 10),
                    // Exibe a descrição do clima
                    Text(_controller.weatherList.last.description),
                    const SizedBox(height: 10),
                    // Exibe a temperatura convertida para Celsius
                    Text((_controller.weatherList.last.temp - 273).toStringAsFixed(2)),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        _getWeatherInit();
                      },
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
