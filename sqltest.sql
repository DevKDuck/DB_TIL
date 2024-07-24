CREATE DATABASE DoItSQL;
USE DoItSQL;
-- DROP DATABASE DoItSQL;

CREATE TABLE doit_create_table(
	col_1 int,
    clo_2 varchar(50),
    col_3 datetime
);
DROP TABLE doit_create_table;
SELECT * FROM doit_create_table;

CREATE TABLE doit_dml(
	col_1 int,
    clo_2 varchar(50),
    col_3 datetime
);

INSERT INTO doit_dml 
	(col_1, clo_2, col_3)
VALUES
	(1, 'DoItSQL', '2023-01-01');
    
SELECT
	*
FROM 
	doit_dml;

INSERT INTO
	doit_dml(col_1)
VALUES
	('문자 입력');
    
INSERT INTO
	doit_dml
VALUES
	(2, '열 이름 생략', '2023-01-02');


INSERT INTO
	doit_dml(col_1, clo_2)
VALUES
	(2, '열 이름 생략');
    
INSERT INTO
	doit_dml(col_1, col_3, clo_2)
VALUES
	(4, '2023-01-03', '열 순서 변경');

CREATE TABLE doit_notnull(
	col_1 INT,
	col_2 VARCHAR(50) NOT NULL
);

INSERT INTO
	doit_notnull (col_1)
VALUES
	(1);
    
INSERT INTO
	doit_dml(col_1, clo_2, col_3)
VALUES
	(5, '데이터 입력5', '2023-01-03')
    ,(6, '데이터 입력6', '2023-01-03')
    ,(7, '데이터 입력7', '2023-01-03');
    
    
UPDATE
	doit_dml
SET
	clo_2 = '데이터 수정'
WHERE
	col_1 = 4;
    

UPDATE
	doit_dml
SET
	col_1 = col_1 + 10;
    
DELETE FROM
	doit_dml;
    