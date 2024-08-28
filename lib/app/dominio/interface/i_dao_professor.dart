import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';

abstract class IDAOProfessor{
  DTOProfessor salvar(DTOProfessor dto);
  DTOProfessor alterarStatus(DTOProfessor dto);
}