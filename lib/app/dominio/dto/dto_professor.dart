class DTOProfessor{
  dynamic id;
  final String nome;
  final String? descricao;
  final String cpf;
  final String? urlAvatar;
  final String status;
  DTOProfessor({this.id, required this.nome, this.descricao, required this.cpf, this.urlAvatar, this.status = 'A'});
}