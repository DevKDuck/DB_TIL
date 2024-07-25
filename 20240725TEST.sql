USE DoItSQL;

CREATE TABLE GAME_CHARACTER(
 NAME VARCHAR(20) NOT NULL,
 RACE VARCHAR(20) NOT NULL,
 JOB VARCHAR(20) NOT NULL,
 HEALTH INT NOT NULL, 
 ATTACK INT NOT NULL,
 DEFENCE INT NOT NULL
);

DROP TABLE GAME_CHARACTER;

SELECT
	NAME AS '이름'
    ,RACE AS '종족'
    ,JOB AS '직업'
    ,HEALTH AS '체력'
    ,ATTACK AS '공격력'
    ,DEFENCE AS '방어력'
FROM
    GAME_CHARACTER
WHERE
	 JOB = '기사';
     
SELECT
	NAME AS '이름'
    ,RACE AS '종족'
    ,JOB AS '직업'
    ,HEALTH AS '체력'
    ,ATTACK AS '공격력'
    ,DEFENCE AS '방어력'
FROM
    GAME_CHARACTERGAME_CHARACTER
WHERE
	DEFENCE > 90;
    
UPDATE
	GAME_CHARACTER
SET
	ATTACK = ATTACK - 20
WHERE
	DEFENCE > 90;

    
UPDATE
	GAME_CHARACTER
SET
	DEFENCE = 100
WHERE
	JOB = '기사';
    
UPDATE 
	GAME_CHARACTER
SET
	HEALTH = 40, ATTACK = 50
WHERE
	NAME = '와일드 헌터';
	
    
INSERT INTO GAME_CHARACTER
	(NAME, RACE, JOB, HEALTH, ATTACK, DEFENCE)
VALUES
	('에반', '엘프', '마법사', 50, 50 ,100)
    ,('아크메이지', '드위프', '마법사', 60, 60, 90)
    ,('와일드 헌터', '휴먼', '궁수', 90, 90, 80)
    ,('다크 나이트', '나이트 엘프', '기사', 90, 90, 80)
    ,('카이저', '휴먼', '기사', 95, 85, 85);
    


DELETE FROM
	GAME_CHARACTER
WHERE
	RACE = '휴먼';
    

SELECT
	first_name
FROM
	customer;
    
SHOW COLUMNS
FROM
	sakila.customer;
    
SELECT
	*
FROM
	customer
WHERE
	address_id = 200;

SELECT
	*
FROM
	customer
WHERE
	address_id < 200;
    
SELECT
	*
FROM
	customer
WHERE
	first_name < 'CALVIN';
    
SELECT
	*
FROM
	payment
WHERE
	payment_date < '2005-07-09 23:00:00';
    
SELECT
	*
FROM
	customer
WHERE
	address_id
BETWEEN
	5 AND 10;

SELECT
	*
FROM
	payment
WHERE
	payment_date
BETWEEN
	'2005-06-17' AND '2005-07-19';

SELECT
	*
FROM
	customer
WHERE
	first_name
BETWEEN
	'M' AND 'O';
    
SELECT
	*
FROM
	customer
WHERE
	first_name
NOT BETWEEN
	'M' AND 'O';
    
SELECT
	*
FROM
	payment
WHERE
	payment_date >= '2005-06-01'
AND
	payment_date <= '2005-07-05';
    
SELECT
	*
FROM
	customer
WHERE
	first_name IN ('MARIA', 'LINDA', 'NANCY');
    

SELECT
	*
FROM
	city
WHERE
	country_id IN (103,86)
AND
	city IN ('Cheju', 'Sunnyvale', 'Dallas');
    

SELECT
	*
FROM
	address
WHERE
	address2 IS NULL;
    
SELECT
	*
FROM
	address
WHERE
	address2 IS NOT NULL;
    
SELECT
	*
FROM
	address
WHERE
	address2 = '';
    
SELECT
	*
FROM
	customer
ORDER BY
	store_id, first_name;
    
SELECT
	*
FROM
	customer
ORDER BY
	first_name, store_id;
    
SELECT
	*
FROM
	customer
ORDER BY
	first_name DESC;
    
SELECT
	*
FROM
	customer
ORDER BY
	store_id DESC, first_name ASC;

SELECT
	*
FROM
	customer
ORDER BY
	store_id DESC, first_name ASC LIMIT 10;    

SELECT
	*
FROM
	customer
ORDER BY
	store_id DESC, first_name ASC LIMIT 10 OFFSET 100;
    
SELECT
	*
FROM
	customer
WHERE
	first_name
LIKE
	'A_';
    
SELECT
	*
FROM
	customer
WHERE
	first_name
LIKE
	'__A';
    
SELECT
	*
FROM
	customer
WHERE
	first_name
LIKE
	'A__A';
    
SELECT
	*
FROM
	customer
WHERE
	first_name
LIKE
	'_____';
    

SELECT
	*
FROM
	customer
WHERE
	first_name
LIKE
	'A_R%';
    

SELECT
	*
FROM
	customer
WHERE
	first_name
LIKE
	'__R%';
    
SELECT
	*
FROM
	customer
WHERE
	first_name
REGEXP
	'^K|N$';
-- K로시작 N으로 종료 


    
SELECT
	*
FROM
	customer
WHERE
	first_name
REGEXP
	'K[L-N]';
-- K와 함께 L과 N사이 글자


SELECT
	special_features, rating
FROM
	film
GROUP BY
	special_features, rating;
    
SELECT
	special_features,
    COUNT(*) AS cnt
FROM
	film
GROUP BY
	special_features;
    
SELECT
	special_features, rating
FROM
	film
GROUP BY
	special_features,rating
HAVING
	rating = 'G';
    
SELECT
	special_features, COUNT(*) AS cnt
FROM
	film
GROUP BY
	special_features
HAVING 
	cnt > 70;
    
SELECT DISTINCT
	special_features, rating
FROM
	film;

SELECT 
	special_features, rating
FROM
	film
GROUP BY
	special_features, rating;


CREATE TABLE culture (
  category varchar(20) DEFAULT NULL,    -- 카테고리
  gu varchar(10) DEFAULT NULL,        -- 자치구
  title varchar(100) DEFAULT NULL,    -- 문화행사명
  location varchar(200) DEFAULT NULL,    -- 장소
  agency varchar(20) DEFAULT NULL,        -- 기관
  homepage varchar(600) DEFAULT NULL,        -- 홈페이지
  pay varchar(10) DEFAULT NULL,        -- 유무료
  sdate date DEFAULT NULL,        -- 시작일
  edate date DEFAULT NULL,        -- 종료일
  ldate date DEFAULT NULL        -- 신청마감일
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;


SELECT VERSION();

SELECT * FROM culture;

-- 1번
SELECT category, gu, category AS 카테고리, gu AS 자치구 FROM culture;

-- 카테고리, 자치구, 문화행사 오름차순으로 정렬 후 5개 조회	
SELECT category AS 카테고리, gu AS 자치구, title AS 문화행사, location AS 장소
FROM culture
ORDER BY category ASC, gu ASC, title ASC limit 5 ;

-- 카테고리 내림차순, 자치구 오름차순, 문화행사 내림차순으로 정렬 후 3개 조회
SELECT category AS 카테고리, gu AS 자치구, title AS 문화행사, location AS 장소
FROM culture
ORDER BY category DESC, gu ASC, title DESC limit 3 ;

-- 연극 조회
SELECT category AS 카테고리, gu AS 자치구, title AS 문화행사, location AS 장소
FROM culture
WHERE category = '연극';

-- 노원구 문화행사 조회 
SELECT category AS 카테고리, gu AS 자치구, title AS 문화행사, location AS 장소
FROM culture
WHERE gu = '노원구';

-- 중구문화재단에서 진행되는 문화행사 조회
SELECT category AS 카테고리, gu AS 자치구, title AS 문화행사, location AS 장소, agency AS 기관
FROM culture
WHERE agency = '중구문화재단';

-- 중구문화재단을 제외한 다른 곳에서 진행되는 문화행사 조회
SELECT category AS 카테고리, gu AS 자치구, title AS 문화행사, location AS 장소, agency AS 기관
FROM culture
WHERE NOT agency = '중구문화재단';


-- 시작일이 2024.12.31. 이전인 문화행사 조회
SELECT category AS 카테고리
		, gu AS 자치구
		, title AS 문화행사
		, location AS 장소
		,  pay AS 유무료
		, sdate AS 시작일
		, edate AS 종료일
		, ldate AS 신청마감일
FROM
	culture
WHERE
	sdate <= '2024-12-31';

SELECT *
from culture;

-- 종로구에서 진행하는 무료 클래스 조회

SELECT category AS 카테고리
		, gu AS 자치구
		, title AS 문화행사
		, location AS 장소
		,  pay AS 유무료
		, sdate AS 시작일
		, edate AS 종료일
		, ldate AS 신청마감일
FROM
	culture
WHERE
	gu = '종로구' AND pay = '무료';
    

-- 광진구에서 진행하는 교육/체험 이외 문화행사 중 유료인 행사 조회
SELECT category AS 카테고리
		, gu AS 자치구
		, title AS 문화행사
		, location AS 장소
		,  pay AS 유무료
		, sdate AS 시작일
		, edate AS 종료일
		, ldate AS 신청마감일
FROM
	culture
WHERE
	gu = '광진구' AND (NOT category = '교육/체험') AND pay = '유료';
    
-- 강서구, 영등포구에서 진행하는 국악, 무용, 콘서트 조회
SELECT category AS 카테고리
		, gu AS 자치구
		, title AS 문화행사
		, location AS 장소
		,  pay AS 유무료
		, sdate AS 시작일
		, edate AS 종료일
        ,ldate AS 신청마감일
FROM
	culture
WHERE
	gu IN ('강서구', '영등포구') AND category IN ('국악', '무용', '콘서트');
    

-- 2024.12.25. ~ 2025.01.25. 사이에 경험할 수 있는 문화행사 조회
-- 카테고리 오름차순, 자치구 오름차순, 시작일 오름차순, 종료일 오름차순
select     category '카테고리', 
                gu '자치구',
                title    '문화행사',
                location '장소',
                pay '유무료',
                sdate '시작일',
                edate '종료일',
               ldate '신청마감일'
from culture
where 
(sdate BETWEEN   '2024-12-25' AND '2025-01-25') 
OR (edate BETWEEN   '2024-12-25' AND '2025-01-25') 
OR (sdate < '2024-12-25' AND edate > '2025-01-25')
ORDER BY category, gu, sdate, edate;

-- 2024.12.25. ~ 2025.01.25. 사이에 경험할 수 있는 전시/미술 조회
-- 정렬 : 시작일 오름차순, 종료일 오름차순
select     category '카테고리', 
                gu '자치구',
                title    '문화행사',
                location '장소',
                pay '유무료',
                sdate '시작일',
                edate '종료일',
               ldate '신청마감일'
from culture
where category = '전시/미술'
AND (
    (sdate BETWEEN   '2024-12-25' AND '2025-01-25') 
    OR (edate BETWEEN   '2024-12-25' AND '2025-01-25') 
    OR (sdate < '2024-12-25' AND edate > '2025-01-25')
)
ORDER BY sdate, edate;



-- 퉁소 문화행사 조회
SELECT category AS 카테고리
		, gu AS 자치구
		, title AS 문화행사
		, location AS 장소
		,  pay AS 유무료
		, sdate AS 시작일
		, edate AS 종료일
        , ldate AS 신청마감일
FROM
	culture
WHERE title LIKE '%퉁소%';

-- 송파구, 강동구에 있는 첼로 문화행사 조회
-- 정렬 : 시작일 오름차순, 종료일 오름차순
SELECT category AS 카테고리
		, gu AS 자치구
		, title AS 문화행사
		, location AS 장소
		,  pay AS 유무료
		, sdate AS 시작일
		, edate AS 종료일
        , ldate AS 신청마감일
FROM
	culture
WHERE
	gu IN ('송파구','강동구') AND  title LIKE '%첼로%'
ORDER BY
	sdate ASC, edate ASC;
    
    
-- 종로구 세종대극장에서 진행하는 뮤지컬 조회
-- 정렬 : 신청마감일 오름차순
SELECT category AS 카테고리
	, gu AS 자치구
	, title AS 문화행사
	, location AS 장소
	,  pay AS 유무료
	, sdate AS 시작일
	, edate AS 종료일
	, ldate AS 신청마감일
FROM
	culture
WHERE
	gu = '종로구' AND location = '세종대극장' AND category = '뮤지컬'
ORDER BY
	ldate ASC;
    
    
    
-- 장소가 소극장이며 무료인 클래식, 국악 문화행사 조회
-- 정렬 : 시작일 오름차순, 종료일 오름차순
SELECT category AS 카테고리
	, gu AS 자치구
	, title AS 문화행사
	, location AS 장소
	,  pay AS 유무료
	, sdate AS 시작일
	, edate AS 종료일
	, ldate AS 신청마감일
FROM
	culture
WHERE
	location = '소극장' AND pay = '무료' AND category IN ('클래식','국악')
ORDER BY
	sdate ASC, edate ASC;
    
    
    
    
    
CREATE TABLE doit_increment(
	col_1 INT AUTO_INCREMENT PRIMARY KEY,
    col_2 VARCHAR(50),
    col_3 INT
);

INSERT INTO doit_increment (col_2, col_3)
VALUES ('1 자동 입력', 1);
INSERT INTO doit_increment (col_2, col_3)
VALUES ('2 자동 입력', 2);

SELECT * FROM doit_increment;

INSERT INTO doit_increment (col_1, col_2, col_3)
VALUES (3, '3자동 입력', 3);

INSERT INTO doit_increment (col_1, col_2, col_3)
VALUES (5, '4건너 뛰고 5자동 입력', 5);

INSERT INTO doit_increment (col_2, col_3)
VALUES ('어디까지 입력되었을까?', 0);

DROP TABLE doit_insert_select_from;

CREATE TABLE doit_insert_select_from(
	col_1 INT,
    col_2 VARCHAR(10)
);

CREATE TABLE doit_insert_select_to(
	col_1 INT,
    col_2 VARCHAR(10)
);

INSERT INTO doit_insert_select_from VALUES (1,'DO');
INSERT INTO doit_insert_select_from VALUES (2,'It');
INSERT INTO doit_insert_select_from VALUES (3,'MySQL');

INSERT INTO doit_insert_select_to SELECT * FROM doit_insert_select_from;

SELECT * FROM doit_insert_select_to;
SELECT * FROm doit_insert_select_from;


CREATE TABLE doit_parent (col_1 INT PRIMARY KEY);
CREATE TABLE doit_child (col_1 INT);

ALTER TABLE doit_child ADD FOREIGN KEY (col_1) REFERENCES doit_parent(col_1);

INSERT INTO doit_parent VALUES (1);
INSERT INTO doit_child VALUES (1);
SELECT * FROM doit_parent;
SELECT * FROM doit_child;

DELETE FROM doit_child WHERE col_1 = 1;
DELETE FROM doit_parent WHERE col_1 = 1;

CREATE TABLE doit_char_varchar(
	col_1 CHAR(5),
    col_2 VARCHAR(5)
);

INSERT INTO doit_char_varchar VALUES ('12345', '12345');
INSERT INTO doit_char_varchar VALUES ('ABCDE', 'ABCDE');
INSERT INTO doit_char_varchar VALUES ('가나다라마', '가나다라마');
INSERT INTO doit_char_varchar VALUES ('hello', '안녕하세요');
INSERT INTO doit_char_varchar VALUES ('安寧安寧安', '安寧安寧安');

SELECT
	col_1, char_length(col_1) as char_length, length(col_1) AS char_byte,
    col_2, char_length(col_2) as char_length, length(col_2) AS char_byte
FROM doit_char_varchar;

