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