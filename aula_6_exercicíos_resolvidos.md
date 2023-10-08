## Resolução dos exercícios

## Exercício 1

```sql
INSERT INTO filmes (titulo, ano, diretor, genero, atores_principais, duracao_minutos, valor_ingresso)
VALUES
    ('Interestelar', 2014, 'Christopher Nolan', 'Ficção Científica', 'Matthew McConaughey, Anne Hathaway', 169, 28.75),
    ('O Labirinto do Fauno', 2006, 'Guillermo del Toro', 'Fantasia', 'Ivana Baquero, Sergi López', 118, 24.50),
    ('La La Land: Cantando Estações', 2016, 'Damien Chazelle', 'Musical', 'Ryan Gosling, Emma Stone', 128, 29.99),
    ('Mad Max: Estrada da Fúria', 2015, 'George Miller', 'Ação', 'Tom Hardy, Charlize Theron', 120, 32.00),
    ('Pantera Negra', 2018, 'Ryan Coogler', 'Ação', 'Chadwick Boseman, Michael B. Jordan', 134, 26.99);

```

### Consultas SELECT:

a) o título, o ano e o diretor de todos os filmes.

```sql
SELECT titulo, ano, diretor
FROM filmes;
```

b) os filmes de Crime produzidos a partir de 1992.

```sql
SELECT titulo, ano, diretor
FROM filmes
WHERE genero = 'Crime' AND ano >= 1992;
```

c) o título e o ano dos filmes com duração maior do que 2 horas.

```sql
SELECT titulo, ano
FROM filmes
WHERE duracao_minutos > 120;
```

d) o título e a duração das comédias lançadas na década de 90 com pelo menos 1 hora e 20 minutos de duração.

```sql
SELECT titulo, duracao_minutos
FROM filmes
WHERE genero = 'Comédia' AND ano >= 1990 AND ano < 2000 AND duracao_minutos >= 80;
```

e) o título, o gênero e o valor do ingresso dos filmes a partir de 2006, mostrando os valores inflacionados em 8,63%.

```sql
SELECT titulo, genero, valor_ingresso * 1.0863 AS valor_inflacionado
FROM filmes
WHERE ano >= 2006;
```

f) a quantidade de filmes de ação com ingressos que custam mais do que R$ 20,00.

```sql
SELECT COUNT(*) AS quantidade
FROM filmes
WHERE genero = 'Ação' AND valor_ingresso > 20.00;
```

g) os nomes de todos os diretores cadastrados, sem repetir, e em ordem alfabética.

```sql
SELECT DISTINCT diretor
FROM filmes
ORDER BY diretor;
```

### Comandos UPDATE:

a) aumentar em 10 minutos a duração dos filmes em que participa a atriz Daisy Ridley.

```sql
UPDATE filmes
SET duracao_minutos = duracao_minutos + 10
WHERE atores_principais ILIKE '%Daisy Ridley%';
```

b) dar um desconto de 10% para os filmes de ação do ano 2011.

```sql
UPDATE filmes
SET valor_ingresso = valor_ingresso * 0.90
WHERE genero = 'Ação' AND ano = 2011;
```

c) acrescentar um asterisco (\*) no final dos títulos dos filmes com duração menor ou igual a 90 minutos.

```sql
UPDATE filmes
SET titulo = CONCAT(titulo, '*')
WHERE duracao_minutos <= 90;
```

### Comandos DELETE:

a) excluir os filmes com valor de ingresso superior a R$ 60,00.

```sql
DELETE FROM filmes
WHERE valor_ingresso > 60.00;
```

b) excluir os filmes em cujo título aparece a palavra Star Wars ou cujo sobrenome do diretor é Columbus.

```sql
DELETE FROM filmes
WHERE titulo ILIKE '%Star Wars%' OR diretor ILIKE '%Columbus%';
```

## Exercício 2

```sql
-- Criar tabela alunos
CREATE TABLE alunos (
  nome VARCHAR(255),
  numero_aluno INT PRIMARY KEY,
  tipo_aluno INT,
  curso VARCHAR(255)
);

-- Criar tabela disciplinas
CREATE TABLE disciplinas (
  nome_disciplina VARCHAR(255),
  numero_disciplina VARCHAR(255) PRIMARY KEY,
  creditos INT,
  departamento VARCHAR(255)
);

-- Criar tabela turmas
CREATE TABLE turmas (
  identificacao_turma INT PRIMARY KEY,
  numero_disciplina VARCHAR(255),
  semestre VARCHAR(255),
  ano INT,
  professor VARCHAR(255),
  FOREIGN KEY (numero_disciplina) REFERENCES disciplinas(numero_disciplina)
);

-- Criar tabela pre_requisitos
CREATE TABLE pre_requisitos (
  numero_disciplina VARCHAR(255),
  numero_pre_requisito VARCHAR(255),
  PRIMARY KEY (numero_disciplina, numero_pre_requisito),
  FOREIGN KEY (numero_disciplina) REFERENCES disciplinas(numero_disciplina),
  FOREIGN KEY (numero_pre_requisito) REFERENCES disciplinas(numero_disciplina)
);

-- Criar tabela historico_escolar
CREATE TABLE historico_escolar (
  numero_aluno INT,
  identificacao_turma INT,
  nota VARCHAR(1),
  PRIMARY KEY (numero_aluno, identificacao_turma),
  FOREIGN KEY (numero_aluno) REFERENCES alunos(numero_aluno),
  FOREIGN KEY (identificacao_turma) REFERENCES turmas(identificacao_turma)
);
```

```sql
-- Inserir registros em alunos
INSERT INTO alunos (nome, numero_aluno, tipo_aluno, curso) VALUES
('Silva', 17, 1, 'CC'),
('Braga', 8, 2, 'CC');

-- Inserir registros em disciplinas
INSERT INTO disciplinas (numero_disciplina, creditos, departamento, nome_disciplina) VALUES
('CC1310', 4, 'CC', 'Introd. à ciência da computação'),
('CC3320', 4, 'CC', 'Estruturas de dados'),
('MAT2410', 3, 'MAT', 'Matemática discreta'),
('CC3380', 3, 'CC', 'Banco de dados');

-- Inserir registros em turmas
INSERT INTO turmas (identificacao_turma, numero_disciplina, semestre, ano, professor) VALUES
(85, 'MAT2410', 'Segundo', 2007, 'Kleber'),
(92, 'CC1310', 'Segundo', 2007, 'Anderson'),
(102, 'CC3320', 'Primeiro', 2008, 'Carlos'),
(112, 'MAT2410', 'Segundo', 2008, 'Chang'),
(119, 'CC1310', 'Segundo', 2008, 'Anderson'),
(135, 'CC3380', 'Segundo', 2008, 'Santos');

-- Inserir registros em historico_escolar
INSERT INTO historico_escolar (numero_aluno, identificacao_turma, nota) VALUES
(17, 112, 'B'),
(17, 119, 'C'),
(8, 85, 'A'),
(8, 92, 'A'),
(8, 102, 'B'),
(8, 135, 'A');

-- Inserir registros em pre_requisitos
INSERT INTO pre_requisitos (numero_disciplina, numero_pre_requisito) VALUES
('CC3380', 'CC3320'),
('CC3380', 'MAT2410'),
('CC3320', 'CC1310');
```

1. Recuperar uma lista de todas as disciplinas e notas de Silva:

```sql
SELECT h.numero_aluno, h.identificacao_turma, h.nota, d.nome_disciplina
FROM historico_escolar h
JOIN disciplinas d ON h.identificacao_turma = d.numero_disciplina
WHERE h.numero_aluno = 17;
```

2. Listar os nomes dos alunos que realizaram a disciplina Banco de dados oferecida no segundo semestre de 2008 e suas notas nessa turma:

```sql
SELECT a.nome, h.nota
FROM historico_escolar h
JOIN alunos a ON h.numero_aluno = a.numero_aluno
JOIN turmas t ON h.identificacao_turma = t.identificacao_turma
WHERE t.numero_disciplina = 'CC3380' AND t.semestre = 'Segundo' AND t.ano = 2008;
```

3. Listar os pré-requisitos do curso de Banco de dados:

```sql
SELECT p.numero_disciplina, d.nome_disciplina AS disciplina, p.numero_pre_requisito, pd.nome_disciplina AS pre_requisito
FROM pre_requisitos p
JOIN disciplinas d ON p.numero_disciplina = d.numero_disciplina
JOIN disciplinas pd ON p.numero_pre_requisito = pd.numero_disciplina
WHERE d.nome_disciplina = 'Banco de dados';
```

1. Alterar o tipo de aluno de Silva para segundo ano:

```sql
UPDATE alunos
SET tipo_aluno = 2
WHERE numero_aluno = 17;
```

2. Criar outra turma para a disciplina Banco de dados para este semestre:

```sql
INSERT INTO turmas (identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES (150, 'CC3380', 'Terceiro', 2023, 'Novo Professor');
```

3. Inserir uma nota A para Silva na turma Banco de dados do último semestre:

```sql
INSERT INTO historico_escolar (numero_aluno, identificacao_turma, nota)
VALUES (17, 150, 'A');
```

Lembre-se de adaptar os comandos conforme necessário, dependendo das restrições específicas do seu sistema de banco de dados.

### Consultas SELECT:

a) o título, o ano e o diretor de todos os filmes.

```sql
SELECT titulo, ano, diretor
FROM filmes;
```

b) os filmes de Crime produzidos a partir de 1992.

```sql
SELECT titulo, ano, diretor
FROM filmes
WHERE genero = 'Crime' AND ano >= 1992;
```

c) o título e o ano dos filmes com duração maior do que 2 horas.

```sql
SELECT titulo, ano
FROM filmes
WHERE duracao_minutos > 120;
```

d) o título e a duração das comédias lançadas na década de 90 com pelo menos 1 hora e 20 minutos de duração.

```sql
SELECT titulo, duracao_minutos
FROM filmes
WHERE genero = 'Comédia' AND ano >= 1990 AND ano < 2000 AND duracao_minutos >= 80;
```

e) o título, o gênero e o valor do ingresso dos filmes a partir de 2006, mostrando os valores inflacionados em 8,63%.

```sql
SELECT titulo, genero, valor_ingresso * 1.0863 AS valor_inflacionado
FROM filmes
WHERE ano >= 2006;
```

f) a quantidade de filmes de ação com ingressos que custam mais do que R$ 20,00.

```sql
SELECT COUNT(*) AS quantidade
FROM filmes
WHERE genero = 'Ação' AND valor_ingresso > 20.00;
```

g) os nomes de todos os diretores cadastrados, sem repetir, e em ordem alfabética.

```sql
SELECT DISTINCT diretor
FROM filmes
ORDER BY diretor;
```

### Comandos UPDATE:

a) aumentar em 10 minutos a duração dos filmes em que participa a atriz Daisy Ridley.

```sql
UPDATE filmes
SET duracao_minutos = duracao_minutos + 10
WHERE atores_principais ILIKE '%Daisy Ridley%';
```

b) dar um desconto de 10% para os filmes de ação do ano 2011.

```sql
UPDATE filmes
SET valor_ingresso = valor_ingresso * 0.90
WHERE genero = 'Ação' AND ano = 2011;
```

c) acrescentar um asterisco (\*) no final dos títulos dos filmes com duração menor ou igual a 90 minutos.

```sql
UPDATE filmes
SET titulo = CONCAT(titulo, '*')
WHERE duracao_minutos <= 90;
```

### Comandos DELETE:

a) excluir os filmes com valor de ingresso superior a R$ 60,00.

```sql
DELETE FROM filmes
WHERE valor_ingresso > 60.00;
```

b) excluir os filmes em cujo título aparece a palavra Star Wars ou cujo sobrenome do diretor é Columbus.

```sql
DELETE FROM filmes
WHERE titulo ILIKE '%Star Wars%' OR diretor ILIKE '%Columbus%';
```
