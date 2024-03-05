
-- 런타임 오류
Declare
    v_wrong number;
begin
    Select dname into v_wrong FROM dept where deptno = 10;
end;


-- 예외 처리
-- '예외처리: 수치 또는 값 오류'
Declare
    v_wrong number;
begin
    Select dname into v_wrong FROM dept where deptno = 10;
       DBMS_OUTPUT.PUT_LINE('예외 발생하면 다음 문장은 실행되지 않음');
    
    Exception
        when VALUE_ERROR then
            DBMS_OUTPUT.PUT_LINE('예외처리: 수치 또는 값 오류');
end;


-- 예외 처리
--   DBMS_OUTPUT.PUT_LINE('예외 발생하면 다음 문장은 실행되지 않음');
Declare
    v_wrong number;
begin
    Select deptno into v_wrong FROM dept where deptno = 10;
       DBMS_OUTPUT.PUT_LINE('예외 발생하면 다음 문장은 실행되지 않음');
    
    Exception
        when VALUE_ERROR then
            DBMS_OUTPUT.PUT_LINE('예외처리: 수치 또는 값 오류');
end;


--TOO Many 에외
-- 결과는 10,20,30,40 4가지 인데 한가지 변수에 넣게 되서 예외 
Declare
    v_wrong number;
begin
    Select deptno into v_wrong FROM dept;
       DBMS_OUTPUT.PUT_LINE('예외 발생하면 다음 문장은 실행되지 않음');
    
    Exception
        when TOO_MANY_ROWS then
            DBMS_OUTPUT.PUT_LINE('예외처리: 요구 사항보다 많은 행 추출');
        when VALUE_ERROR then
            DBMS_OUTPUT.PUT_LINE('예외처리: 수치 또는 값 오류');
        when ohers then
            DBMS_OUTPUT.PUT_LINE('예외처리: 사전 정의 외 오류 발생');
            
end;


--code 오류 번호 반환, errm 오류메시지 반환 
Declare
    v_wrong number;
begin
    Select deptno into v_wrong FROM dept;
       DBMS_OUTPUT.PUT_LINE('예외 발생하면 다음 문장은 실행되지 않음');
    
    Exception
        when others then
            DBMS_OUTPUT.PUT_LINE('예외처리: 요구 사항보다 많은 행 추출');
            DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || to_chat(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLERRM);
            
end;



--명시적 커서를 사용하여 EMP 테이블의 전체 데이터를 조회한 후 커서 안의 데이터가 다음과 같이 출력되도록 PL/SQL문 작성해라

SET SERVEROUTPUT ON;

DECLARE
    V_EMP_ROW EMP&ROWTYPE;
    
    CURSOR c1 IS
        SELECT *
            FROM EMP;
            
    BEGIN
    OPEN c1;
    
    LOOP
        fetch c1 INTO V_EMP_ROW;
        
        EXIT WHEN c1%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(V_EMP_ROW.EMPNO, V_EMP_ROW.ENAME, V_EMP_ROW.JOB, V_EMP_ROW.CLERK, V_EMP_ROW.DEPtNO);
        
    END LOOP;
        
CLOSE c1;
        
  END;
/

    
    
DECLARE
 CURSOR c1 IS
 SELECT * FROM EMP;
 
 BEGIN
    FOR c1_rec IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE(c1_rec.empno, c1_rec.ename, c1_rec.job, c1_rec.sal, c1_rec.deptno);
    END LOOP;
END;
/



DECLARE
    v_wrong DATE;
    BEGIN
        SELECT ENAME INTO v_wrong
            FROM EMP
        WHERE EMPNO = 7369;
        DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
        
        
    EXCEPTION
    WHEN THERS THEN
    DBMS_OUTPUT.PUT_LINE('오규가 발생하였습니다.')
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM' || SQLERRM));
    END;
    /
    
    
    --계좌 관리 테이블 생성 
CREATE TABLE account (
   ano varchar2(20) PRIMARY key,
   owner varchar2(20) NOT null,
   balance NUMBER NOT NULL
);

--계좌 테이블에 자료 1건 등록 
insert INTO account VALUES ('111-11-1111', '홍길동', 1000);



declare 
     --잔고 저장 변수 
     v_balance number;
     
     --출금 할 금액 
     v_money number;
     
     --잔고 부족 예외 선언 
     INSUFFICIENT_EXCEPT EXCEPTION;
begin 
    -- 출금 할 금액 설정 
    v_money := 10000;
    
    --잔고를 얻는다 
    select balance into v_balance from account where ano='111-11-1111';    
    if v_balance - v_money < 0 then 
        --잔고 부족 예외 발생 
        raise INSUFFICIENT_EXCEPT;
    end if;
    --잔고 감소 
    update account set balance = balance - v_money where ano='111-11-1111';    
    
    DBMS_OUTPUT.PUT_LINE('정상 처리');
    
    Exception 
        when INSUFFICIENT_EXCEPT then 
            DBMS_OUTPUT.PUT_LINE('예외처리 : 잔고가 부족하여 출금을 할 수 없습니다');
        when others then 
            DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
            DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || to_char(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
end;


-- 저장 프로시저 생성
-- 한번 컴파일만 컴파일해서 유용  
CREATE OR REPLACE PROCEDURE PRO_PARAM_IN
(
	param1 IN NUMBER,
	param2 NUMBER,
	param3 NUMBER := 3,
	param4 NUMBER DEFAULT 4
)

IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
	DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
	DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
	DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;

/*
 * SQL> execute pro_param_in(1,2,9,8);
param1 : 1
param2 : 2
param3 : 9
param4 : 8


SQL> execute pro_param_in(1,2);  
param1 : 1
param2 : 2
param3 : 3
param4 : 4

SQL> execute pro_param_in(param1=>10,param2=>20);
param1 : 10
param2 : 20
param3 : 3
param4 : 4

SQL> execute pro_param_in(1);
BEGIN pro_param_in(1); END;

      *
ERROR at line 1:
ORA-06550: line 1, column 7:
PLS-00306: wrong number or types of arguments in call to 'PRO_PARAM_IN'
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored
 */

--프로시저 오류 확인
CREATE OR REPLACE PROCEDURE PRO_ERR
IS
	err_no NUMBER;
BEGIN
	err_no = 100;

	DBMS_OUTPUT.PUT_LINE('err-no' || err_no);
END ;

--오류 수정
CREATE OR REPLACE PROCEDURE PRO_ERR
IS
	err_no NUMBER;
BEGIN
	err_no = 100;

	DBMS_OUTPUT.PUT_LINE('err-no' || err_no);
END ;


-- 함수 세금을 제한 실수령액 함수를 이용해보기
CREATE OR REPLACE FUNCTION FUNC_AFTERTAX(
 sal IN NUMBER
) 
RETURN NUMBER
IS
	tax NUMBER := 0.05;

BEGIN
	RETURN (ROUND(sal - (sal * tax)));
END FUNC_AFTERTAX;

--함수 실행
SQL> DECLARE
  2  aftertax NUMBER;
  3  BEGIN
  4  aftertax := func_aftertax(3000);
  5  DBMS_OUTPUT.PUT_LINE('after-tax income: ' || aftertax);
  6  end;
  7  /
  
--after-tax income: 2850

--PL/SQL procedure successfully completed.
  
--  sql에서 함수 사용하기
SELECT func_aftertax(3000) FROM DUAL;
-- 함수에 정의한 파라미터와 자료형이 일치하면 내장 함수와 같이 특정 열 또는 연산 가공된 데이터 입력 가능 
SELECT EMPNO, ENAME, SAL, FUNC_AFTERTAX(SAL) AS AFtERTAX FROM EMP;
--함수 삭제
DROP FUNCTION func_aftertax;





--OUT 모드 파라미터 사용하기
DECLARE
	v_ename EMP.ENAME%TYPE;
	v_sal EMP.SAL%TYPE;
BEGIN
		pro_param_out(7788, v_ename,v_sal);
	DBMS_OUTPUT.PUT_LINE('ENAME: ' || v_ename);
	DBMS_OUTPUT.PUT_LINE('SAL: ' || v_sal);
END;

/*
 * SQL> DECLARE
  2  v_ename EMP.ENAME%TYPE;
  3  v_sal EMP.SAL%TYPE;
  4  BEGIN
  5  pro_param_out(7788, v_ename,v_sal);
  6  DBMS_OUTPUT.PUT_LINE('ENAME: ' || v_ename);
  7  DBMS_OUTPUT.PUT_LINE('SAL: ' || v_sal);
  8  end;
  9  /
ENAME: SCOTT
SAL: 3000

PL/SQL procedure successfully completed.
 */


--inout 모드 파라미터
CREATE OR REPLACE PROCEDURE PRO_PARAM_INOUT
(
	inout_no IN OUT NUMBER
)
IS
BEGIN
	inout_no := inout_no * 2;
END PRO_PARAM_INOUT;

--사용
DECLARE
	no NUMBER;
BEGIN
	no := 5;
	pro_param_inout(no);
	DBMS_OUTPUT.PUT_LINE('no: ' || no);
END;



DECLARE
	v_deptno DEPT.DEPTNO%TYPE;
	v_dname DEPT.DNAME%TYPE;
	v_loc DEPT.loc%TYPE;
BEGIN
	pro_dept_in(10,v_deptno,v_)
	
	
	
	
	
	
	create table users (
    userid varchar2(50) primary key,
    username varchar2(50) not null,
    userpassword varchar2(50) not null,
    userage number(3) not null,
    useremail varchar2(50) not null
);    
	
	
create table boards (
    bno number primary key,
    btitle varchar2(100) not null,
    bcontent clob not null,
    bwriter varchar2(50) not null,
    bdate date default sysdate
);
	

create SEQUENCE seq_bno nocache;