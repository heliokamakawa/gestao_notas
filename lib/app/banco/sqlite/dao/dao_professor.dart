import 'package:gestao_notas/app/banco/sqlite/conexao.dart';
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';
import 'package:gestao_notas/app/dominio/interface/i_dao_professor.dart';
import 'package:sqflite/sqflite.dart';

class DAOProfessor implements IDAOProfessor {
  late Database _db;
  final sqlInserir = 
  '''
    INSERT INTO professor (nome, descricao, CPF, url_avatar, status)
    VALUES (?,?,?,?,?)
  ''';
  final sqlAlterar = 
  '''
    UPDATE professor SET nome=?, descricao=?, CPF=?, url_avatar=?, status=?
    WHERE id = ?
  ''';
  final sqlAlterarStatus = 
  '''
    UPDATE professor SET status='I'
    WHERE id = ?
  ''';
  final sqlConsultarPorId = 
  '''
    SELECT * FROM professor WHERE id = ?;
  ''';
  final sqlConsultar = 
  '''
    SELECT * FROM professor;
  ''';

  @override
  Future<DTOProfessor> salvar(DTOProfessor dto) async {
    _db = await Conexao.iniciar();
    int id = await _db.rawInsert(sqlInserir, [dto.nome, dto.descricao, dto.cpf, dto.urlAvatar, dto.status]);
    dto.id = id;
    return dto;
  }
  
  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Conexao.iniciar();
    await _db.rawUpdate(sqlAlterarStatus, [id]);
    return true;
  }
  
  @override
  Future<DTOProfessor> alterar(DTOProfessor dto) async {
    _db = await Conexao.iniciar();
    await _db.rawUpdate(sqlAlterar,[dto.nome,dto.descricao,dto.cpf,dto.urlAvatar,dto.status,dto.id]);
    return dto;
  }
  
  @override
  Future<DTOProfessor> consultarPorId(int id) async {
    _db = await Conexao.iniciar();
    var resultado = (await _db.rawQuery(sqlConsultarPorId,[id])).first;
    DTOProfessor professor = DTOProfessor(
      id: resultado['id'], 
      nome: resultado['nome'].toString(), 
      descricao: resultado['descricao'].toString(), 
      cpf: resultado['CPF'].toString(), 
      urlAvatar: resultado['url_avatar'].toString(), 
      status: resultado['status'].toString()
    );
    return professor;
  }
  
  @override
  Future<List<DTOProfessor>> consultar() async {
    _db = await Conexao.iniciar();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTOProfessor> professores = List.generate(resultado.length, (i){
      var linha = resultado[i];
      return DTOProfessor(
        id: linha['id'], 
        nome: linha['nome'].toString(), 
        descricao: linha['descricao'].toString(), 
        cpf: linha['CPF'].toString(), 
        urlAvatar: linha['url_avatar'].toString(), 
        status: linha['status'].toString()
      );
    });
    return professores;
  }
}