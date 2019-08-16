import 'dart:io';

import 'package:daily_pick/models/NasaPic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBProvider {
  static Database _database;
  static final DBProvider db= DBProvider._();
  DBProvider._();
  Future<Database> get database async{
    if(_database!=null) return _database;
    _database = await initDB();
      return _database;
  }
  initDB()async{
    Directory documentsDirectory =  await getApplicationDocumentsDirectory();
    final path= join(documentsDirectory.path,'daily.db');
    return await openDatabase( path,version: 1, onOpen: (db){},onCreate: (Database db, int version)async{
      await db.execute("CREATE TABLE fotos(claveFoto INTEGER PRIMARY KEY, title TEXT, explanation TEXT, url TEXT,copyright TEXT,date TEXT, hdurl TEXT, media_type TEXT, service_version TEXT)");
    });
  }
  Future<List<FotoModel>> getFotos()async{
    final db = await database;
    final res = await db.query('fotos');
    return res.isNotEmpty ? res.map((foto)=>FotoModel.fromJson(foto)).toList() : [];
  }
  insertFoto(FotoModel model)async{
    final db = await database;
    final res = await db.insert('fotos', model.toJson());
    return res;
  }
  deleteFoto( int clave )async{
    final db = await database;
    final res= await db.rawDelete('delete from fotos where claveFoto= $clave');
    return res;
  }
}