DELIMITER $$
CREATE PROCEDURE doit_proc()
BEGIN
	DECLARE customer_cnt INT;
    DECLARE add_number INT;
    
    SET customer_cnt = 0;
    SET add_number = 100;
    
    SET customer_cnt = (SELECT COUNT(*) FROM customer);
    
    SELECT customer_cnt + add_number;

END $$
DELIMITER ; 

CALL doit_proc();

SELECT store_id, IF(store_id = 1, '일', '이') AS one_two
FROM customer GROUP BY store_id;


SELECT customer_id, SUM(amount) AS amount,
	CASE
		WHEN SUM(amount) >= 150 THEN 'VVIP'
        WHEN SUM(amount) >= 120 THEN 'VIP'
        WHEN SUM(amount) >= 100 THEN 'GOLD'
        WHEN SUM(amount) >= 80 THEN 'SILVER'
        ELSE 'BRONZE'
	END AS customer_level
FROM payment GROUP BY customer_id;

DROP TABLE IF EXISTS doit_clusterIndex;

CREATE TABLE doit_clusterIndex(
	col_1 INT,
    col_2 VARCHAR(50),
    col_3 VARCHAR(50)
);

INSERT INTO doit_clusterIndex VALUES (2,'사자', 'lion');
INSERT INTO doit_clusterIndex VALUES (5,'호랑이', 'tiger');
INSERT INTO doit_clusterIndex VALUES (3,'얼룩말', 'zbera');
INSERT INTO doit_clusterIndex VALUES (4,'코뿔소', 'Rhinoceros');
INSERT INTO doit_clusterIndex VALUES (1,'거북이', 'turtle');

ALTER TABLE doit_clusterIndex
	ADD CONSTRAINT PRIMARY KEY (col_1);
    
    

SELECT * FROM doit_clusterIndex;


CREATE TABLE student (
  hakbun CHAR(4),
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (hakbun));
  
  
DELIMITER $$
CREATE PROCEDURE select_student()
BEGIN	
    SELECT * FROM student;

END $$
DELIMITER ; 

call select_student();

DELIMITER $$
CREATE PROCEDURE select_student_by_name(IN student_name VARCHAR(45))
BEGIN	
    SELECT * FROM student
    WHERE name = student_name;

END $$
DELIMITER ; 

call select_student_by_name('김여름');


CREATE VIEW v_customer
AS
	SELECT first_name, last_name, email FROM customer;
    
SELECT * FROm v_customer;
SELECT * FROM customer;
    
CREATE TABLE tbl_trigger_1(
	col_1 INT,
    col_2 VARCHAR(50)
);

CREATE TABLE tbl_trigger_2(
	col_1 INT,
    col_2 VARCHAR(50)
);

INSERT INTO tbl_trigger_1 VALUES (1, '데이터 1 입력');
SELECT  * FROM tbl_trigger_1;

DELIMITER $$

CREATE TRIGGER dot_update_trigger
AFTER UPDATE
ON tbl_trigger_1
FOR EACH ROW

BEGIN
	INSERT INTO tbl_triggerstudent_2 VALUES (OLD.col_1,OLD.col_2);
END $$
DELIMITER ; 

SET SQL_SAFE_UPDATES = 0;

UPDATE tbl_trigger_1 SET col_1 = 2, col_2 = '1을 2로 수정';

SELECT * FROM tbl_trigger_2;
SELECT * FROM tbl_trigger_1;

SELECT * FROM student;

insert into student values ('S001', '김봄');
insert into student values ('S002', '김여름');
insert into student values ('S003', '김가을');
insert into student values ('S004', '김겨울');
insert into student values ('S005', '이지원');
insert into student values ('S006', '홍지원');

CREATE TABLE student_body(
	hakbun CHAR(4),
	sex varchar(50),
	bloodtype varchar(50),
	height int,
	weight int,
	mbtl varchar(50),
    PRIMARY KEY (hakbun)
);

insert into student_body values ('S001', 'W', 'O', 160, 55, 'INFP');
insert into student_body values ('S002', 'M', 'A', 177, 75, 'ENFP');
insert into student_body values ('S003', 'M', 'A', 180, 80, 'ESFJ');
insert into student_body values ('S004', 'W', 'AB', 162, 50, 'ISFJ');
insert into student_body values ('S005', 'W', 'O', 165, 54, 'INFP');
insert into student_body values ('S006', 'W', 'B', 170, 60, 'ENFP');

CREATE TABLE student_personal(
	hakbun char(4),
    address varchar(50),
    email varchar(50),
    phone varchar(50),
    PRIMARY KEY (hakbun)
);

insert into student_personal values ('S001', '서울', 'spring@mail.com', '01011111111');
insert into student_personal values ('S002', '제주', 'summer@mail.com', '01022222222');
insert into student_personal values ('S003', '여수', 'fall@mail.com', '01033333333');
insert into student_personal values ('S004', '부산', 'wineter@mail.com', '01044444444');
insert into student_personal values ('S005', '서울', 'ljw@mail.com', '01055555555');
insert into student_personal values ('S006', '제주', 'hjw@mail.com', '01066666666');

CREATE TABLE subject(
	id char(4),
    name varchar(50),
    PRIMARY KEY (id)
);

CREATE TABLE score(
	seq int AUTO_INCREMENT,
    id char(4),
    hakbun char(4),
    score INT UNSIGNED NOT NULL,
    primary key (seq)
);

insert into score values (null, 'B001','S001', 85);
insert into score values (null, 'B001','S002', 90);
insert into score values (null, 'B001','S003', 80);
insert into score values (null, 'B001','S004', 100);
insert into score values (null, 'B001','S005', 90);
insert into score values (null, 'B001','S006', 90);
insert into score values (null, 'B002','S001', 70);
insert into score values (null, 'B002','S002', 80);
insert into score values (null, 'B002','S003', 90);
insert into score values (null, 'B002','S004', 85);
insert into score values (null, 'B003','S001', 100);
insert into score values (null, 'B003','S002', 100);
insert into score values (null, 'B003','S005', 70);
insert into score values (null, 'B003','S006', 75);

insert into subject values ('B001', '미술');
insert into subject values ('B002', '음악');
insert into subject values ('B003', '디자인');
insert into subject values ('B004', '테니스');

-- 모든 과목의 성적
-- 정렬: 과목(아이디), 점수
SELECT * FROM score;
SELECT * FROM subject;
SELECT * FROM student;



SELECT 
	sc.id, sj.name AS 과목, sc.score AS 점수, sc.hakbun AS 학번, st.name AS 이름
FROM 
	subject AS sj
left join score AS sc ON sj.id = sc.id
left join student AS st ON sc.hakbun = st.hakbun
ORDER BY sj.id, sc.score DESC;


SELECT * FROM score;
SELECT * FROM subject;
SELECT * FROM student;

-- 모든 학생의 디자인 성적
-- 정렬: 이름
select 
            s.hakbun as '학번', 
            s.name as '이름',
            ifnull(T1.name, '-') as '과목',
            ifnull(T1.score,0)  as '점수'
from    student as s
left outer join (
    select  c.hakbun, 
			c.score,
			b.name
     from subject  as b
    inner join score as c on b.id = c.id
     where b.name = '디자인'
    ) as T1 on s.hakbun = T1.hakbun
    order by s.name;
    

    

SELECT * FROM score;
SELECT * FROM subject;
SELECT * FROM student;
SELECT * FROM student_body;
select * FROM student_personal;

SELECT
st.name,
	case 
                when sb.sex = 'W'    then '여'
                when sb.sex = 'M'    then '남'
                else ''
            end as '성별',
sb.bloodtype AS '혈액형',
sb.height AS '키(cm)',
sb.weight AS '몸무게(kg)',
sb.mbtl AS 'MBTI',
	
FROM student AS st
INNER JOIN student_body AS sb ON st.hakbun = sb.hakbun;


SELECT
	sj.name AS 과목
	, CAST(AVG(sc.score) AS DECIMAL(10,1)) AS 평균
FROM
	subject AS sj
inner join score AS sc ON sj.id = sc.id
GROUP BY sj.name
ORDER BY 평균 DESC;

-- 시험 과목별 평균 점수
-- 정렬 점수
SELECT
	ROW_NUMBER() OVER (ORDER BY 평균 DESC) AS 순위,
	sj.name AS 과목
	, CAST(AVG(sc.score) AS DECIMAL(10,1)) AS 평균
FROM
	subject AS sj
inner join score AS sc ON sj.id = sc.id
GROUP BY sj.name
ORDER BY 평균 DESC;



SELECT 
st.name AS '이름',
COUNT(st.hakbun) AS 과목
FROM 
student AS st
inner join score AS sc ON st.hakbun = st.hakbun
GROUP BY st.hakbun
ORDER BY st.name;





select case 
                when b.sex = 'W'    then '여'
                when b.sex = 'M'    then '남'
                else ''
            end as '성별',
            count(b.sex) as '인원'
from    student as s
inner join student_body as b on s.hakbun = b.hakbun
group by b.sex
order by b.sex;

-- select case 
--                 when b.bloodtype = 'A'    then 'A'
--                 when b.bloodtype = 'AB'    then 'AB'
-- 				when b.bloodtype = 'B'    then 'B'
-- 				when b.bloodtype = 'O'    then 'O'
--                 else ''
--             end as '성별',
--             count(b.sex) as '인원'
-- from    student as s
-- inner join student_body as b on s.hakbun = b.hakbun
-- group by b.sex
-- order by b.sex;

SELECT * FROM student;
SELECT
	sj.name AS 과목    
    , COUNT(st.hakbun) AS 학생
    , SUM(sc.score) AS 합계
	, CAST(AVG(sc.score) AS DECIMAL(10,1)) AS 평균
FROM
	subject AS sj
inner join score AS sc ON sj.id = sc.id
inner join student AS st ON st.hakbun = sc.hakbun 
GROUP BY sj.name
ORDER BY sj.name ASC;

SELECT 
	sc.hakbun AS 학번
     ,st.name AS 이름 
FROM score AS sc
inner join student AS st ON sc.hakbun = st.hakbun
inner join subject AS sj ON sc.id = sj.id
WHERE sj.name IN ('음악', '미술');



SELECT
*
FROM student;

SELECT
*
FROM subject;

create table accounts (
  ano       varchar(20)   primary key,
  owner     varchar(20)   not null,
  balance   numeric       not null
);

create table boards (
    bno             int             primary key auto_increment,
    btitle          varchar(100)    not null,
    bcontent        longtext        not null,
    bwriter         varchar(50)     not null,
    bdate           datetime        default now(),
    bfilename       varchar(50)     null,
    bfiledata longblob null
);

create table users (
userid   varchar(50)  primary key, 
username varchar(50)  not null,
userpassword varchar(50)  not null,
userage numeric(3)not null,
useremail varchar(50)  not null
);
SELECT * FROM users;
SELECT * FROM boards;
