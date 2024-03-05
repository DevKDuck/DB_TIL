
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