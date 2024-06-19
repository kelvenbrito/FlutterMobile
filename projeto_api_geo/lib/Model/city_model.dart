  class City {
  // Atributos
  final String cityName;
  final int favoriteCities;
  
  // Construtor
  City({required this.cityName, required this.favoriteCities});

  // Métodos

  // toMap: Converte um objeto City para um Map
  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'favoriteCities': favoriteCities,
    };
  }

  // fromMap: Converte um Map para um objeto City
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityName: map['cityName'] ?? '',
      favoriteCities: map['favoriteCities'] ?? 0,
    );
  }
}