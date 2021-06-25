import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'Ken_News_Sqflite');
    var database = await openDatabase(path, version: 1, onCreate: createDatabase);
    return database;
  }
}

createDatabase(Database database, int version) async {
  await database
      .execute("CREATE TABLE bookmark(id INTEGER PRIMARY KEY, nama String, description TEXT)");
}
