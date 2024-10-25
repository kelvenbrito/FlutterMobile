import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Model/weather_model.dart';
import 'package:projeto_api_geo/View/favoritos_screen.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;

  const DetailsWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() async {
    await _controller.getWeather(widget.city);
    setState(() {}); // Atualiza a UI após obter os dados do clima
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes - ${widget.city}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: _controller.weatherList.isEmpty
              ? CircularProgressIndicator() // Exibe indicador de carregamento enquanto não há dados
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Linha com o nome da cidade e um botão de favorito
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_controller.weatherList.last.name),
                        IconButton(
                          icon: _controller.favoriteCities.contains(widget.city)
                              ? Icon(Icons.favorite,
                                  color: Colors
                                      .red) // Ícone de favorito vermelho se a cidade estiver nos favoritos
                              : Icon(Icons
                                  .favorite_border), // Ícone de favorito não preenchido se a cidade não estiver nos favoritos
                          onPressed: () {
                            if (_controller.favoriteCities
                                .contains(widget.city)) {
                              _controller.removeFromFavorites(widget.city);
                            } else {
                              _controller.addToFavorites(widget.city);
                            }
                            setState(
                                () {}); // Atualiza a UI após adicionar ou remover dos favoritos
                          },
                        ),
                      ],
                    ),
                    // Botão para exibir a temperatura
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.thermostat),
                      label: Text((_controller.weatherList.last.temp - 273)
                              .toStringAsFixed(2) +
                          '°C'),
                    ),
                    // Botão para exibir o tipo de clima principal
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                          _getWeatherIcon(_controller.weatherList.last.main)),
                      label: Text(_controller.weatherList.last.main),
                    ),
                    // Botão para exibir a descrição do clima
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.description),
                      label: Text(_controller.weatherList.last.description),
                    ),

                    IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FavoritesScreen(),
                          ),
                        );
                      },
                    ),
                  ],
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
