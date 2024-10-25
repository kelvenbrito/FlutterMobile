import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Model/weather_model.dart';
import 'package:projeto_api_geo/View/details_weather_screen.dart';


class FavoritesScreen extends StatelessWidget {
  final WeatherController _controller = WeatherController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cidades Favoritas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: _controller.weatherList.length,
          itemBuilder: (context, index) {
            Weather weather = _controller.weatherList[index];
            return ListTile(
              title: Text(weather.name),
              subtitle: Text(weather.main),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  _controller.removeFavorite(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cidade removida dos favoritos'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailsWeatherScreen(city: weather.name),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
