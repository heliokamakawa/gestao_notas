import 'package:gestao_notas/app/dominio/cpf.dart' as validador;
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';
import 'package:gestao_notas/app/dominio/interface/i_dao_professor.dart';

class Professor{
  dynamic _id;
  String? _nome;
  String? _descricao;
  String? _cpf;
  String? _urlAvatar;
  String _status = 'A';
  IDAOProfessor dao;

  Professor({required this.dao});

  validar({required DTOProfessor dto}){
    nome = dto.nome;
    descricao = dto.descricao;
    cpf = dto.cpf;
    urlAvatar = dto.urlAvatar;
    status = dto.status;
    validador.CPF(cpf).eValido();
  }
  
  Future<DTOProfessor> salvar(DTOProfessor dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DTOProfessor> alterar(dynamic id) async {
    this.id = id;
    return await dao.alterar(_id);
  }

  Future<bool> excluir(dynamic id)async {
    this.id = id;
    await dao.alterarStatus(_id);
    return true;
  }

  Future<List<DTOProfessor>> consutlar()async {
    return await dao.consultar();
  }

  String? get nome => _nome;
  String? get descricao => _descricao;
  String? get urlAvatar => _urlAvatar;
  String? get cpf => _cpf;
  String? get status => _status;

  set id(int? id){
    if(id == null) throw Exception('ID não pode ser nulo');
    if(id < 0) throw Exception('ID não pode ser negativo');
    _id = id;
  }

  set nome(String? nome){
    if(nome == null) throw Exception('Nome não pode ser nulo.');
    if(nome.isEmpty) throw Exception('Nome não pode ser vazio.');
    _nome = nome;
  }

  set descricao(String? descricao){
    if(descricao == null) throw Exception('Nome não pode ser nulo.');
    _descricao = descricao;
  }

  set cpf(String? cpf){
    if(cpf == null) throw Exception('CPF não pode ser nulo.');
    if(cpf.isEmpty) throw Exception('CPF não pode ser vazio.');
    _cpf = cpf;
  }

  set urlAvatar(String? urlAvatar){
    if(urlAvatar == null) throw Exception('URL não pode ser nulo.');
    _urlAvatar = urlAvatar;
  }

  set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' || status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  } 
}