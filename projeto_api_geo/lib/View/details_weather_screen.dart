import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';

// Tela para exibir os detalhes do clima de uma cidade
class DetailsWeatherScreen extends StatefulWidget {
  final String city;

  const DetailsWeatherScreen({super.key, required this.city});

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          // FutureBuilder para gerenciar a busca dos dados de clima
          child: FutureBuilder(
            future: _controller.getWeather(widget.city),
            builder: (context, snapshot) {
              // Exibir indicador de carregamento enquanto aguarda os dados
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              // Tratar erros na requisição
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // Quando os dados estão disponíveis, exibir os detalhes do clima
              if (snapshot.hasData && _controller.weatherList.isNotEmpty) {
                final weather = _controller.weatherList.last;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Linha com o nome da cidade e um botão de favorito
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(weather.name),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {
                            // TODO: Adicionar método para lidar com ação de favoritar
                          },
                        ),
                      ],
                    ),
                    // Botão para exibir a temperatura
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.thermostat),
                      label: Text((weather.temp - 273).toStringAsFixed(2) + '°C'),
                    ),
                    // Botão para exibir o tipo de clima principal
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(_getWeatherIcon(weather.main)),
                      label: Text(weather.main),
                    ),
                    // Botão para exibir a descrição do clima
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.description),
                      label: Text(weather.description),
                    ),
                  ],
                );
              }

              // Se não houver dados disponíveis, exibir uma mensagem
              return const Text('Não há dados disponíveis');
            },
          ),
        ),
      ),
    );
  }

  // Método para obter o ícone correspondente ao tipo de clima
  IconData _getWeatherIcon(String main) {
    switch (main.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      default:
        return Icons.help_outline;
    }
  }
}
