ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER aula_trigger_atividade;
GRANT RESOURCE, UNLIMITED TABLESPACE TO aula_trigger_atividade;

---- SETORES -----
CREATE SEQUENCE SETOR_ID;
create table setores (
	id number DEFAULT SETOR_ID.nextval primary key,
	setor varchar2(200),
	total_funcionarios number default(0)
);

insert into setores (setor) values ('RH');
insert into setores (setor) values ('Financeiro');
insert into setores (setor) values ('Acadêmico');
insert into setores (setor) values ('Reitoria');
insert into setores (setor) values ('Almoxarifado');

------- EMPREGADOS -------
CREATE SEQUENCE EMPREGADO_ID;
create table empregados (
	id number DEFAULT EMPREGADO_ID.nextval primary key,
	nome varchar2(200),
	salario number,
	setor_id number references setores(id)
);

insert into empregados (nome, salario, setor_id) values ('Arthur', 2314.50, 1);
insert into empregados (nome, salario, setor_id) values ('Alice', 3000.00, 1);
insert into empregados (nome, salario, setor_id) values ('Sophia', 1500.00, 2);
insert into empregados (nome, salario, setor_id) values ('Júlia', 2000.00, 2);
insert into empregados (nome, salario, setor_id) values ('Pedro', 1000.50, 3);
insert into empregados (nome, salario, setor_id) values ('Antonio', 1888.90, 3);
insert into empregados (nome, salario, setor_id) values ('Marcos', 5000.00, 4);
insert into empregados (nome, salario, setor_id) values ('Lais', 3450.30, 4);
insert into empregados (nome, salario, setor_id) values ('Monica', 3333.33, 5);
insert into empregados (nome, salario, setor_id) values ('Eduardo', 1543.00, 5);

------ LOGS --------
create table logs_empregados (
	empregado_id number,
	usuario varchar2(200),
	operacao varchar2(200),
	data_operacao timestamp
);

--1º Questão
CREATE OR REPLACE TRIGGER funcionarios_zero
BEFORE INSERT ON setores
FOR EACH ROW
BEGIN
	:NEW.total_funcionarios := 0;
END;

--2º Questão
CREATE OR REPLACE TRIGGER salario_sempre_positivo
BEFORE INSERT OR UPDATE ON empregados
FOR EACH ROW 
BEGIN
	IF :NEW.salario < 0 THEN
		raise_application_error(20001, 'Salário negativo não é permitido!');
	END IF;
END;

--3º Questão
CREATE OR REPLACE TRIGGER salario_menor_937_maior_10000
BEFORE INSERT OR UPDATE ON empregados
FOR EACH ROW 
BEGIN
	IF :NEW.salario < 937 THEN
		:NEW.salario := 937;
	ELSIF :NEW.salario > 10000 THEN
		:NEW.salario := 10000;
	END IF;
END;

--4º Questão
CREATE OR REPLACE TRIGGER atualizar_qtd_funcionarios
BEFORE INSERT OR DELETE ON empregados
FOR EACH ROW 
BEGIN
	IF INSERTING THEN
		UPDATE SETORES s SET total_funcionarios = total_funcionarios + 1 WHERE :NEW.setor_id = s.id;
	ELSE
		UPDATE SETORES s SET total_funcionarios = total_funcionarios - 1 WHERE :OLD.setor_id = s.id;
	END IF;
END;

--5º Questão
CREATE OR REPLACE TRIGGER backupEmpregados
BEFORE INSERT OR UPDATE OR DELETE ON empregados
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO LOGS_EMPREGADOS le 
			VALUES (:NEW.id, USER, 'Inserindo usuário', SYSTIMESTAMP);
	ELSIF UPDATING THEN
		INSERT INTO LOGS_EMPREGADOS le 
			VALUES (:OLD.id, USER, 'Atualizando usuário', SYSTIMESTAMP);
	ELSE
		INSERT INTO LOGS_EMPREGADOS le 
			VALUES (:OLD.id, USER, 'Deletando usuário', SYSTIMESTAMP);
	END IF;
END;

