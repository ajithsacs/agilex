import 'package:agilex/fuctional/errordialog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//this is for exception
class DatabaseAlreadyopenException implements Exception {}
class OtherException implements Exception{}
class UnabeltogetDocumentDir implements Exception {}
class UnabletoCreatetableException implements Exception{}
//this is for constances
const dbname = 'notes.db';
const sqlqurecreatetable='''CREATE TABLE IF NOT EXISTS "notes" (
	"id"	INTEGER,
	"email"	TEXT UNIQUE,
	"text"	TEXT,
	"sync"  INTEGER	,
	PRIMARY KEY("id" AUTOINCREMENT)''';

class NotesServices{
  Database? _database;
  getpath() async {
    try {
      final dbpath = await getApplicationDocumentsDirectory();
      final db = join(dbpath.path, dbname);
      return db;
    } on MissingPlatformDirectoryException {
      throw UnabeltogetDocumentDir();
    }
  }
  createtable()async{
    try{
      final db=_database;
    const sql=sqlqurecreatetable;
    db?.execute(sql);

    }
    catch(e)
    {
      throw UnabletoCreatetableException();
    }
    
   
   }  
   Future <void> closeconnection()
async  {

  }
  Future<void> open() async {
    if (_database != null) throw DatabaseAlreadyopenException();
    try {
      final path = getpath();
      final db = await openDatabase(path);
      _database = db;
    } on MissingPlatformDirectoryException {
      throw UnabeltogetDocumentDir();
    } catch (e) {
      throw OtherException();
    }
  } 
 
}

  
class MainClass {

}

