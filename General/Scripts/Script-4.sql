
/*
 *  DML (insert, update, delete) -> 객체 생성 및 관리
 *  DDL (테이블 생성, 테이블 수정, 테이블 삭제) -> 클래스 선언
*/

--dept_temp 이름으로 테이블 생성 됨
-- 재실행하면 동일 오브젝트 생성 불가능해서 에러
CREATE TABLE dept_temp AS 
SELECT * FROM DEPT;

-- 테이블 삭제
DROP TABLE dept_temp;

SELECT * FROM dept_temp;

--insert
-- INSERT INTO 테이블명 VALUES (값1,값2);
-- INSERT INTO 테이블명 (컬럼1,컬럼2) VALUES (값1,값2);

INSERT INTO dept_temp VALUES (50, 'DATABASE', 'SEOUL');


INSERT INTO dept_temp (deptno, dname, loc) VALUES (60, 'NETWORK', 'BUSAN');

-- 제약이 없을 경우 짝이 맞으면 삽입 가능

-- 삽입 성공
INSERT INTO dept_temp (deptno, dname) VALUES (70, 'DATABASE2');

-- 삽입 성공
INSERT INTO dept_temp (deptno) VALUES (80);

--null데이터 직접 삽입 가능
INSERT INTO dept_temp (deptno, dname, loc) VALUES (70, 'DATABASE2', null);

SELECT * FROM dept_temp;

-- 결과 집합을 이용하여 테이블을 생성함 (데이터 존재)
CREATE TABLE emp_temp AS SELECT * FROM emp;

SELECT * FROM emp_temp;

--임시 직원 테이블 삭제
DROP TABLE emp_temp;

--결과 집합없이 테이블 구조만 생성는 경우
CREATE  TABLE EMP_TEMP AS 
SELECT  * FROM emp WHERE 1 <> 1;

SELECT * FROM emp_temp;

--emp_temp 테이블에 홍길동 자료 추가
INSERT INTO EMP_TEMP(EMPNO, ename , job, HIREDATE, sal, COMM, DEPTNO)
VALUES(9999,'홍길동','사장님','2024-02-28',10000,1000,10);


-- 사원정보 등록
INSERT INTO EMP_TEMP(EMPNO, ename , job, HIREDATE, sal, COMM, DEPTNO,MGR)
VALUES(1000,'이순신', '해군제독','2024-02-28',10000,1000,10,9999);

-- 사원정보 등록 실패 경우 (날짜 구조 이상으로)
INSERT INTO EMP_TEMP(EMPNO, ename , job, HIREDATE, sal, COMM, DEPTNO,MGR)
VALUES(1000,'이순신', '해군제독','02-2024-28',10000,1000,10,9999);

-- 사원정보 등록 성공 경우 (sysdate: 시스템의 현재 날짜와 시간)
INSERT INTO EMP_TEMP(EMPNO, ename , job, HIREDATE, sal, COMM, DEPTNO,MGR)
VALUES(1000,'이순신', '해군제독',sysdate,10000,1000,10,9999);

--사원정보 등록 성공 (문자열 날짜와 시간을 날짜형으로 변경 -> to_date ) 
INSERT INTO emp_temp (
   empno, 
   ename, 
   job,
   hiredate,
   sal,
   comm,
   deptno,
   mgr
) VALUES (
   1000,
   '이순신',
   '해군제독',
   to_date('2024-01-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),
   10000,
   1000,
   10,
   9999
)
;
-- 조회 결과 집합을 테이블에 삽입하는 방법
INSERT INTO EMP_TEMP(EMPNO, ename , job, mgr, HIREDATE, sal, COMM, DEPTNO)
SELECT EMPNO, ename , job, mgr, HIREDATE, sal, COMM, DEPTNO
FROM emp WHERE DEPTNO = 20;


-- emp 테이블에서 급여등급이 1에 포함되는 사원을 조회하여 emp_temp에 삽입
INSERT INTO EMP_TEMP(EMPNO, ename , job, mgr, HIREDATE, sal, COMM, DEPTNO)
SELECT EMPNO, ename , job, mgr, HIREDATE, sal, COMM, DEPTNO
FROM emp e JOIN SALGRADE s ON (e.sal BETWEEN s.LOSAL AND s.HISAL)
WHERE  s.GRADE  = 1;

/*
 * 수정
 * UPDATE 테이블명 SET 
	변경할컬럼1 = 값1,
	변경할컬럼2 = 값2
	WHERE 조건
 */

--where 조건절을 빼면 모든데이터가 다 바뀜


--update를 위한 임시 테이블 생성
CREATE TABLE dept_tmp2 AS SELECT * FROM DEPT;

DROP TABLE dept_emp2;

SELECT * FROM dept_tmp2;

--dept_temp의 모든 자료, 지역을 서울로 변경
UPDATE dept_tmp2 SET
loc = '서울';

-- 커밋을 하지 않으면 임시 테이블(롤백테이블/자신의 영역)에서만 바뀜
-- 객체의 삽입, 수정, 삭제를 저장한다.
-- 테이블 상비, 수정, 삭제는 커밋이 되지 않음
COMMIT;

DROP TABLE dept_tmp2;

SELECT * FROM dept_tmp2;

-- 롤백을 이용해서 컨에 상태로 돌릴 수 있다.
ROLLBACK;

DROP TABLE dept_tmp2;

--dept_temp의 temp2 부서번호 40번의 이름을 DATAbsae,lOC로 서 변경

UPDATE dept_tmp2 SET
dname = 'DATABAS',
loc = '서울'
WHERE DEPTNO= 40;

-- 저장
COMMIT;

SELECT  * FROM dept
UNION ALL
SELECT * FROM dept_tmp2;

--dept_tmp2 테이블의 부서번호가 40인 자료를 dept테이블의 부서번호 40인 자료로 변경할 것
SELECT  * FROM dept_tmp2 WHERE  DEPTNO  = 40;

UPDATE dept_tmp2 SET
	(dname,loc) = (SELECT dname,loc FROM DEPT WHERE  DEPTNO  = 40)
WHERE DEPTNO= 40;

-- dual 테이블을 이용하여 변경
UPDATE dept_tmp2 SET (dname,loc) = (SELECT 'DATABASE', '서울' FROM dual) WHERE DEPTNO = 40;

SELECT  * FROM dept_tmp2;

--dept 테이블에서 부서이름이 sales인 자료를 찾아 해당 부서 번호를 이용하여 dept_tmp2의
--테이블에 있는 자료의 지역명을 부산으로 변경한다


UPDATE dept_tmp2 SET loc = '부산' WHERE DEPTNO = (SELECT DEPTNO FROM dept WHERE dname = 'SALES'); 

SELECT * FROM dept_tmp2;

COMMIT;

-- 자료를 삭제할 때 delete 구문 사용
-- 해당 조건에 맞는 데이터들을 삭제함
--DELETE  FROM 테이블명 WHERE 조건

--삭제를 위한 임시 테이블 생성 emp_temp2
CREATE TABLE emp_tmp2 AS SELECT * FROM emp;

-- 직책이 MANAGER인 직원 조회
SELECT * FROM emp_tmp2 WHERE  job = 'MANAGER';

COMMIT;

DELETE FROM emp_tmp2 WHERE job = 'MANAGER';

SELECT * FROM emp_tmp2;

ROLLBACK;

COMMIT;

--부서 번호가 30이고 급여등급이 3인 직원을 삭제한다.

--DELETE FROM emp_tmp2 WHERE deptno = 30

SELECT 
*
FROM emp_tmp2 e JOIN SALGRADE s ON (e.sal BETWEEN s.LOSAL AND s.HISAL) WHERE deptno = 30 AND s.GRADE = 3;

DELETE FROM emp_tmp2 WHERE empno IN(
	SELECT 
		empno
FROM emp_tmp2 e JOIN SALGRADE s ON (e.sal BETWEEN s.LOSAL AND s.HISAL) WHERE deptno = 30 AND s.GRADE = 3
);


COMMIT;

DELETE FROM emp_tmp2;

SELECT * FROM emp_tmp2;

ROLLBACK;

-- 확인문제 풀기
CREATE TABLE CHAP10HW_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10HW_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10HW_SALGRADE AS SELECT * FROM SALGRADE;

COMMIT;

-- 1번 문제
SELECT * FROM CHAP10HW_DEPT;
INSERT INTO CHAP10HW_DEPT (deptno, dname, loc) VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10HW_DEPT (deptno, dname, loc) VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT (deptno, dname, loc) VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT (deptno, dname, loc) VALUES (80, 'DML', 'BUNDANG');


SELECT * FROM CHAP10HW_EMP;

INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7201,'TEST_USER1', 'MANAGER', 7788, '2016-01-02', 4500, NULL,50);

INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7202,'TEST_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL,50);

INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7203,'TEST_USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL,60);

INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7204,'TEST_USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300,60);


INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7205,'TEST_USER5', 'CLERK', 7201, '2016-07-20', 2600, null,70);


INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7206,'TEST_USER6', 'CLERK', 7201, '2016-09-08', 2600, null,70);

INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7207,'TEST_USER7', 'LECTURER', 7201, '2016-10-28', 2300, null,80);

INSERT INTO CHAP10HW_EMP 
(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
(7208,'TEST_USER8', 'STUDENT', 7201, '2018-03-09', 1200, null,80);

COMMIT;

UPDATE CHAP10HW_EMP SET (DEPTNO) = 70 
WHERE (
	SELECT * 
	FROM CHAP10HW_EMP
	WHERE SAL > (SELECT AVG(sal) FROM CHAP10HW_EMP WHERE DEPTNO = 50)); 

SELECT * 
	FROM CHAP10HW_EMP
	WHERE SAL > (SELECT AVG(sal) FROM CHAP10HW_EMP WHERE DEPTNO = 50);


-- 트랜젝션 (계좌 이체 느낌   




--SELECT * 
--	FROM CHAP10HW_EMP
--	WHERE SAL > (SELECT AVG(sal) FROM CHAP10HW_EMP WHERE DEPTNO = 50);
--SELECT * FROM CHAP10HW_EMP WHERE SAL > (SELECT AVG(sal) FROM CHAP10HW_EMP WHERE DEPTNO = 50);
--
--SELECT * FROM CHAP10HW_EMP;
--
--
--SELECT AVG(sal) FROM CHAP10HW_EMP WHERE DEPTNO = 50;

--3150


SELECT * FROM DEPT;

-- DDL
--CREATE TABLE 테이블명(
--	컬럼1 열_자료형,
--	컬럼2 열_자료형,
--	컬럼3 열_자료형,
--	컬럼4 열_자료형,
--)


CREATE TABLE EMP_HW(
	EMPNO NUMBER(4),
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

--테이블 EMP_HW 열에 BIGO라는 자료형의 가변형문자열 길이는 20 추가 
ALTER TABLE EMP_HW 
ADD BIGO VARCHAR(20);

SELECT * FROM EMP_HW;

--테이블 EMP_HW의 BIGO열의 자료형의 길이를 30으로 변경
ALTER TABLE EMP_HW 
MODIFY BIGO VARCHAR(30);

--EMP_HW 테이블의 이름을 REMARK로 변경
RENAME EMP_HW TO REMARK;

--EMP_HW 테이블 만들고 EMP 테이블의 데이터를 모두 저장해 봐라
CREATE TABLE EMP_HW AS SELECT * FROM EMP;

--EMP_HW 테이블에 REMOARK 열을 추가하고 자료형은 가변형문자, 길이는 20
ALTER TABLE EMP_HW ADD REMARK VARCHAR(20);

-- EMP_HW 테이블의 데이터를 모두 지워라
TRUNCATE  TABLE EMP_HW;

--EMP_HW 테이블을 삭제해라
DROP TABLE EMP_HW;

-- 존재하는 딕셔너리 확인 (전역변수로 봐주면 됨)
SELECT * FROM DICTIONARY ORDER BY TABLE_NAME ;
-- 내가 만든 테이블 정보
SELECT * FROM USER_TABLES;

SELECT * FROM ALL_TABLES;

--권한 가진 사용자만 조회 가능
--SELECT * FROM DBA_TABLES;
--SELECT * FROM DBA_USERS;
