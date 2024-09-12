const criarTabelas = 
[
  '''
    CREATE TABLE professor(
      id INTEGER NOT NULL PRIMARY KEY
      ,nome VARCHAR(200) NOT NULL
      ,descricao VARCHAR(200) NULL
      ,CPF CHAR(14) UNIQUE
      ,url_avatar VARCHAR(300) NULL
      ,status CHAR(1)
    )
  '''
];

const insercoes = 
[
  '''
    INSERT INTO professor (nome, descricao, CPF, url_avatar, status)
    VALUES ('Joaquim Silva', 'GEOGRAFIA', '174.884.480-65','https://cdn.pixabay.com/photo/2017/01/31/21/23/avatar-2027366_1280.png', 'A')
  '''
  ,'''
    INSERT INTO professor (nome,descricao,  CPF, url_avatar, status)
    VALUES ('Marta Silva', 'HISTÓRIA', '821.107.140-18','https://cdn.pixabay.com/photo/2021/05/10/08/00/woman-6242836_1280.png', 'A')
  '''
  ,'''
    INSERT INTO professor (nome, descricao, CPF, url_avatar, status)
    VALUES ('Rosana Ribas', 'MATEMÁTICA', '910.791.830-51','https://cdn.pixabay.com/photo/2014/03/25/16/54/user-297566_1280.png', 'I')
  '''
];


