-- Tabela de Clientes
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    tipo CHAR(1) CHECK (tipo IN ('F', 'J')) NOT NULL
);

-- Tabela de Clientes Pessoa Física
CREATE TABLE clientepj (
    id_cliente INT PRIMARY KEY,
    cnpj VARCHAR(50) UNIQUE,
    inscricao_estadual VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Clientes Pessoa Jurídica
CREATE TABLE clientepf (
    id_cliente INT PRIMARY KEY,
    cpf VARCHAR(50) UNIQUE,
    rg VARCHAR(50),
    orgao_emissor VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Telefones
CREATE TABLE telefone (
    id_telefone INT PRIMARY KEY,
    id_cliente INT,
    ddd VARCHAR(2),
    numero VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de E-mails
CREATE TABLE email (
    id_email INT PRIMARY KEY,
    id_cliente INT,
    enderco_email VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Endereços
CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY,
    id_cliente INT,
    rua VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    cidade VARCHAR(50),
    uf VARCHAR(2),
    cep VARCHAR(10),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Obras
CREATE TABLE obra (
    isbn VARCHAR(13) PRIMARY KEY,
    titulo VARCHAR(250) NOT NULL
);

-- Tabela de Autores
CREATE TABLE autor (
    id_autor INT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL
);

-- Tabela de obra_autor
CREATE TABLE obra_autor (
    id INT PRIMARY key,
    isbn VARCHAR(13),
    id_autor INT,
    FOREIGN KEY (isbn) REFERENCES obra(isbn),
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

-- Tabela de Editora
CREATE TABLE editora (
	id_editora VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(250),
    cidade VARCHAR(250),
    uf VARCHAR(2)
);

-- Tabela de Edições
CREATE TABLE edicao (
    numero_edicao INT PRIMARY KEY,
    data_publicacao DATE,
    preco_venda DECIMAL(10, 2),
    isbn VARCHAR(13),
    id_editora VARCHAR(50),
    FOREIGN KEY (isbn) REFERENCES obra(isbn),
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

-- Tabela de Pedidos
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    data_pedido DATE,
    id_cliente INT,
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE destinatario (
    id_destinatario VARCHAR(50) PRIMARY KEY,
    id_pedido INT,
    id_cliente INT,
    data_entrega DATE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- Tabela de Itens de Pedido
CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY,
    isbn VARCHAR(13),
    id_pedido INT,
    numero_edicao INT,
    quantidade INT,
    FOREIGN KEY(isbn) REFERENCES obra(isbn),
    FOREIGN key (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN key (numero_edicao) REFERENCES edicao(numero_edicao)
);


-- Inserir dados na tabela cliente
INSERT INTO cliente (id_cliente, nome, tipo) VALUES
(1, 'João Silva', 'F'),
(2, 'Empresa ABC', 'J'),
(3, 'Maria Oliveira', 'F'),
(4, 'Empresa XYZ', 'J'),
(5, 'Carlos Santos', 'F'),
(6, 'Empresa 123', 'J'),
(7, 'Ana Pereira', 'F'),
(8, 'Empresa ABCD', 'J'),
(9, 'Pedro Lima', 'F'),
(10, 'Empresa EFG', 'J');

-- Inserir dados na tabela clientepf
INSERT INTO clientepf (id_cliente, cpf, rg, orgao_emissor) VALUES
(1, '123.456.789-01', '1234567', 'SSP'),
(3, '234.567.890-12', '2345678', 'SSP'),
(5, '345.678.901-23', '3456789', 'SSP'),
(7, '456.789.012-34', '4567890', 'SSP'),
(9, '567.890.123-45', '5678901', 'SSP');

-- Inserir dados na tabela clientepj
INSERT INTO clientepj (id_cliente, cnpj, inscricao_estadual) VALUES
(2, '12.345.678/0001-01', '123456789'),
(4, '23.456.789/0001-12', '234567890'),
(6, '34.567.890/0001-23', '345678901'),
(8, '45.678.901/0001-34', '456789012'),
(10, '56.789.012/0001-45', '567890123');

-- Inserir dados na tabela telefone
INSERT INTO telefone (id_telefone, id_cliente, ddd, numero) VALUES
(1, 1, '11', '987654321'),
(2, 2, '21', '876543210'),
(3, 3, '31', '765432109'),
(4, 4, '41', '654321098'),
(5, 5, '51', '543210987'),
(6, 6, '61', '432109876'),
(7, 7, '71', '321098765'),
(8, 8, '81', '210987654'),
(9, 9, '91', '109876543'),
(10, 10, '01', '0987654321');

-- Inserir dados na tabela email
INSERT INTO email (id_email, id_cliente, enderco_email) VALUES
(1, 1, 'joao@email.com'),
(2, 2, 'contato@empresaabc.com'),
(3, 3, 'maria@email.com'),
(4, 4, 'contato@empresaxyz.com'),
(5, 5, 'carlos@email.com'),
(6, 6, 'contato@empresa123.com'),
(7, 7, 'ana@email.com'),
(8, 8, 'contato@empresaabcd.com'),
(9, 9, 'pedro@email.com'),
(10, 10, 'contato@empresaefg.com');

-- Inserir dados na tabela endereco
INSERT INTO endereco (id_endereco, id_cliente, rua, numero, complemento, cidade, uf, cep) VALUES
(1, 1, 'Rua A', '123', 'Apto 101', 'São Paulo', 'SP', '12345-678'),
(2, 2, 'Av. B', '456', 'Sala 201', 'Rio de Janeiro', 'RJ', '23456-789'),
(3, 3, 'Rua C', '789', '', 'Belo Horizonte', 'MG', '34567-890'),
(4, 4, 'Av. D', '012', 'Loja 301', 'Curitiba', 'PR', '45678-901'),
(5, 5, 'Rua E', '345', 'Casa 401', 'Porto Alegre', 'RS', '56789-012'),
(6, 6, 'Av. F', '678', '', 'Brasília', 'DF', '67890-123'),
(7, 7, 'Rua G', '901', 'Apto 501', 'Salvador', 'BA', '78901-234'),
(8, 8, 'Av. H', '234', 'Sala 601', 'Recife', 'PE', '89012-345'),
(9, 9, 'Rua I', '567', 'Casa 701', 'Manaus', 'AM', '90123-456'),
(10, 10, 'Av. J', '890', '', 'São Paulo', 'SP', '01234-567');

INSERT INTO obra (isbn, titulo) VALUES
('9781234567890', 'Livro 1'),
('9782345678901', 'Livro 2'),
('9783456789012', 'Livro 3'),
('9784567890123', 'Livro 4'),
('9785678901234', 'Livro 5'),
('9786789012345', 'Livro 6'),
('9787890123456', 'Livro 7'),
('9788901234567', 'Livro 8'),
('9789012345678', 'Livro 9'),
('9780123456789', 'Livro 10');

-- Inserção de dados na tabela Autores
INSERT INTO autor (id_autor, nome) VALUES
(1, 'Autor 1'),
(2, 'Autor 2'),
(3, 'Autor 3'),
(4, 'Autor 4'),
(5, 'Autor 5'),
(6, 'Autor 6'),
(7, 'Autor 7'),
(8, 'Autor 8'),
(9, 'Autor 9'),
(10, 'Autor 10');

-- Inserção de dados na tabela obra_autor
INSERT INTO obra_autor (id, isbn, id_autor) VALUES
(1, '9781234567890', 1),
(2, '9782345678901', 2),
(3, '9783456789012', 3),
(4, '9784567890123', 4),
(5, '9785678901234', 5),
(6, '9786789012345', 6),
(7, '9787890123456', 7),
(8, '9788901234567', 8),
(9, '9789012345678', 9),
(10, '9780123456789', 10);

-- Inserção de dados na tabela Editora
INSERT INTO editora (id_editora, nome, cidade, uf) VALUES
('E1', 'Editora A', 'São Paulo', 'SP'),
('E2', 'Editora B', 'Rio de Janeiro', 'RJ'),
('E3', 'Editora C', 'Belo Horizonte', 'MG'),
('E4', 'Editora D', 'Curitiba', 'PR'),
('E5', 'Editora E', 'Porto Alegre', 'RS');

-- Inserção de dados na tabela Edições
INSERT INTO edicao (numero_edicao, data_publicacao, preco_venda, isbn, id_editora) VALUES
(1, '2023-01-01', 29.99, '9781234567890', 'E1'),
(2, '2023-02-01', 39.99, '9782345678901', 'E2'),
(3, '2023-03-01', 24.99, '9783456789012', 'E3'),
(4, '2023-04-01', 19.99, '9784567890123', 'E4'),
(5, '2023-05-01', 29.99, '9785678901234', 'E5'),
(6, '2023-06-01', 34.99, '9786789012345', 'E1'),
(7, '2023-07-01', 27.99, '9787890123456', 'E2'),
(8, '2023-08-01', 32.99, '9788901234567', 'E3'),
(9, '2023-09-01', 22.99, '9789012345678', 'E4'),
(10, '2023-10-01', 19.99, '9780123456789', 'E5');

-- Inserção de dados na tabela Pedidos
INSERT INTO pedido (id_pedido, data_pedido, id_cliente) VALUES
(1, '2023-01-15', 1),
(2, '2023-02-15', 2),
(3, '2023-03-15', 3),
(4, '2023-04-15', 4),
(5, '2023-05-15', 5),
(6, '2023-06-15', 6),
(7, '2023-07-15', 7),
(8, '2023-08-15', 8),
(9, '2023-09-15', 9),
(10, '2023-10-15', 10);

-- Inserção de dados na tabela Destinatário
INSERT INTO destinatario (id_destinatario, id_pedido, id_cliente, data_entrega) VALUES
('D1', 1, 1, '2023-01-20'),
('D2', 2, 2, '2023-02-20'),
('D3', 3, 3, '2023-03-20'),
('D4', 4, 4, '2023-04-20'),
('D5', 5, 5, '2023-05-20'),
('D6', 6, 6, '2023-06-20'),
('D7', 7, 7, '2023-07-20'),
('D8', 8, 8, '2023-08-20'),
('D9', 9, 9, '2023-09-20'),
('D10', 10, 10, '2023-10-20');

-- Inserção de dados na tabela Itens de Pedido
INSERT INTO item_pedido (id_item, isbn, id_pedido, numero_edicao, quantidade) VALUES
(1, '9781234567890', 1, 1, 2),
(2, '9782345678901', 2, 2, 1),
(3, '9783456789012', 3, 3, 3),
(4, '9784567890123', 4, 4, 2),
(5, '9785678901234', 5, 5, 1),
(6, '9786789012345', 6, 6, 3),
(7, '9787890123456', 7, 7, 2),
(8, '9788901234567', 8, 8, 1),
(9, '9789012345678', 9, 9, 3),
(10, '9780123456789', 10, 10, 2);


select * from cliente

--Retorna o nome do cliente e os detalhes do telefone associado a cada cliente.
SELECT c.nome, t.ddd, t.numero
FROM cliente c
JOIN telefone t ON c.id_cliente = t.id_cliente;

--Retorna o nome dos clientes que são pessoas jurídicas (tipo 'J') e seus respectivos CNPJs.
SELECT c.nome, cpj.cnpj
FROM cliente c
JOIN clientepj cpj ON c.id_cliente = cpj.id_cliente
WHERE c.tipo = 'J';

--Retorna o nome do cliente e detalhes do endereço (se existirem) para clientes cujo endereço esteja localizado em São Paulo ('SP').
SELECT c.nome, e.rua, e.numero, e.cidade, e.uf
FROM cliente c
LEFT JOIN endereco e ON c.id_cliente = e.id_cliente
WHERE e.uf = 'SP';

--Retorna o nome dos autores de uma obra específica com ISBN '9787890123456'.
SELECT a.nome
FROM autor a
JOIN obra_autor oa ON a.id_autor = oa.id_autor
WHERE oa.isbn = '9787890123456';

--Retorna o nome do cliente e o total gasto por esse cliente em todos os pedidos.
SELECT c.nome, SUM(e.preco_venda * ip.quantidade) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN item_pedido ip ON p.id_pedido = ip.id_pedido
JOIN edicao e ON ip.numero_edicao = e.numero_edicao
GROUP BY c.nome;

--Retorna o título de obras publicadas por uma editora específica ('Editora C') e o nome dessa editora.
SELECT o.titulo, e.nome AS editora
FROM obra o
JOIN edicao ed ON o.isbn = ed.isbn
JOIN editora e ON ed.id_editora = e.id_editora
WHERE e.nome = 'Editora C';