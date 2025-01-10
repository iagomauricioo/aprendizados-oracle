-- Tabela para armazenar ULIDs como VARCHAR2
CREATE TABLE ulid_table (
    ulid VARCHAR2(26), -- ULID em formato texto com 26 caracteres
    id NUMBER
);

CREATE INDEX idx_ulid_table_ulid ON ulid_table (ulid);

-- Tabela para armazenar UUIDs como VARCHAR2
CREATE TABLE uuid_table (
    uuid VARCHAR2(36) DEFAULT LOWER(SYS_GUID()), -- UUID armazenado como texto com 36 caracteres
    id NUMBER
);

CREATE INDEX idx_uuid_table_uuid ON uuid_table (uuid);


EXPLAIN PLAN FOR 
SELECT * FROM ulid_table WHERE ulid = '01JH6ZF9GYV2FHG8AQBMMQNEVP';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR 
SELECT * FROM UUID_TABLE ut WHERE uuid = '507f21e0-ea2c-4294-9ce4-7b858fe05a61';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


SELECT * FROM UUID_TABLE ut ORDER BY UUID ;

SELECT * FROM ULID_TABLE ut ORDER BY ULID;
