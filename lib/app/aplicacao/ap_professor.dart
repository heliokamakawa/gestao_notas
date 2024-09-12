import 'package:gestao_notas/app/banco/sqlite/dao/dao_professor.dart';
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';
import 'package:gestao_notas/app/dominio/interface/i_dao_professor.dart';
import 'package:gestao_notas/app/dominio/professor.dart';

class APProfessor{
  late Professor dominio;
  late IDAOProfessor dao;
  late DTOProfessor dto;
  APProfessor(){
    dao = DAOProfessor();
    dominio = Professor(id: dto.id,nome: dto.nome, CPF: dto.CPF, status: dto.status, dao: dao);
  }

  Future<DTOProfessor> salvar() async {
    return await dominio.salvar();
  }

  Future<DTOProfessor> alterar() async {
    return await dominio.alterar();
  }

  Future<bool> excluir() async {
    await dominio.alterar();
    return true;
  }

  Future<List<DTOProfessor>> consultar() async {
    return await dominio.consutlar();
  }
}