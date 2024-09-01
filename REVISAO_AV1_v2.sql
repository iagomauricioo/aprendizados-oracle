CREATE USER ATV_REVISAO_AV1_V2 IDENTIFIED BY "12345";

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO ATV_REVISAO_AV1_V2;

CREATE SEQUENCE secao_id;
CREATE TABLE secoes (
	id NUMBER DEFAULT secao_id.nextval PRIMARY KEY,
	secao varchar(50),
	ativa CHAR(1) CHECK (ativa IN ('Y', 'N'))
);

SELECT * FROM SECOES;

INSERT INTO secoes (secao, ativa) VALUES ('Culinária', 'Y');
INSERT INTO secoes (secao, ativa) VALUES ('Moda', 'Y');
INSERT INTO secoes (secao, ativa) VALUES ('Esporte', 'Y');


CREATE SEQUENCE noticia_id;
CREATE TABLE noticias (
	id NUMBER DEFAULT noticia_id.nextval PRIMARY KEY,
	titulo VARCHAR(50),
	data_de_postagem DATE,
	descricao VARCHAR(255),
	autor_id NUMBER REFERENCES autores(id),
	secao_id NUMBER REFERENCES secoes(id)
);

SELECT * FROM NOTICIAS;

CREATE SEQUENCE autor_id;
CREATE TABLE autores (
	id NUMBER DEFAULT autor_id.nextval PRIMARY KEY,
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50)
);

SELECT * FROM AUTORES;

INSERT INTO autores (nome, email, senha) VALUES ('Carlos', 'carlos@email.com', 'carlos@123');
INSERT INTO autores (nome, email, senha) VALUES ('Maria', 'maria@email.com', 'maria@123');
INSERT INTO autores (nome, email, senha) VALUES ('João', 'joao@email.com', 'joao@123');

INSERT INTO noticias (titulo, descricao, data_de_postagem, secao_id, autor_id) 
		 	  VALUES ('Fazendo o pão', 'Descrição 1', '17/09/2018', 1, 1);
INSERT INTO noticias (titulo, descricao, data_de_postagem, secao_id, autor_id) 
		 	  VALUES ('Limpando o rosto', 'Descrição 2', '20/10/2017', 2, 2);
INSERT INTO noticias (titulo, descricao, data_de_postagem, secao_id, autor_id) 
		 	  VALUES ('X vence a partida', 'Descrição 3', '14/05/2020', 3, 3);
INSERT INTO noticias (titulo, descricao, data_de_postagem, secao_id, autor_id) 
		 	  VALUES ('Pavê de limão', 'Descrição 4', '28/11/2015', 1, 1);		 	  
INSERT INTO noticias (titulo, descricao, data_de_postagem, secao_id, autor_id) 
		 	  VALUES ('Acabando espinhas', 'Descrição 5', '22/04/2009', 2, 2);

	 	  
SELECT secoes.secao, noticias.data_de_postagem 
	FROM noticias 
	INNER JOIN secoes ON secoes(id) = noticias.secao_id;

-- Questão 2

CREATE INDEX idx_data_noticia ON noticias(data_de_postagem);

EXPLAIN PLAN FOR
SELECT *
FROM noticias
WHERE data_de_postagem = '22/04/2009';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT secoes.secao, noticias.data_de_postagem 
	FROM noticias 
	INNER JOIN secoes ON noticias.secao_id = secoes.id
	WHERE DATA_DE_POSTAGEM = '22/04/2009';

-- Questão 3

--parte 1
CREATE USER adm IDENTIFIED BY "1234";
GRANT ALL PRIVILEGES TO adm;

--parte 2
CREATE USER revisor IDENTIFIED BY "123456";
GRANT SELECT, UPDATE ON noticias TO revisor;




CREATE VIEW noticias_vw AS SELECT noticias.titulo, noticias.descricao, 
	noticias.DATA_DE_POSTAGEM AS data_postagem, secoes.secao, 
	autores.nome AS AUTOR
	FROM noticias
	INNER JOIN secoes ON SECOES.ID = noticias.SECAO_ID
	INNER JOIN autores ON autores.id = noticias.AUTOR_ID
	ORDER BY noticias.descricao;

SELECT * FROM NOTICIAS_VW;
	


