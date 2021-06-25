import 'package:sqflite/sqflite.dart';

import 'database_connection.dart';

class Repository {
  DatabaseConnection _databaseConnection;
  Repository() {
    //inisialisasi database
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  //ngecek database apakah sudah ada atau belom
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase(); //set sebagai database
    return _database;
  }

  //insert data
  inserData(table, data) async {
    var connection = await database; //assign variable connection ke database kita
    return await connection.insert(table, data);
  }

  //read data
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

//read data dari id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //update data
  updateBookmark(table, data) async {
    var connection = await database;
    return await connection.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //delete data
  deleteBookmark(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM  $table WHERE id = $itemId");
  }
}
