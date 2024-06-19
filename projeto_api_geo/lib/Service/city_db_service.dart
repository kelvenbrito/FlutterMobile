import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/city_model.dart';

class CityDataBaseService {
  static const String DB_NOME = 'city.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'cities'; // Nome da tabela
  static const String CREATE_CONTACTS_TABLE_SCRIPT = // Script SQL para criar a tabela
      """CREATE TABLE cities(
        id SERIAL, 
        cityname TEXT, 
        historycities BOOLEAN)""";

  Future<Database> _getDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_CONTACTS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }

 Future<List<City>> getAllCities() async {
  Database db = await _getDatabase();
  List<Map<String, dynamic>> maps = await db.query(TABLE_NOME);
  return List.generate(
    maps.length,
    (i) {
      return City(
        cityName: maps[i]['cityname'],
        historyCities: maps[i]['historycities'] == 1, // Convertendo de int para bool
      );
    },
  );
}


  Future<int> insertCity(City city) async {
    try {
      Database db = await _getDatabase();
      print("banco");
      return await db.insert(TABLE_NOME, city.toMap());
    } catch (e) {
      print(e);
      return 0;
    }
      }  
      //update
Future<void> updateCity(City city) async {
  try {
    Database db = await _getDatabase();
    int isHistoryInt = city.historyCities ? 1 : 0; // Convertendo bool para int
    await db.update(
      TABLE_NOME,
      {'historycities': isHistoryInt},
      where: 'cityname = ?',
      whereArgs: [city.cityName],
    );
  } catch (e) {
    print(e);
  }
}

  Future<void> historyCity(String cityName, bool isHistory) async {
    try {
      Database db = await _getDatabase();
      await db.update(
        TABLE_NOME,
        {'historycities': isHistory ? 1 : 0},
        where: 'cityname = ?',
        whereArgs: [cityName],
      );
    } catch (e) {
      print(e);
    }
  }
}