import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_notas/app/banco/sqlite/conexao.dart';
import 'package:gestao_notas/app/banco/sqlite/dao/dao_professor.dart';
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
    int resultado = await db.rawInsert(dao.sqlInserir,['PAULO','','984.755.560-51','https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png','A']);
    expect(resultado, isPositive);
  });

  test('dao professor - teste sintaxe sql alterar ', () async {
    int resultado = await db.rawUpdate(dao.sqlAlterar,['PAULO','','425.817.300-21','https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png','A',1]);
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
    var dto = DTOProfessor(nome: 'PAULO', descricao: 'BIOLOGIA',cpf: '589.156.920-55', urlAvatar: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png', status: 'A');
    dto = await dao.salvar(dto);
    expect(dto.id,isPositive);
  }); 
  
  
  test('dao professor - teste alterar', () async {
    var dto = DTOProfessor(nome: 'PAULO', descricao: 'BIOLOGIA',cpf: '589.156.920-55', urlAvatar: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png', status: 'A');
    dto = await dao.salvar(dto);
    var dtoAlterado = DTOProfessor(nome: 'PAULO', descricao: 'GEOGRAFIA',cpf: '589.156.920-55', urlAvatar: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png', status: 'A');
    dtoAlterado = await dao.alterar(dtoAlterado);
    
    expect(dtoAlterado.descricao,'GEOGRAFIA');
  });

  

  test('dao professor - teste alterar status', () async {
    var dto = DTOProfessor(nome: 'PAULO', descricao: 'BIOLOGIA',cpf: '589.156.920-55', urlAvatar: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png', status: 'A');
    dto = await dao.salvar(dto);
    var resultado = await dao.alterarStatus(dto.id);
    
    expect(resultado,true);
  });

   test('dao professor - teste consultar por id', () async {
    var dto = DTOProfessor(nome: 'PAULO', descricao: 'BIOLOGIA',cpf: '589.156.920-55', urlAvatar: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png', status: 'A');
    dto = await dao.salvar(dto);
    dto = await dao.consultarPorId(1);
    expect(dto.id,isPositive);
  });

  test('dao professor - teste consultar', () async {
    var dto = DTOProfessor(nome: 'PAULO', descricao: 'BIOLOGIA',cpf: '589.156.920-55', urlAvatar: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png', status: 'A');
    dto = await dao.salvar(dto);
    var resultado = await dao.consultar();
    expect(resultado.length,isPositive);
  });
}