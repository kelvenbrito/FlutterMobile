import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'service.dart';



class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}



class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(
    apiKey: 'b9ebe666087f299f5e2aad3a03d093b6', // Chave de API para acesso à API de previsão do tempo.
    baseUrl: 'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );

  late Map<String,dynamic> _Weatherdata;
  TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _Weatherdata = new Map<String,dynamic>();

  }

  Future<void> _fetchWeatherData(String city) async{
    try{
     final weatherData = await _weatherService.getWeather(city);
     setState((){
      _Weatherdata = weatherData;
     });
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: const Text("Exemplo Weather-API")
      ),
       body: Padding(padding: EdgeInsets.all(12),
       child: Center(child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: "Digite a Cidade"),
              validator: (value){
                if (value!.trim().isEmpty) {
                  return "Insira a Cidade";
                }
              },
            )
            //Incluir um botao
          ],
        ),
        ),

       ),),
    );

  }
}

