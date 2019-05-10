import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutternotepad/model/Note.dart';


class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;


  DatabaseHelper.createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper ==null){
      _databaseHelper = DatabaseHelper.createInstance();
    }
    return _databaseHelper;
  }

}