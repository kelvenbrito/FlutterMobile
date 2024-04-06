//criar um metodo do tipo bool
import 'package:aplicativo_autent_config/Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosUsuario {
  static const String DB_NOME = 'usuarios.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'cadastro'; // Nome da tabela
  static const String
      CREATE_CADASTRO_TABLE_SCRIPT = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS cadastro(id SERIAL PRIMARY KEY," +
          "nome TEXT, email TEXT, senha TEXT, datanasc TEXT, telefone TEXT," +
          "endereco TEXT)";

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_CADASTRO_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }

  //Método para cadastrar usuario no banco de dados
  Future<void> create(CadastroModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(
          TABLE_NOME, model.toMap()); //Insere um novo usuario no banco de dadps
    } catch (ex) {
      print(ex);
      return;
    }
  }

// Método para acesso do usuario a pagina interna
// Future<bool> acessoInterno(user,senha) async{
//   bool x= false;
//   final Database db = await _getDatabase();
//   var retorno = db.rawQuery('SElect * from where user = 'user 'and senha =' senha);
//   if(retorno>0){
// x=true;
//   }else{

//   }
//   return x;
// }

  // Método para atualizar um contato no banco de dados
  Future<void> update(CadastroModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.update(
        TABLE_NOME,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para excluir um contato do banco de dados
  Future<void> delete(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABLE_NOME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }
}
