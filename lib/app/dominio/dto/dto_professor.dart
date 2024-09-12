class DTOProfessor{
  dynamic? id;
  final String nome;
  final String? descricao;
  final String CPF;
  final String status;
  DTOProfessor({this.id, required this.nome, this.descricao, required this.CPF, this.status = 'A'});
}