import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/models/task.dart';


class DBHelper {
  static Database? _db;
  static final int _version=1;
  static final String _tableName = 'tasks';

 static Future<void> initDb() async {
if(_db!=null){
  debugPrint('not null');
  return;
} else{
  try{
    String _path = await getDatabasesPath()+'task.db';
_db= await openDatabase(_path,
    version: 1,
    onCreate: (Database db, _version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    }
);
    
  }catch(e){print(e);}



}

}


}
