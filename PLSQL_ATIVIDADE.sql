ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER aula_plsql_atividade IDENTIFIED BY "123456";
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO aula_plsql_atividade;

-- CARGOS
CREATE SEQUENCE cargoID;
CREATE TABLE cargos (
	id number DEFAULT cargoID.nextval primary key,
	cargo varchar2(100),
	aumento number(7,2) 
);

INSERT INTO cargos (cargo, aumento) values ('diretor', 1000);
INSERT INTO cargos (cargo, aumento) values ('coordenador', 500);
INSERT INTO cargos (cargo, aumento) values ('professor', 200);
SELECT * FROM CARGOS;

-- FUNCIONARIOS
CREATE SEQUENCE funcionarioID;
CREATE TABLE funcionarios (
	id number DEFAULT funcionarioID.nextval primary key ,
	nome varchar2(200),
	salario number,
	cargo_id number REFERENCES cargos(id),
	excluido number
);

INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('Carlos', 2000, 3, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('João', 2500, 3, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('Thiago', 4000, 2, 0);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('Marcio', 4300, 2, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('Diogo', 1200, 2, 0);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('Maria', 5000, 1, 1);
INSERT INTO funcionarios (nome, salario, cargo_id, excluido) values ('Helena', 5000, 1, 0);

CREATE OR REPLACE FUNCTION getFuncionariosByCargo (cargoProcurado varchar2)
RETURN NUMBER 
AS funcionariosAtivos NUMBER;
BEGIN 
	SELECT COUNT(*) INTO funcionariosAtivos FROM funcionarios f 
	INNER JOIN cargos c ON f.cargo_id = c.id WHERE c.cargo = cargoProcurado 
	AND f.excluido = 0;
	
	RETURN funcionariosAtivos;
END;

CREATE OR REPLACE FUNCTION chequeSalario (funcID number)
RETURN VARCHAR2 
AS 
valor NUMBER;
BEGIN 
	SELECT SALARIO INTO valor FROM funcionarios f 
	WHERE f.id = funcID;
	IF (valor <= 3999) THEN
		RETURN 'Não é maior que R$3999,00';
	ELSE
		RETURN 'É maior do que R$3999,00';
	END IF;
END;

CREATE OR REPLACE PROCEDURE popularBancoTeste(qtd number)
AS salarioInicial NUMBER := 1000;
BEGIN 
	FOR i IN 1..qtd LOOP
		INSERT INTO funcionarios (nome, salario, cargo_id, excluido)
		VALUES ('Funcionário teste', salarioInicial, 3, 1);
		salarioInicial:= salarioInicial + 200;
	END LOOP;
END;


CREATE OR REPLACE PROCEDURE aumentaSalario
AS
    v_aumento NUMBER;
BEGIN
    FOR linha IN (SELECT id, cargo_id, salario FROM funcionarios) LOOP
        CASE
            WHEN linha.cargo_id = 1 THEN v_aumento := 1.20;
            WHEN linha.cargo_id = 2 THEN v_aumento := 1.15;
            WHEN linha.cargo_id = 3 THEN v_aumento := 1.10;
            ELSE v_aumento := 1.00;
        END CASE;
        UPDATE funcionarios 
        SET salario = linha.salario * v_aumento 
        WHERE id = linha.id;
    END LOOP;
    COMMIT;
END;
SELECT * FROM FUNCIONARIOS;
CALL aumentaSalario();
