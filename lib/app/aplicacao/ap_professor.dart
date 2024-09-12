import 'package:gestao_notas/app/banco/sqlite/dao/dao_professor.dart';
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';
import 'package:gestao_notas/app/dominio/interface/i_dao_professor.dart';
import 'package:gestao_notas/app/dominio/professor.dart';

class APProfessor{
  late IDAOProfessor dao;
  late Professor dominio;

  APProfessor(){
    dao = DAOProfessor();
    dominio = Professor(dao: dao);
  }
    
  Future<DTOProfessor> salvar(DTOProfessor dto) async {
    return await dominio.salvar(dto);
  }

  Future<DTOProfessor> alterar(dynamic id) async {
    return await dominio.alterar(id);
  }

  Future<bool> excluir(dynamic id) async {
    await dominio.alterar(id);
    return true;
  }

  Future<List<DTOProfessor>> consultar() async {
    return await dominio.consutlar();
  }
}