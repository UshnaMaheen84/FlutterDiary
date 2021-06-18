import 'dart:io';
import 'package:diary/models/DiaryModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/NotesModel.dart';

class DatabaseHelper {
  static const _databaseName = 'DiaryDatabase.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    await db.execute('''
       CREATE TABLE ${NotesModel.tblNote}(
        ${NotesModel.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${NotesModel.colNote} TEXT NOT NULL
      )
      ''');
    await db.execute('''
       CREATE TABLE ${DiaryModel.tblDiary}(
        ${NotesModel.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DiaryModel.colSubject} TEXT NOT NULL,
        ${DiaryModel.colEntry} TEXT NOT NULL,
        ${DiaryModel.colDate} TEXT NOT NULL
      )
      ''');
  }

  //diary - insert
  Future<int> insertDiary(DiaryModel diaryModel) async {
    Database db = await database;
    return await db.insert(DiaryModel.tblDiary, diaryModel.toMap());
  }
//diary - update
  Future<int> updateDiary(DiaryModel diaryModel) async {
    Database db = await database;
    return await db.update(DiaryModel.tblDiary, diaryModel.toMap(),
        where: '${DiaryModel.colId}=?', whereArgs: [diaryModel.id]);
  }
//diary - delete
  Future<int> deleteDiary(int id) async {
    Database db = await database;
    return await db.delete(DiaryModel.tblDiary,
        where: '${DiaryModel.colId}=?', whereArgs: [id]);
  }
//diary - retrieve all
  Future<List<DiaryModel>> fetchDiary() async {
    Database db = await database;
    List<Map> diaryModel = await db.query(DiaryModel.tblDiary);
    return diaryModel.length == 0
        ? []
        : diaryModel.map((x) => DiaryModel.fromMap(x)).toList();
  }
  //Note - insert
  Future<int> insertNote(NotesModel noteModel) async {
    Database db = await database;
    return await db.insert(NotesModel.tblNote, noteModel.toMap());
  }
//Note - update
  Future<int> updateNote(NotesModel noteModel) async {
    Database db = await database;
    return await db.update(NotesModel.tblNote, noteModel.toMap(),
        where: '${NotesModel.colId}=?', whereArgs: [noteModel.id]);
  }
//Note - delete
  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(NotesModel.tblNote,
        where: '${NotesModel.colId}=?', whereArgs: [id]);
  }
//Note - retrieve all
  Future<List<NotesModel>> fetchNote() async {
    Database db = await database;
    List<Map> noteModel = await db.query(NotesModel.tblNote);
    return noteModel.length == 0
        ? []
        : noteModel.map((x) => NotesModel.fromMap(x)).toList();
  }
}