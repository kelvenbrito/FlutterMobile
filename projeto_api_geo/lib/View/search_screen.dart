

import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/city_db_controller.dart';

import '../Controller/weather_controller.dart';
import '../Model/city_model.dart';
import 'details_weather_screen.dart';
// Tela de pesquisa
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final CityDbController _dbController = CityDbController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisa Por Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Insira a Cidade"),
                      controller: _cityController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Insira a Cidade";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _findCity(_cityController.text);
                        }
                      },
                      child: const Text("Procurar"),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _dbController.listCities(),
                builder: (context, snapshot) {
                  if (_dbController.cities.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _dbController.cities.length,
                      itemBuilder: (context, index) {
                        final city = _dbController.cities[index];
                        return ListTile(
                          title: Text(city.cityName),
                          onTap: () {
                            _findCity(city.cityName);
                          },
                        );
                      },
                    );
                  } else {
                    return const Text("Lista vazia");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _findCity(String city) async {
    if (await _controller.findCity(city)) {
      // Se a cidade for encontrada, exibe uma snackbar informativa e salva a cidade no banco de dados local.
      City cidade = City(cityName: city, favoriteCities: 0);
      _dbController.addCities(cidade);
      print("ok");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade encontrada!"),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        // Atualiza o estado para refletir a adição da nova cidade.
      });
      // Navega para a tela de detalhes do clima para a cidade encontrada.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DetailsWeatherScreen(city: city),
        ),
      );
    } else {
      // Se a cidade não for encontrada, exibe uma snackbar informativa.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade não encontrada!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
