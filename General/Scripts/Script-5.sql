--3월 4일

--사용자생성
CREATE USER orclstudy IDENTIFIED BY oracle;

-- 데이터 베이스 접속 권한을 줌
GRANT CREATE SESSION TO orclstudy;

SELECT * FROM all_users WHERE username = 'ORCLSTUDY';

SELECT * FROM all_users WHERE username = upper('orclstudy');

SELECT * FROM dba_users WHERE username = 'ORCLSTUDY';

SELECT * FROM dba_objects WHERE owner = 'ORCLSTUDY';


-- 비밀번호 변경
ALTER USER orclstudy IDENTIFIED BY 1004;

-- 계정 삭제


DROP USER orclstudy;

-- 안에 오브젝트가 있어도 다지워짐
DROP USER orclstudy CASCADE;

--orclstudy 객체에 emp 테이블 삽입권한 부여
GRANT SELECT, INSERT ON EMP TO ORCLSTUDY;


--PREV_HW 계정 생성 
CREATE USER PREV_HW IDENTIFIED BY ORCL;
--접속 권한 부여 
GRANT CREATE SESSION TO PREV_HW;

-- PREV_HW에 bituser emp, dept, salgrade 
GRANT SELECT ON EMP TO PREV_HW;
GRANT SELECT ON DEPT TO PREV_HW;
GRANT SELECT ON SALGRADE TO PREV_HW;

SELECT * FROM BITUSER.emp;
SELECT * FROM BITUSER.DEPT;
SELECT * FROM BITUSER.SALGRADE;

-- Bituser의 SALGRADE 테이블을 select 할 수 있는 PREV_HW 사용자의 권한을 취소
REVOKE SELECT ON SALGRADE FROM PREV_HW;
SELECT * FROM BITUSER.SALGRADE;

--PL/SQL
--DBeaver에서는 안되서 sqlplus 로 구현 
--SQL> SET SERVEROUTPUT on;
--SQL> begin
--  2  DBMS_OUTPUT.PUT_LINE('Hello World~~');                             
--  3  end;
--  4  /
--Hello World~~
--
--PL/SQL procedure successfully completed.


EXEC pro_noparam;

create or replace PROCEDURE PRO_NOPARAM
IS
--지역 변수 선언하는 곳 
v_empno number(4) := 7788;
v_ename varchar2(10);
--상수 선언 
c_tax constant number(1) := 3;
begin
v_ename := '홍길동';
--이부분은 주석으로 실행 안됨
DBMS_OUTPUT.PUT_LINE('v_empno : ' || v_empno);
DBMS_OUTPUT.PUT_LINE('v_ename : ' || v_ename);
DBMS_OUTPUT.PUT_LINE('c_tax : ' || c_tax);
END PRO_NOPARAM;


DECLARE

--변수 및 초기값 선언
v_deptno NUMBER(2) := 10;
v_deptno2 NUMBER(2) default 10;

v_empno number(4) := 7788;
v_ename varchar2(10);

--상수 선언
c_tax constant number(1) := 3;
BEGIN
	v_ename := '홍길';


--null 값을 설정 할 수 없음 (논리 오류)
-- v_deptno2 := NULL;
END


declare 
    type my_dept is record (
        deptno number(2) not null := 99,
        dname dept.dname%type,
        loc dept.loc%type
    );
    --코드형 변수 선언 
    v_dept my_dept;
begin 
    --선언된 변수에 값 설정 
    v_dept.deptno := 90;
    v_dept.dname := 'DATABASE';
    v_dept.loc := '서울';
    --디버깅용 메시지 출력 
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || v_dept.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || v_dept.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || v_dept.loc);
    
    --dept_record 테이블에 값을 추가 
    /* 
    insert into dept_record (
        deptno, dname, loc
    ) values (
        v_dept.deptno, v_dept.dname, v_dept.loc);
     */   
    insert into dept_record values v_dept;
end;



declare 
    type my_dept is record (
        deptno number(2) not null := 99,
        dname dept.dname%type,
        loc dept.loc%type
    );
    --코드형 변수 선언 
    v_dept my_dept;
begin 
    select deptno, dname, loc
    from dept
    where deptno = 10;
    
    --선언된 변수에 값 설정 
    --v_dept.deptno := 50;
    --v_dept.dname := 'DB';
    --v_dept.loc := '인천';
    --디버깅용 메시지 출력 
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || v_dept.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || v_dept.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || v_dept.loc);
    
    --dept_record 테이블에 값을 추가 
    /* 
    insert into dept_record (
        deptno, dname, loc
    ) values (
        v_dept.deptno, v_dept.dname, v_dept.loc);
     */   
    --insert into dept_record values v_dept;
    /*    
    update dept_record set 
        row = v_dept
    where deptno=90;
    */
    
    
end;


create table dept_record as
    select * from dept;
    





