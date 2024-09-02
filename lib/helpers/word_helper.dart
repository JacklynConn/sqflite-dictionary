// 2

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/word_model.dart';

class WordHelper {
  late Database db;

  Future openDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    db =
        await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE IF NOT EXISTS $tableName (
            $columnId INTEGER PRIMARY KEY, 
            $columnEnglish TEXT NOT NULL, 
            $columnKhmer TEXT NOT NULL
     )''');
  }

  Future<int> insert(WordModel wordModel) async {
    return await db.insert(tableName, wordModel.toMap);
  }

  Future<int> update(WordModel wordModel) async {
    return await db.update(
      tableName,
      wordModel.toMap,
      where: '$columnId = ?',
      whereArgs: [wordModel.id],
    );
  }

  Future<int> delete(int id) async {
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<WordModel>> selectAll() async {
    List list = await db.query(tableName);
    return compute(_parseData, list);
  }

  Future close() async => db.close();

  Future<List<WordModel>> rawQuery(String sql) async {
    List list = await db.rawQuery(tableName);
    return compute(_parseData, list);
  }
}

List<WordModel> _parseData(List list) {
  return list.map((e) => WordModel.fromMap(e)).toList();
}
