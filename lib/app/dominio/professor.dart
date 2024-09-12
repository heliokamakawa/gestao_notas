import 'package:gestao_notas/app/dominio/cpf.dart' as validador;
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';
import 'package:gestao_notas/app/dominio/interface/i_dao_professor.dart';

class Professor{
  late dynamic? id;
  late String _nome;
  late String? descricao;
  late String CPF;
  String _status = 'A';
  String get status => _status;
  set status(String status){
    if(status != 'A' || status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  } 
  String get nome => _nome;
  set nome (String nome){
    if(nome.isEmpty) throw Exception('Nome não pode ser vazio!');
    _nome = nome;
  } 
  late DTOProfessor dto;
  IDAOProfessor dao;

  Professor({this.id, required String nome, this.descricao, required this.CPF, required String status, required this.dao}){
    id = dto.id;
    nome = dto.nome;
    descricao = dto.descricao;
    validador.CPF(CPF).eValido();
    this.status = status;
    dto = DTOProfessor(id: this.id, nome: this.nome,  descricao: this.descricao, CPF: this.CPF, status: this.status);
  }

  Future<DTOProfessor> salvar() async {
    return await dao.salvar(dto);
  }

  Future<DTOProfessor> alterar() async {
    return await dao.alterar(dto);
  }

  Future<bool> excluir()async {
    await dao.alterarStatus(dto.id);
    return true;
  }

  Future<List<DTOProfessor>> consutlar()async {
    return await dao.consultar();
  }
}