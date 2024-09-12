import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';

abstract class IDAOProfessor{
  Future<DTOProfessor> salvar(DTOProfessor dto);
  Future<DTOProfessor> alterar(DTOProfessor dto);
  Future<bool> alterarStatus(int id);
  Future<DTOProfessor> consultarPorId(int id);
  Future<List<DTOProfessor>> consultar();
}