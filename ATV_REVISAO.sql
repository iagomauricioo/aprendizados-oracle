CREATE SEQUENCE clientes_id;
CREATE TABLE clientes(
	id NUMBER DEFAULT clientes_id.nextval PRIMARY KEY,
	nome VARCHAR(50)
);

CREATE SEQUENCE telefones_id;
CREATE TABLE telefones (
	id NUMBER DEFAULT telefones_id.nextval PRIMARY KEY,
	cliente_id NUMBER REFERENCES clientes(id),
	telefone VARCHAR(20)
);


CREATE SEQUENCE categorias_id;
CREATE TABLE categorias(
	id NUMBER DEFAULT categorias_id.nextval PRIMARY KEY,
	categoria VARCHAR(50)
);

CREATE SEQUENCE vendas_id;
CREATE TABLE vendas(
	id NUMBER DEFAULT vendas_id.nextval PRIMARY KEY,
	cliente_id NUMBER REFERENCES clientes(id),
	total NUMBER
);

CREATE SEQUENCE produtos_id;
CREATE TABLE produtos(
	id NUMBER DEFAULT produtos_id.nextval PRIMARY KEY,
	produto varchar(50),
	preco NUMBER,
	categoria_id NUMBER REFERENCES categorias(id)
);


CREATE TABLE vendas_produtos(
	venda_id NUMBER REFERENCES vendas(id),
	produto_id NUMBER REFERENCES produtos(id)
);

INSERT INTO clientes (nome) VALUES ('Cliente 1');
INSERT INTO clientes (nome) VALUES ('Cliente 2');
INSERT INTO clientes (nome) VALUES ('Cliente 3');

INSERT INTO telefones (cliente_id, telefone) VALUES (1, '99999-9999');
INSERT INTO telefones (cliente_id, telefone) VALUES (1, '88888-8888');
INSERT INTO telefones (cliente_id, telefone) VALUES (2, '77777-7777');
INSERT INTO telefones (cliente_id, telefone) VALUES (3, '66666-6666');
INSERT INTO telefones (cliente_id, telefone) VALUES (3, '55555-5555');

INSERT INTO CATEGORIAS (categoria) VALUES ('Papelaria');
INSERT INTO CATEGORIAS (categoria) VALUES ('Informática');
INSERT INTO CATEGORIAS (categoria) VALUES ('Alimentação');

INSERT INTO produtos (produto, preco, categoria_id) VALUES ('Caneta', 1.00, 1);
INSERT INTO produtos (produto, preco, categoria_id) VALUES ('Caaderno', 10.00, 1);
INSERT INTO produtos (produto, preco, categoria_id) VALUES ('Pendriver', 20.00, 2);
INSERT INTO produtos (produto, preco, categoria_id) VALUES ('Mouse', 35.50, 2);
INSERT INTO produtos (produto, preco, categoria_id) VALUES ('Leite', 5.80, 3);

UPDATE produtos SET preco = preco * 1.3
COMMIT

SELECT * FROM produtos;

INSERT INTO VENDAS (CLIENTE_ID, TOTAL) 
	SELECT 1, PRECO FROM PRODUTOS
	WHERE ID = 1;
	
INSERT INTO VENDAS (CLIENTE_ID, TOTAL) 
	SELECT 1, PRECO FROM PRODUTOS
	WHERE ID = 4;

SELECT clientes.nome, telefones.telefone 
	FROM telefones 
	INNER JOIN clientes ON telefones.CLIENTE_ID = clientes.id;
