import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_notas/app/banco/sqlite/conexao.dart';
import 'package:gestao_notas/app/banco/sqlite/dao/dao_professor.dart';
import 'package:gestao_notas/app/banco/sqlite/script.dart';
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

main() async{
  late Database db;
  late DAOProfessor dao;

  setUpAll((){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    dao = DAOProfessor();
  });

  setUp(() async {
    db = await Conexao.iniciar();
  });

  tearDown(()async {
    deleteDatabase(db.path);
    db = await Conexao.iniciar();
  });

  tearDownAll(()async {
    db.close();
  });

  test('dao professor - teste sintaxe sql inserir', () async {
    int resultado = await db.rawInsert(dao.sqlInserir,['PAULO','','984.755.560-51','A']);
    expect(resultado, isPositive);
  });

  test('dao professor - teste sintaxe sql alterar ', () async {
    int resultado = await db.rawUpdate(dao.sqlAlterar,['PAULO','','425.817.300-21','A',1]);
    expect(resultado, isPositive);
  });

  test('dao professor - teste sintaxe sql excluir - alterar status ', () async {
    int resultado = await db.rawUpdate(dao.sqlAlterarStatus,[1]);
    expect(resultado, isPositive);
  });

  test('dao professor - teste sintaxe sql consultar por id ', () async {
    var resultado = await db.rawQuery(dao.sqlConsultarPorId,[1]);
    expect(resultado.length, 1);
  });

  test('dao professor - teste sintaxe sql consultar ', () async {
    var resultado = await db.rawQuery(dao.sqlConsultar);
    expect(resultado.length, isPositive);
  });

  test('dao professor - teste inserir', () async {
    var dto = DTOProfessor(nome: 'PAULO', descricao: 'BIOLOGIA',CPF: '589.156.920-55', status: 'A');
    dto = await dao.salvar(dto);
    expect(dto.id,isPositive);
  });

  test('dao professor - teste sintaxe sql alterar', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
      onCreate: (db, version) async {
        criarTabelas.forEach(db.execute);
        insercoes.forEach(db.execute);
        expect(
          ()=> db.rawUpdate(dao.sqlAlterar,['PAULO','','984.755.560-51','A',1]),
          returnsNormally
        );
      }
    );
    await db.close();
  });

  test('dao professor - teste sintaxe sql excluir - alterar status', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
      onCreate: (db, version) async {
        criarTabelas.forEach(db.execute);
        insercoes.forEach(db.execute);
        expect(
          ()=> db.rawUpdate(dao.sqlAlterarStatus,[1]),
          returnsNormally
        );
      }
    );
  });

  test('dao professor - teste sintaxe sql consultar por id', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
      onCreate: (db, version) async {
        criarTabelas.forEach(db.execute);
        insercoes.forEach(db.execute);
        expect(
          ()=> db.rawQuery(dao.sqlConsultarPorId,[1]),
          returnsNormally
        );
      }
    );
  });

  test('dao professor - teste sintaxe sql consultar', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
      onCreate: (db, version) async {
        criarTabelas.forEach(db.execute);
        insercoes.forEach(db.execute);
        expect(
          ()=> db.rawQuery(dao.sqlConsultar),
          returnsNormally
        );
      }
    );
  });
}