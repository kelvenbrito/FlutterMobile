import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import '../Model/city_model.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;
  const DetailsWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> with SingleTickerProviderStateMixin {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool isHistory = false;

  @override
  void initState() {
    super.initState();
    checkIfHistory();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> checkIfHistory() async {
    List<City> cities = await _dbService.getAllCities();
    setState(() {
      isHistory = cities.any((city) => city.cityName == widget.city && city.historyCities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: child,
              );
            },
            child: FutureBuilder(
              future: _controller.getWeather(widget.city),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  final weather = _controller.weatherList.last;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(weather.name),
                          IconButton(
                            icon: isHistory ? const Icon(Icons.history) : const Icon(Icons.favorite_border),
                            onPressed: () async {
                              setState(() {
                                isHistory = !isHistory;
                              });
                              City cidade = City(cityName: widget.city, historyCities: isHistory);
                              await _dbService.updateCity(cidade);
                            },
                          ),
                        ],
                      ),
                      Text(_controller.translateMain(weather.main)),
                      Text(_controller.translateDescription(weather.description)),  // Aqui chamamos o método de tradução
                      Text((weather.temp - 273).toStringAsFixed(2)),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}