import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Model/city_model.dart';

// Serviço para gerenciar a base de dados de cidades
class CityDataBaseService {
  // Criação de uma instância singleton da classe
  static final CityDataBaseService _instance = CityDataBaseService._internal();
  factory CityDataBaseService() => _instance;

  // Construtor interno privado
  CityDataBaseService._internal();

  // Referência ao banco de dados
  static Database? _database;

  // Getter assíncrono para obter a instância do banco de dados
  Future<Database> get database async {
    // Se o banco de dados já foi inicializado, retorna-o
    if (_database != null) return _database!;

    // Caso contrário, inicializa o banco de dados
    _database = await _initDatabase();
    return _database!;
  }

  // Método privado para inicializar o banco de dados
  Future<Database> _initDatabase() async {
    // Determina o caminho do banco de dados
    String path = join(await getDatabasesPath(), 'cities.db');
    // Abre o banco de dados e cria a tabela 'cities' se ainda não existir
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cities(id INTEGER PRIMARY KEY, cityName TEXT, favoriteCities INTEGER)',
        );
      },
    );
  }

  // Método para inserir uma cidade no banco de dados
  Future<void> insertCity(City city) async {
    final db = await database;
    // Insere a cidade na tabela 'cities', substituindo a existente em caso de conflito
    await db.insert(
      'cities',
      city.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para obter todas as cidades do banco de dados
  Future<List<Map<String, dynamic>>> getAllCities() async {
    final db = await database;
    // Retorna todas as linhas da tabela 'cities'
    return await db.query('cities');
  }

  // Método para deletar uma cidade com base no nome
  Future<void> deleteCity(String cityName) async {
    final db = await database;
    // Deleta a cidade cuja coluna 'cityName' coincide com o valor fornecido
    await db.delete(
      'cities',
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
  }
}
