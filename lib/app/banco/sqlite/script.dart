

const criarTabela = '''
  CREATE TABLE professor(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
    ,descricao VARCHAR(200) NULL
    ,CPF CHAR(14) UNIQUE
    ,status CHAR(1)
  )
''';

const registro1 = '''
  INSERT INTO professor (nome, CPF, status)
  VALUES ('Joaquim Silva', '174.884.480-65', 'A')
''';

const registro2 = '''
  INSERT INTO professor (nome, CPF, status)
  VALUES ('Marta Martins', '821.107.140-18', 'A')
''';

const registro3 = '''
  INSERT INTO professor (nome, CPF, status)
  VALUES ('Pietro Ribas', '910.791.830-51', 'I')
''';

/*
late dynamic? id;
  late String nome;
  late String? descricao;
  late String CPF;
  String _status = 'A';
*/