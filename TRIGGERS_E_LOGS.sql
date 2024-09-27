ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER aula_trigger IDENTIFIED BY "123456";
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO aula_trigger;

--- Acessos
CREATE TABLE acessos (
    qt_acessos NUMBER
);

INSERT INTO acessos VALUES (0);
 
-- CARGOS
CREATE SEQUENCE CARGO_ID;
CREATE TABLE cargos (
    id NUMBER DEFAULT CARGO_ID.NEXTVAL PRIMARY KEY,
    cargo VARCHAR2(300) 
);
 
INSERT INTO cargos (cargo) VALUES ('diretor');
INSERT INTO cargos (cargo) VALUES ('coordenador');
INSERT INTO cargos (cargo) VALUES ('professor');
 
 
-- FUNCIONARIOS
CREATE SEQUENCE FUNCIONARIO_ID;
CREATE TABLE funcionarios (
    id NUMBER DEFAULT FUNCIONARIO_ID.NEXTVAL PRIMARY KEY,
    nome VARCHAR2(300),
    salario NUMBER,
    cargo_id NUMBER REFERENCES cargos(id),
    excluido NUMBER(1)
);
 
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('Carlos', 2000, 3, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('João', 2500, 3, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('Thiago', 4000, 2, 0);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('Marcio', 4300, 2, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('Diogo', 1200, 2, 0);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('Maria', 5000, 1, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) VALUES ('Helena', 5000, 1, 0);
 
-- SALARIOS
CREATE TABLE dados_empresa (
    maior_salario NUMBER
);
 
INSERT INTO dados_empresa VALUES (0);
 
-- USUARIOS
CREATE SEQUENCE USUARIO_ID;
CREATE TABLE usuarios (
    id NUMBER DEFAULT USUARIO_ID.NEXTVAL PRIMARY KEY,
    nome VARCHAR2(300),
    idade NUMBER
);
 
INSERT INTO usuarios (nome, idade) VALUES ('Carlos', 26);
INSERT INTO usuarios (nome, idade) VALUES ('Mylana', 25);
INSERT INTO usuarios (nome, idade) VALUES ('Helena', 33);
INSERT INTO usuarios (nome, idade) VALUES ('Sarah', 29);
INSERT INTO usuarios (nome, idade) VALUES ('Igor', 20);
 
-- BACKUP
CREATE TABLE backup_usuarios (
    id NUMBER,
    nome VARCHAR2(300),
    idade NUMBER(3),
    operacao VARCHAR2(10),
    data TIMESTAMP
);
 
-- LOG
CREATE SEQUENCE LOG_ID;
CREATE TABLE log_funcionarios (
    id NUMBER DEFAULT LOG_ID.NEXTVAL PRIMARY KEY,
    usuario VARCHAR2(300),
    operacao VARCHAR2(10),
    data TIMESTAMP
);

SELECT USER FROM dual;
SELECT SYSTIMESTAMP FROM dual;


CREATE OR REPLACE TRIGGER alter_usuarios
AFTER INSERT OR UPDATE OR DELETE ON funcionarios
BEGIN
	IF INSERTING THEN
		INSERT INTO LOG_FUNCIONARIOS (usuario, operacao, data) 
			VALUES (USER, 'INSERT', SYSTIMESTAMP);
	ELSIF UPDATING THEN
		INSERT INTO LOG_FUNCIONARIOS (usuario, operacao, data) 
			VALUES (USER, 'UPDATE', SYSTIMESTAMP);
	ELSE
		INSERT INTO LOG_FUNCIONARIOS (usuario, operacao, data) 
			VALUES (USER, 'DELETE', SYSTIMESTAMP);
	END IF;
END;

SELECT * FROM FUNCIONARIOS f ;
SELECT * FROM LOG_FUNCIONARIOS lf ;
UPDATE FUNCIONARIOS SET NOME = 'Iago' WHERE ID = 1;
