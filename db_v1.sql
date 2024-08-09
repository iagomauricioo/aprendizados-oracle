ALTER SESSION SET "_oracle_script"=TRUE;
GRANT unlimited TABLESPACE TO aula_ddl;

CREATE SEQUENCE aluno_id;
CREATE TABLE alunos (
	id NUMBER DEFAULT ALUNO_ID.nextval PRIMARY KEY,
	nome VARCHAR2(200),
	nascimento DATE,
	cpf CHAR(11)
);

CREATE SEQUENCE cliente_pk;
CREATE TABLE clientes (
	id NUMBER DEFAULT cliente_pk.nextval PRIMARY KEY,
	nome VARCHAR2(150),
	nascimento DATE,
	cpf CHAR(11)
);

CREATE SEQUENCE endereco_pk;
CREATE TABLE enderecos (
	id NUMBER DEFAULT endereco_pk.nextval PRIMARY KEY,
	cliente_id NUMBER REFERENCES clientes(id)
);

SELECT * FROM enderecos;

DROP TABLE alunos;

INSERT INTO alunos (nome, nascimento, cpf) VALUES ('João', TO_DATE('2004-09-18', 'YYYY-MM-DD'), '13299111485');
INSERT INTO alunos (nome, nascimento, cpf) VALUES ('Maria', TO_DATE('2004-09-18', 'YYYY-MM-DD'), '11199111485');
INSERT INTO alunos (nome, nascimento, cpf) VALUES ('José', TO_DATE('2004-09-18', 'YYYY-MM-DD'), '32299111485');
INSERT INTO alunos (nome, nascimento, cpf) VALUES ('Iago', TO_DATE('2004-09-18', 'YYYY-MM-DD'), '23199111485');

SELECT * FROM alunos;

UPDATE alunos SET NOME = 'Carlos' WHERE ID = 3;
UPDATE alunos SET NOME = 'João' WHERE NASCIMENTO LIKE '2004-09-18 00:00:00.000';

SELECT * FROM alunos;

CREATE SEQUENCE personagem_pk;
CREATE TABLE personagens (
	id NUMBER DEFAULT personagem_pk.nextval PRIMARY KEY,
	personagem VARCHAR2(30),
	class_id NUMBER,
	MP NUMBER,
	HP NUMBER,
	forca NUMBER
);

DROP TABLE personagens;

INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Ella', 2, 43, 20, 30);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Erin', 1, 44, 32, 20);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Alla', 3, 39, 34, 50);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Alure', 2, 49, 39, 40);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Well', 2, 60, 54, 40);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Lost', 2, 40, 39, 40);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Less', 2, 44, 44, 44);
INSERT INTO personagens (personagem, class_id, MP, HP, forca) VALUES ('Less', 4, 44, 44, 44);

SELECT personagem FROM personagens WHERE class_id = 2 AND MP BETWEEN 40 AND 70;

SELECT * FROM personagens;

SELECT * FROM personagens p
	ORDER BY personagem;

SELECT * FROM personagens p
	ORDER BY MP DESC, HP DESC, forca desc;

SELECT * FROM alunos WHERE NOME LIKE 'I%';

SELECT class_id, avg(HP) FROM personagens
	GROUP BY CLASS_ID;

