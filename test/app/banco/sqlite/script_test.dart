

import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_notas/app/banco/sqlite/script.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(){
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    DatabaseFactory databaseFactory = databaseFactoryFfi;
  }
  test('teste script criar tabela', ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db.execute(criarTabela);
    });
    await db.rawInsert(registro1);
    expect(await db.query('professor'), [{'id':1,'nome':'Joaquim Silva','CPF':'174.884.480-65','status':'A'}]);
  });
}